import 'dart:async';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:record/record.dart';
import 'package:fftea/fftea.dart';

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


  bool get isRunning => _isRunning;

  bool matchesTarget({
    required Set<String> detected,
    required Set<String> target,
  }) {
    return detected.containsAll(target);
  }


void prepareForNextCard() {
  // Clears candidate/stability state only.
  // Does NOT stop audio, does NOT change armed target.
  debugPrint('🧹 prepareForNextCard()');

  _lastStable.clear();
  _stableCount = 0;
  _cooldownFrames = 0;
  _sampleBuffer.clear();

  _candidateStartedAt = null;
  _candidateOkFrames = 0;
  _firstCorrectFrameAt = null;
}

  // ------------------------------------------------------------
  // State
  // ------------------------------------------------------------

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
  // Candidate / timing state
  // ------------------------------------------------------------

  DateTime? _firstCorrectFrameAt;

  Set<String>? _armedTarget;
  Set<String>? _armedPrevious;

  DateTime? _candidateStartedAt;
  int _candidateOkFrames = 0;

  static const int _requiredCandidateFrames = 2;

  // ------------------------------------------------------------
  // Lifecycle-safe API
  // ------------------------------------------------------------

  /// IMPORTANT: This function is now "fail-safe".
  /// If mic init fails (permission/session/etc), we do NOT throw.
  /// We simply don't start listening, and the app keeps running.
  Future<void> start() {




  // If we *think* we’re running, or we have a stale start in flight,
  // force a cleanup to avoid iOS abort on relaunch.
  if (_isRunning || _startFuture != null) {
    debugPrint('⚠️ start(): stale running state detected; forcing hardStop()');
    _startFuture = hardStop(clearState: true).then((_) => _startImpl());
    return _startFuture!;
  }

  _startFuture = _startImpl();
  return _startFuture!;
}

/// Hard, idempotent shutdown of ALL native + stream state.
/// Safe to call multiple times.
Future<void> hardStop({bool clearState = true}) async {
  debugPrint('🛑 HARD STOP audio engine (clearState=$clearState)');

  // Make future callers not think we’re mid-start.
  _startFuture = null;

  // Mark not running immediately to stop processing loops fast.
  _isRunning = false;

  // Cancel the audio stream subscription first.
  try {
    await _audioSub?.cancel();
  } catch (_) {}
  _audioSub = null;

  // Stop the recorder (native resources)
  try {
    await _recorder.stop();
  } catch (_) {}

  // Clear buffers / candidate state so next launch is clean.
  if (clearState) {
    try {
      _lastStable.clear();
      _stableCount = 0;
      _cooldownFrames = 0;
      _sampleBuffer.clear();

      _candidateStartedAt = null;
      _candidateOkFrames = 0;
      _firstCorrectFrameAt = null;

      // IMPORTANT: do NOT null out armed target unless you truly want to.
      // If you want to keep "armed target" across pauses, leave them.
      // If you want it fully reset, uncomment:
      // _armedTarget = null;
      // _armedPrevious = null;
    } catch (_) {}
  }

  debugPrint('🛑 HARD STOP complete');
}


  Future<void> _startImpl() async {
    try {
      // If a previous run left the system in a weird state, clean it first.
      await _safeStopInternal(clearState: true);

      final hasPermission = await _recorder.hasPermission();
      if (!hasPermission) {
        debugPrint('🎙 No microphone permission. Not starting audio.');
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
          _activeSampleRate = cfg.sampleRate ?? 44100;

          final stream = await _recorder.startStream(cfg);

          _audioSub = stream.listen(
            _onAudioData,
            onError: (e, st) {
              debugPrint('🎙 Audio stream error: $e');
              // Don't crash. Stop safely.
              unawaited(_safeStopInternal(clearState: true));
            },
            cancelOnError: true,
          );

          _isRunning = true;
          debugPrint('🎙 Audio started @ $_activeSampleRate Hz');

          return;
        } catch (e) {
          lastError = e;
          debugPrint('🎙 startStream failed for ${cfg.sampleRate}: $e');
          try {
            await _recorder.stop();
          } catch (_) {}
        }
      }

      debugPrint('🎙 Audio init failed (all configs). lastError=$lastError');
      // fail-safe: do not throw
      return;
    } catch (e, st) {
      debugPrint('🎙 Audio init exception: $e\n$st');
      // fail-safe: do not throw
      return;
    } finally {
      if (!_isRunning) _startFuture = null;
    }
  }




  Future<void> stop() => _safeStopInternal(clearState: false);

  Future<void> reset() => _safeStopInternal(clearState: true);

  Future<void> _safeStopInternal({required bool clearState}) async {
    _isRunning = false;
    _startFuture = null;

    await _audioSub?.cancel();
    _audioSub = null;

    try {
      await _recorder.stop();
    } catch (_) {}

    if (clearState) {
      _lastStable.clear();
      _stableCount = 0;
      _cooldownFrames = 0;
      _sampleBuffer.clear();

      //_armedTarget = null;
      //_armedPrevious = null;
      _candidateStartedAt = null;
      _candidateOkFrames = 0;

      _firstCorrectFrameAt = null;
    }
  }

  void dispose() {
    unawaited(_safeStopInternal(clearState: true));
    _detectedNotesController.close();
    _detectedFrameController.close();
  }

  // ------------------------------------------------------------
  // Public API (card timing)
  // ------------------------------------------------------------

  void armForChord(Set<String> targetNotes, {Set<String>? previousChordNotes}) {
    
      debugPrint(
    '🎼 ARM target=${targetNotes.join(",")} '
    'prev=${previousChordNotes?.join(",") ?? "-"}'
  );

    _armedTarget = Set.of(targetNotes);
    _armedPrevious = previousChordNotes != null ? Set.of(previousChordNotes) : null;
    _candidateStartedAt = null;
    _firstCorrectFrameAt = null;
    _candidateOkFrames = 0;
  }

  DateTime? evaluateCandidate(Set<String> detected) {

    if (_armedTarget == null) {
  debugPrint('⛔ evaluateCandidate called with NO ARM');
  return null;
}


    if (_armedTarget == null) return null;

    if (!detected.containsAll(_armedTarget!)) {
      _candidateStartedAt = null;
      _firstCorrectFrameAt = null;
      _candidateOkFrames = 0;
      return null;
    }

    _firstCorrectFrameAt ??= DateTime.now();

    if (_candidateStartedAt == null) {
      _candidateStartedAt = DateTime.now();
      _candidateOkFrames = 1;
      return null;
    }


    debugPrint(
      '⏱ CANDIDATE OK '
      'frames=$_candidateOkFrames '
      'det=${detected.join(",")}'
    );


    _candidateOkFrames++;

    if (_candidateOkFrames >= _requiredCandidateFrames) {
      final confirmedAt = _firstCorrectFrameAt;

      _candidateStartedAt = null;
      _firstCorrectFrameAt = null;
      _candidateOkFrames = 0;
debugPrint('✅ CANDIDATE CONFIRMED after candidateOKFrames incremented ');
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
      final maxNotes = (_armedTarget?.length ?? 4);
      final detected = _topPitchClasses(pcRaw, maxNotes: maxNotes);

      debugPrint(
        '🎧 FRAME det=${detected.join(",")} '
        'armed=${_armedTarget?.join(",") ?? "NONE"}'
      );

      _detectedFrameController.add(
        DetectedNotesFrame(
          at: DateTime.now(),
          sampleRate: _activeSampleRate,
          raw: pcRaw,
          filtered: pcRaw,
          emitted: detected,
        ),
      );

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

      if (_stableCount >= requiredStableFrames && detected.isNotEmpty) {
        _detectedNotesController.add(detected);

        _sampleBuffer.clear();
        _lastStable = <String>{};
        _stableCount = 0;
        _cooldownFrames = 8;
      }
    }
  }

  void _updateCandidateTracking(Set<String> detected) {
    if (_armedTarget == null) {
      _candidateStartedAt = null;
      _candidateOkFrames = 0;
      return;
    }

    if (!detected.containsAll(_armedTarget!)) {
      _candidateStartedAt = null;
      _candidateOkFrames = 0;
      return;
    }

    if (_armedPrevious != null) {
      final illegalCarry =
          detected.difference(_armedTarget!).intersection(_armedPrevious!);
      if (illegalCarry.isNotEmpty) {
        _candidateStartedAt = null;
        _candidateOkFrames = 0;
        return;
      }
    }

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
        peaks.add(_Peak(
          freq: i * _activeSampleRate / _fftSize,
          mag: m,
        ));
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