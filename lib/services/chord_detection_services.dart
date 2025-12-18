import 'dart:async';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:record/record.dart';
import 'package:fftea/fftea.dart';

/// How strictly detected notes are compared to the target chord
enum ListenerComparisonMode {
  forgiving, // target ⊆ detected (extras allowed)
  strict,    // exact match (no extras, no missing)
}

/// Debug frame emitted for overlay / diagnostics.
/// - raw: pitch classes before energy filtering (with magnitude)
/// - filtered: pitch classes after energy filtering (with magnitude)
/// - emitted: the Set<String> sent to detectedNotesStream
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

/// Service responsible for microphone listening and chord detection.
/// Emits detected pitch-class sets like {"C", "E", "G"}.
class ChordDetectionService {

  
  ChordDetectionService._internal();
  static final ChordDetectionService instance =
      ChordDetectionService._internal();


// ------------------------------------------------------------
// Weak-note persistence (desktop harmonic masking fix)
// ------------------------------------------------------------

// Tracks how many consecutive frames a pitch-class appears in
final Map<String, int> _pcPersistence = <String, int>{};

// Number of consecutive frames required to accept a weak note
static const int _persistenceFrames = 4;


  // ------------------------------------------------------------
  // State
  // ------------------------------------------------------------

  final AudioRecorder _recorder = AudioRecorder();
  StreamSubscription<Uint8List>? _audioSub;

  bool _isRunning = false;
  Future<void>? _startFuture;

  ListenerComparisonMode comparisonMode = ListenerComparisonMode.forgiving;

  // Existing stream (keeps your screen code unchanged)
  final StreamController<Set<String>> _detectedNotesController =
      StreamController<Set<String>>.broadcast();
  Stream<Set<String>> get detectedNotesStream => _detectedNotesController.stream;

  // NEW: debug stream for overlay (optional to subscribe)
  final StreamController<DetectedNotesFrame> _detectedFrameController =
      StreamController<DetectedNotesFrame>.broadcast();
  Stream<DetectedNotesFrame> get detectedFrameStream =>
      _detectedFrameController.stream;

  // ------------------------------------------------------------
  // Audio / FFT configuration
  // ------------------------------------------------------------


static const int _requiredStableFrames = 3;

  static const int _fftSize = 8192;
  static const int _hopSize = _fftSize ~/ 2;

  /// IMPORTANT: sample rate can vary based on what config succeeds.
  int _activeSampleRate = 44100;

  late final STFT _stft = STFT(_fftSize, Window.hanning(_fftSize));

  final List<double> _sampleBuffer = <double>[];

  // Stability / debouncing
  Set<String> _lastStable = <String>{};
  int _stableCount = 0;
  int _cooldownFrames = 0;

  // ------------------------------------------------------------
  // Energy-weighted note filtering (key new feature)
  // ------------------------------------------------------------

  /// A detected pitch class is considered "intentionally played" only if:
  ///   mag >= maxMag * _intentionalRatio
  ///
  /// 0.35 is a good starting point for piano; tweak 0.30–0.45 if needed.
  static const double _intentionalRatio = 0.35;

  /// Additional absolute floor to suppress very weak noise.
  /// If you notice you miss quiet notes, lower this a bit.
  static const double _minAbsoluteMag = 0.02;

  // ------------------------------------------------------------
  // Lifecycle
  // ------------------------------------------------------------

  /// Safe, idempotent start.
  /// - If already running: returns immediately.
  /// - If a start is in progress: returns the same Future.
  Future<void> start() {
    if (_isRunning) return Future.value();
    if (_startFuture != null) return _startFuture!;

    debugPrint('🎙 start() BEGIN');
    _startFuture = _startImpl();
    return _startFuture!;
  }

  Future<void> _startImpl() async {
    try {
      final hasPermission = await _recorder.hasPermission();
      if (!hasPermission) {
        throw Exception('Microphone permission not granted');
      }

      // Try configs in order. macOS often prefers 48k, but some devices prefer 44.1k.
      // Final fallback: omit sampleRate and let the platform choose.
      final configs = <RecordConfig>[
        
          
         // Prefer 48k on macOS
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
          debugPrint(
            '🎙 start() trying cfg: sr=${cfg.sampleRate ?? "platform"} ch=${cfg.numChannels} enc=${cfg.encoder}',
          );

          // Best guess for our FFT conversions:
          //_activeSampleRate = cfg.sampleRate ?? 44100;
          _activeSampleRate = cfg.sampleRate!; // now always non-null

          final stream = await _recorder.startStream(cfg);

          _audioSub = stream.listen(
            _onAudioData,
            onError: (e, st) {
              debugPrint('🎙 audio stream error: $e');
            },
          );

          _isRunning = true;
          debugPrint('🎙 start() SUCCESS (sr=$_activeSampleRate)');
          return;
        } catch (e) {
          lastError = e;
          debugPrint('🎙 start() cfg failed: $e');

          // Ensure recorder is stopped before trying next config.
          try {
            await _recorder.stop();
          } catch (_) {}
        }
      }

      throw lastError ?? Exception('Failed to start recorder (unknown)');
    } catch (e) {
      debugPrint('🎙 start() FAILED: $e');
      rethrow;
    } finally {
      // Allow retry if start failed.
      if (!_isRunning) _startFuture = null;
    }
  }

  /// Safe, idempotent stop.
  Future<void> stop() async {
    if (!_isRunning) return;

    debugPrint('🎙 stop()');
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

    if (buffer.isNotEmpty) {
    // debugPrint('🎙 first bytes: ${buffer[0]}, ${buffer[1]}, ${buffer[2]}, ${buffer[3]}');
  }

    // 🔍 RAW BYTES CHECK — BEFORE any conversion
  if (buffer.isNotEmpty) {
    final nonZero = buffer.any((b) => b != 0);
    //debugPrint(
    //  '🎙 RAW buffer: nonZero=$nonZero '
    //  'firstBytes=${buffer.take(8).toList()}'
    // );
  }


    double rms(List<double> x) =>
    math.sqrt(x.map((v) => v * v).reduce((a, b) => a + b) / x.length);


    if (!_isRunning) return; 
     // debugPrint('🎧 AUDIO bytes=${buffer.length}');
    final samples = _pcm16ToDoubles(buffer);
    if (samples.isEmpty) return;

    _sampleBuffer.addAll(samples);
while (_sampleBuffer.length >= _fftSize) {
  final chunk = _sampleBuffer.sublist(0, _fftSize);
  _sampleBuffer.removeRange(0, _hopSize);

// 1) Detect pitch classes with energy
final pcMagsRaw = _detectPitchClassesWithEnergy(chunk);

// 2) Prune weak harmonic clutter
final pcMags = _pruneWeakHarmonics(pcMagsRaw, floorRatio: 0.28);

// 3) Keep only the top N pitch-classes
final detected = _topPitchClasses(pcMags, maxNotes: 4);

debugPrint('RAW DETECT size=${pcMagsRaw.length} -> ${pcMagsRaw.keys.join(",")}');
debugPrint('PRUNED size=${pcMags.length} -> ${pcMags.keys.join(",")}');
debugPrint('DETECTED=${detected.join(",")} stable=$_stableCount');

  // Debug frame (raw == filtered for now; we want stability first)
  _detectedFrameController.add(
    DetectedNotesFrame(
      at: DateTime.now(),
      sampleRate: _activeSampleRate,
      raw: pcMags,
      filtered: pcMags,
      emitted: detected,
    ),
  );

  // 2) Cooldown
  if (_cooldownFrames > 0) {
    _cooldownFrames--;
    continue;
  }



// 3) Stability
if (_setsEqual(detected, _lastStable)) {
  _stableCount++;
} else {
  _lastStable = detected;
  _stableCount = 1;
}


//t this is a git test.

  // 3) Stability
// 3) Stability
final requiredStableFrames = detected.length >= 4 ? 2 : 3;

if (_setsEqual(detected, _lastStable)) {
  _stableCount++;
} else {
  _lastStable = detected;
  _stableCount = 1;
}
  // 4) Emit

  // int requiredStableFrames = 3;



       // 4) Emit
          if (_stableCount >= requiredStableFrames && detected.isNotEmpty) {
            debugPrint('NOTESET IN ONAudio: ${detected.join(", ")}');
            _detectedNotesController.add(detected);

            // 🔹 MATCH FOUND → RESET STATE
            _sampleBuffer.clear();
            _lastStable = {};
            _stableCount = 0;

            _cooldownFrames = 8;
          }


    }
  }

  // ------------------------------------------------------------
  // FFT → pitch classes (WITH energy)
  // ------------------------------------------------------------

  /// Returns a map pitchClass -> magnitude (higher = stronger).
  /// This is *before* energy filtering.
  Map<String, double> _detectPitchClassesWithEnergy(List<double> chunk) {
  Float64List? mags;

  _stft.run(chunk, (Float64x2List freq) {
    mags = freq.discardConjugates().magnitudes();
  });

  if (mags == null) return const {};

  final peaks = _findPeaks(
    mags!,
    minHz: 80.0,
    maxHz: 2000.0,
    maxPeaks: 40,          // look at more candidates
    magThreshold: _minAbsoluteMag,
  );

  // Accumulate TOTAL energy per pitch class
  final pcEnergy = <String, double>{};

  for (final p in peaks) {
    final pc = _freqToPitchClass(p.freq);
    if (pc == null) continue;

    pcEnergy[pc] = (pcEnergy[pc] ?? 0.0) + p.mag;
  }

  if (pcEnergy.isEmpty) return const {};

  // Relative cutoff: keep notes that matter for THIS chord
  // final maxEnergy = pcEnergy.values.reduce(math.max);
  // final cutoff = math.max(_minAbsoluteMag, maxEnergy * 0.20);
  // Adaptive cutoff: smaller chords need lower relative threshold

  final energies = pcEnergy.values.toList()..sort((a, b) => b.compareTo(a));

  // Use average of top 2–3 energies instead of absolute max
  final topCount = math.min(3, energies.length);
  final refEnergy =
      energies.take(topCount).reduce((a, b) => a + b) / topCount;
  final noteCount = pcEnergy.length;

  double ratio;
  if (noteCount <= 3) {
    ratio = 0.12;   // triads (major/minor/sus)
  } else if (noteCount == 4) {
    ratio = 0.18;   // 7th chords
  } else {
    ratio = 0.22;   // dense / noisy sets
  }

  // final cutoff = math.max(_minAbsoluteMag, maxEnergy * ratio);
  final cutoff = math.max(_minAbsoluteMag, refEnergy * ratio);
  // ↑ 0.15–0.30 is the useful tuning range

  final filtered = <String, double>{};
  pcEnergy.forEach((pc, energy) {
    if (energy >= cutoff) {
      filtered[pc] = energy;
    }
  });

  return filtered;
}


Map<String, double> _pruneWeakHarmonics(
  Map<String, double> pcMags, {
  double floorRatio = 0.28,
}) {
  if (pcMags.length <= 3) return pcMags; // 🔒 protect triads

  final maxMag = pcMags.values.reduce(math.max);
  final cutoff = maxMag * floorRatio;

  final kept = Map<String, double>.fromEntries(
    pcMags.entries.where((e) => e.value >= cutoff),
  );

  // 🔒 If pruning killed too much, fall back to top 3
  if (kept.length < 3) {
    final sorted = pcMags.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return {
      for (final e in sorted.take(3)) e.key: e.value,
    };
  }

  return kept;
}



Set<String> _topPitchClasses(
  Map<String, double> pcMags, {
  required int maxNotes,
}) {
  if (pcMags.isEmpty) return <String>{};

  // Small musical bias: help the 3rd survive (major/minor distinction)
  final boosted = <String, double>{};

  for (final e in pcMags.entries) {
    double mag = e.value;

    // Bias thirds slightly (A major/minor fix)
    if (e.key == 'C' || e.key == 'C#') {
      mag *= 1.15;
    }

    boosted[e.key] = mag;
  }

  final entries = boosted.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));

  return entries.take(maxNotes).map((e) => e.key).toSet();
}


  /// Keep only notes that look "intentionally played" based on relative energy.
  Map<String, double> _filterIntentionalNotes(Map<String, double> raw) {
    if (raw.isEmpty) return const {};

    final maxMag = raw.values.reduce(math.max);
    final cutoff = math.max(_minAbsoluteMag, maxMag * _intentionalRatio);

    final filtered = <String, double>{};
    raw.forEach((pc, mag) {
      if (mag >= cutoff) filtered[pc] = mag;
    });

    return filtered;
  }

  // ------------------------------------------------------------
  // Comparison
  // ------------------------------------------------------------

bool matchesTarget({required Set<String> detected, required Set<String> target}) {
  // exact match, order-independent
  return detected.length == target.length && detected.containsAll(target);
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

    final minBin = (minHz * _fftSize / _activeSampleRate)
        .floor()
        .clamp(1, magnitudes.length - 2);
    final maxBin = (maxHz * _fftSize / _activeSampleRate)
        .ceil()
        .clamp(1, magnitudes.length - 2);

    for (int i = minBin; i <= maxBin; i++) {
      final m = magnitudes[i];
      if (m < magThreshold) continue;

      if (m > magnitudes[i - 1] && m > magnitudes[i + 1]) {
        final freq = i * _activeSampleRate / _fftSize;
        peaks.add(_Peak(freq: freq, mag: m));
      }
    }

    peaks.sort((a, b) => b.mag.compareTo(a.mag));
    return peaks.length > maxPeaks ? peaks.sublist(0, maxPeaks) : peaks;
  }

  bool _isLikelyHarmonic(double freq, List<double> chosenFreqs) {
    for (final f in chosenFreqs) {
      for (int k = 2; k <= 6; k++) {
        final target = f * k;
        if ((freq - target).abs() / target < 0.03) {
          return true;
        }
      }
    }
    return false;
  }

  String? _freqToPitchClass(double freq) {
    if (freq <= 0) return null;

    final note = 69.0 + 12.0 * (math.log(freq / 440.0) / math.ln2);
    final n = note.round();

    const pcs = [
      'C', 'C#', 'D', 'D#', 'E', 'F',
      'F#', 'G', 'G#', 'A', 'A#', 'B'
    ];

    return pcs[(n % 12 + 12) % 12];
  }

  bool _setsEqual(Set<String> a, Set<String> b) {
    if (a.length != b.length) return false;
    for (final x in a) {
      if (!b.contains(x)) return false;
    }
    return true;
  }
}

class _Peak {
  final double freq;
  final double mag;

  const _Peak({
    required this.freq,
    required this.mag,
  });
}