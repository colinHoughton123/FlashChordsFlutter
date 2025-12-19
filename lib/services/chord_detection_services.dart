import 'dart:async';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:record/record.dart';
import 'package:fftea/fftea.dart';
import 'package:flashchords/core/system_error.dart';



/// How strictly detected notes are compared to the target chord
enum ListenerComparisonMode {
  forgiving,
  strict,
}

/// Debug frame emitted for overlay / diagnostics.
class DetectedNotesFrame {
  final DateTime at;
  final int sampleRate;
  final Map<String, double> raw;
  final Map<String, double> filtered;
  final Set<String> emitted;

  const DetectedNotesFrame({
    required this.at,
    required this.sampleRate,
    required this.raw,
    required this.filtered,
    required this.emitted,
  });
}

class ChordDetectionService {
  ChordDetectionService._internal();
  static final ChordDetectionService instance =
      ChordDetectionService._internal();

  // ---------------
  // 
  // 

bool matchesTarget({
  required Set<String> detected,
  required Set<String> target,
}) {
  // forgiving match: target ⊆ detected
  return detected.containsAll(target);
}




  // --------------------------------------------
  // State
  // ------------------------------------------------------------

  final AudioRecorder _recorder = AudioRecorder();
  StreamSubscription<Uint8List>? _audioSub;

  bool _isRunning = false;
  Future<void>? _startFuture;

  ListenerComparisonMode comparisonMode = ListenerComparisonMode.forgiving;

  final StreamController<Set<String>> _detectedNotesController =
      StreamController<Set<String>>.broadcast();
  Stream<Set<String>> get detectedNotesStream =>
      _detectedNotesController.stream;

  final StreamController<DetectedNotesFrame> _detectedFrameController =
      StreamController<DetectedNotesFrame>.broadcast();
  Stream<DetectedNotesFrame> get detectedFrameStream =>
      _detectedFrameController.stream;

  // ------------------------------------------------------------
  // Audio / FFT configuration
  // ------------------------------------------------------------

  static const int _fftSize = 8192;
  static const int _hopSize = _fftSize ~/ 2;

  int _activeSampleRate = 44100;
  late final STFT _stft = STFT(_fftSize, Window.hanning(_fftSize));

  final List<double> _sampleBuffer = <double>[];

  Set<String> _lastStable = <String>{};
  int _stableCount = 0;
  int _cooldownFrames = 0;

  static const double _minAbsoluteMag = 0.02;

  // ------------------------------------------------------------
  // Lifecycle
  // ------------------------------------------------------------

  Future<void> start() {
    if (_isRunning) return Future.value();
    if (_startFuture != null) return _startFuture!;

    _startFuture = _startImpl();
    return _startFuture!;
  }

  Future<void> _startImpl() async {
    try {
      final hasPermission = await _recorder.hasPermission();
      if (!hasPermission) {
        SystemError.report(101);
        return;
      }

      final configs = <RecordConfig>[
        const RecordConfig(
          encoder: AudioEncoder.pcm16bits,
          sampleRate: 48000,
          numChannels: 1,
        ),
        const RecordConfig(
          encoder: AudioEncoder.pcm16bits,
          sampleRate: 44100,
          numChannels: 1,
        ),
      ];

      Object? lastError;

      for (final cfg in configs) {
        try {
          _activeSampleRate = cfg.sampleRate!;
          final stream = await _recorder.startStream(cfg);

          _audioSub = stream.listen(
            _onAudioData,
            onError: (e, st) {
              SystemError.report(103);
            },
          );

          _isRunning = true;
          return;
        } catch (e) {
          lastError = e;
          try {
            await _recorder.stop();
          } catch (_) {}
        }
      }

      SystemError.report(102);
      debugPrint('Audio init failed: $lastError');
    } catch (_) {
      SystemError.report(201);
    } finally {
      if (!_isRunning) _startFuture = null;
    }
  }

  Future<void> stop() async {
    if (!_isRunning) return;
    _isRunning = false;

    await _audioSub?.cancel();
    _audioSub = null;

    try {
      await _recorder.stop();
    } catch (_) {}
  }

  void dispose() {
    _audioSub?.cancel();
    _detectedNotesController.close();
    _detectedFrameController.close();
  }

  // ------------------------------------------------------------
  // Audio processing
  // ------------------------------------------------------------

  void _onAudioData(Uint8List buffer) {
    if (!_isRunning) return;

    final samples = _pcm16ToDoubles(buffer);
    if (samples.isEmpty) return;

    _sampleBuffer.addAll(samples);

    while (_sampleBuffer.length >= _fftSize) {
      final chunk = _sampleBuffer.sublist(0, _fftSize);
      _sampleBuffer.removeRange(0, _hopSize);

      final pcRaw = _detectPitchClassesWithEnergy(chunk);
      final detected = _topPitchClasses(pcRaw, maxNotes: 4);

      _detectedFrameController.add(
        DetectedNotesFrame(
          at: DateTime.now(),
          sampleRate: _activeSampleRate,
          raw: pcRaw,
          filtered: pcRaw,
          emitted: detected,
        ),
      );

      if (_cooldownFrames > 0) {
        _cooldownFrames--;
        continue;
      }

      final requiredStableFrames =
          detected.length >= 4 ? 2 : 3;

      if (_setsEqual(detected, _lastStable)) {
        _stableCount++;
      } else {
        _lastStable = detected;
        _stableCount = 1;
      }

      if (_stableCount >= requiredStableFrames &&
          detected.isNotEmpty) {
        _detectedNotesController.add(detected);

        _sampleBuffer.clear();
        _lastStable = {};
        _stableCount = 0;
        _cooldownFrames = 8;
      }
    }
  }

  // ------------------------------------------------------------
  // FFT → pitch classes
  // ------------------------------------------------------------

  Map<String, double> _detectPitchClassesWithEnergy(
      List<double> chunk) {
    Float64List? mags;

    _stft.run(chunk, (Float64x2List freq) {
      mags = freq.discardConjugates().magnitudes();
    });

    if (mags == null) return const {};

    final peaks = _findPeaks(
      mags!,
      minHz: 80,
      maxHz: 2000,
      maxPeaks: 40,
      magThreshold: _minAbsoluteMag,
    );

    final pcEnergy = <String, double>{};
    for (final p in peaks) {
      final pc = _freqToPitchClass(p.freq);
      if (pc == null) continue;
      pcEnergy[pc] = (pcEnergy[pc] ?? 0) + p.mag;
    }

    return pcEnergy;
  }

  Set<String> _topPitchClasses(
    Map<String, double> pcMags, {
    required int maxNotes,
  }) {
    if (pcMags.isEmpty) return {};

    final entries = pcMags.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return entries.take(maxNotes).map((e) => e.key).toSet();
  }

  // ------------------------------------------------------------
  // Helpers
  // ------------------------------------------------------------

  List<double> _pcm16ToDoubles(Uint8List bytes) {
    final len = bytes.length - (bytes.length % 2);
    if (len <= 0) return const [];

    final out = List<double>.filled(len ~/ 2, 0.0);
    for (int i = 0, j = 0; i < len; i += 2, j++) {
      int v = (bytes[i + 1] << 8) | bytes[i];
      if (v >= 0x8000) v -= 0x10000;
      out[j] = v / 32768.0;
    }
    return out;
  }

  List<_Peak> _findPeaks(
    Float64List magnitudes, {
    required double minHz,
    required double maxHz,
    required int maxPeaks,
    required double magThreshold,
  }) {
    final peaks = <_Peak>[];

    final minBin =
        (minHz * _fftSize / _activeSampleRate).floor();
    final maxBin =
        (maxHz * _fftSize / _activeSampleRate).ceil();

    for (int i = minBin; i <= maxBin; i++) {
      final m = magnitudes[i];
      if (m < magThreshold) continue;
      if (m > magnitudes[i - 1] &&
          m > magnitudes[i + 1]) {
        peaks.add(
          _Peak(
            freq: i * _activeSampleRate / _fftSize,
            mag: m,
          ),
        );
      }
    }

    peaks.sort((a, b) => b.mag.compareTo(a.mag));
    return peaks.take(maxPeaks).toList();
  }

  String? _freqToPitchClass(double freq) {
    if (freq <= 0) return null;
    final note =
        69 + 12 * (math.log(freq / 440) / math.ln2);
    const pcs = [
      'C', 'C#', 'D', 'D#', 'E', 'F',
      'F#', 'G', 'G#', 'A', 'A#', 'B'
    ];
    return pcs[note.round() % 12];
  }

  bool _setsEqual(Set<String> a, Set<String> b) =>
      a.length == b.length && a.containsAll(b);
}

class _Peak {
  final double freq;
  final double mag;
  const _Peak({required this.freq, required this.mag});
}