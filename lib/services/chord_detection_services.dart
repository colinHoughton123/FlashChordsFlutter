// THIS FILE IS NO LONGER NEEDED / USED
import 'dart:async';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:record/record.dart';
import 'package:fftea/fftea.dart';
import 'package:flashchords/core/system_error_code.dart';

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
  static final ChordDetectionService instance = ChordDetectionService._internal();

  // ------------------------------------------------------------
  // Public helpers
  // ------------------------------------------------------------




  bool matchesTarget({
    required Set<String> detected,
    required Set<String> target,
  }) {
    return detected.containsAll(target);
  }

  Future<void> reset() async {
    debugPrint('🎙 Resetting audio engine');

    _isRunning = false;
    _startFuture = null;

    _lastStable.clear();
    _stableCount = 0;
    _cooldownFrames = 0;
    _sampleBuffer.clear();

    // Candidate timing (NEW)
    _armedTarget = null;
    _armedPrevious = null;
    _candidateStartedAt = null;
    _candidateOkFrames = 0;
  

    await _audioSub?.cancel();
    _audioSub = null;

    try {
      await _recorder.stop();
    } catch (_) {}

    debugPrint('🎙 Audio engine reset complete');
  }

  // ------------------------------------------------------------
  // State
  // ------------------------------------------------------------

  // ------------------------------------------------------------
  // Chord timing / candidate state (NEW)
  // ------------------------------------------------------------

  DateTime? _firstCorrectFrameAt;

  Set<String>? _armedTarget;
  Set<String>? _armedPrevious;

  DateTime? _candidateStartedAt;
  int _candidateOkFrames = 0;

  // How many consecutive “candidate OK” frames before we consider it fair to start charging time
  static const int _requiredCandidateFrames = 2;

  // The “fair” elapsed we computed for the next emitted match.
  // FlashcardScreen reads this via evaluateCandidate(detected).
 

  final AudioRecorder _recorder = AudioRecorder();
  StreamSubscription<Uint8List>? _audioSub;

  bool _isRunning = false;
  Future<void>? _startFuture;

  ListenerComparisonMode comparisonMode = ListenerComparisonMode.forgiving;

  final StreamController<Set<String>> _detectedNotesController =
      StreamController<Set<String>>.broadcast();
  Stream<Set<String>> get detectedNotesStream => _detectedNotesController.stream;

  final StreamController<DetectedNotesFrame> _detectedFrameController =
      StreamController<DetectedNotesFrame>.broadcast();
  Stream<DetectedNotesFrame> get detectedFrameStream => _detectedFrameController.stream;

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
        throw const SystemErrorCode(101);
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
            onError: (_, __) {
              throw const SystemErrorCode(103);
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

      debugPrint('Audio init failed: $lastError');
      throw const SystemErrorCode(102);
    } catch (e) {
      if (e.toString().contains('ERR_')) rethrow;
      throw const SystemErrorCode(201);
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
  // Public API (NEW)
  // ------------------------------------------------------------

  /// Call this each time a new card becomes active.
void armForChord(Set<String> targetNotes, {Set<String>? previousChordNotes}) {
  _armedTarget = Set.of(targetNotes);
  _armedPrevious = previousChordNotes != null
      ? Set.of(previousChordNotes)
      : null;

  _candidateStartedAt = null;
  _firstCorrectFrameAt = null;
  _candidateOkFrames = 0;
}

DateTime? evaluateCandidate(Set<String> detected) {
  if (_armedTarget == null) return null;

  // 1️⃣ Must contain all target notes
  if (!detected.containsAll(_armedTarget!)) {
    _candidateStartedAt = null;
    _firstCorrectFrameAt = null;
    _candidateOkFrames = 0;
    return null;
  }

  // 2️⃣ First correct frame → capture reaction time anchor
  _firstCorrectFrameAt ??= DateTime.now();

  // 3️⃣ Stability tracking
  if (_candidateStartedAt == null) {
    _candidateStartedAt = DateTime.now();
    _candidateOkFrames = 1;
    return null;
  }

  _candidateOkFrames++;

  // 4️⃣ Confirm after enough stable frames
  if (_candidateOkFrames >= _requiredCandidateFrames) {
  final confirmedAt = _firstCorrectFrameAt;

  debugPrint(
    '⏱ CANDIDATE CONFIRMED '
    '| at=${confirmedAt?.toIso8601String()} '
    '| frames=$_candidateOkFrames',
  );

  // Reset for next card
  _candidateStartedAt = null;
  _firstCorrectFrameAt = null;
  _candidateOkFrames = 0;

  return confirmedAt;
}

  return null;
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

      // Use target length if armed, otherwise default to 4 to keep behaviour similar
      final maxNotes = (_armedTarget?.length ?? 4);
      final detected = _topPitchClasses(pcRaw, maxNotes: maxNotes);

      // Emit debug frame for overlay
      _detectedFrameController.add(
        DetectedNotesFrame(
          at: DateTime.now(),
          sampleRate: _activeSampleRate,
          raw: pcRaw,
          filtered: pcRaw,
          emitted: detected,
        ),
      );

      // Candidate tracking happens regardless of stability/cooldown
      _updateCandidateTracking(detected);

      if (_cooldownFrames > 0) {
        _cooldownFrames--;
        continue;
      }

      final requiredStableFrames = detected.length >= 4 ? 2 : 3;

      if (_setsEqual(detected, _lastStable)) {
        _stableCount++;
      } else {
        _lastStable = detected;
        _stableCount = 1;
      }

      //debugPrint(
      //  '🎧 FRAME det=${detected.join(",")} '
      //  'stable=$_stableCount cooldown=$_cooldownFrames',
      //);

      if (_stableCount >= requiredStableFrames && detected.isNotEmpty) {
        // If we currently have a valid candidate running, capture fair elapsed now.
        

        // debugPrint('🎯 EMIT detected=${detected.join(",")}');
        _detectedNotesController.add(detected);

        _sampleBuffer.clear();
        _lastStable = <String>{};
        _stableCount = 0;
        _cooldownFrames = 8;
      }
    }
  }

  // ------------------------------------------------------------
  // Candidate timing internals (NEW)
  // ------------------------------------------------------------

  void _updateCandidateTracking(Set<String> detected) {
    if (_armedTarget == null) {
      _candidateStartedAt = null;
      _candidateOkFrames = 0;
      return;
    }

    // 1) Superset OK
    if (!detected.containsAll(_armedTarget!)) {
      _candidateStartedAt = null;
      _candidateOkFrames = 0;
      return;
    }

    // 2) Release safety: candidate must not include notes from previous chord that are NOT in target
    if (_armedPrevious != null) {
      final illegalCarry =
          detected.difference(_armedTarget!).intersection(_armedPrevious!);
      if (illegalCarry.isNotEmpty) {
        _candidateStartedAt = null;
        _candidateOkFrames = 0;
        return;
      }
    }

    // Candidate OK this frame
    _candidateStartedAt ??= DateTime.now();
    _candidateOkFrames++;
  }


  // ------------------------------------------------------------
  // FFT → pitch classes
  // ------------------------------------------------------------

  Map<String, double> _detectPitchClassesWithEnergy(List<double> chunk) {
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
    if (pcMags.isEmpty) return <String>{};

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

    final minBin = (minHz * _fftSize / _activeSampleRate).floor();
    final maxBin = (maxHz * _fftSize / _activeSampleRate).ceil();

    for (int i = minBin; i <= maxBin; i++) {
      final m = magnitudes[i];
      if (m < magThreshold) continue;
      if (m > magnitudes[i - 1] && m > magnitudes[i + 1]) {
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
    final note = 69 + 12 * (math.log(freq / 440) / math.ln2);
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