import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class KeyCalibrationScreen extends StatefulWidget {
  const KeyCalibrationScreen({super.key});

  @override
  State<KeyCalibrationScreen> createState() => _KeyCalibrationScreenState();
}

class _KeyCalibrationScreenState extends State<KeyCalibrationScreen> {
  static const double _keyboardAspectRatio = 1176 / 465; // keyboard.jpg

  // 15 whites: C..B, C..B, C
  final List<String> whiteKeys = const [
    "C1", "D1", "E1", "F1", "G1", "A1", "B1",
    "C2", "D2", "E2", "F2", "G2", "A2", "B2",
    "C3"
  ];

  // 10 blacks across two octaves
  final List<String> blackKeys = const [
    "C#1", "D#1",
    "F#1", "G#1", "A#1",
    "C#2", "D#2",
    "F#2", "G#2", "A#2",
  ];

  late final List<String> allKeys = [...whiteKeys, ...blackKeys];

  int _currentIndex = 0;

  // key -> list of normalized centers
  final Map<String, List<Offset>> _keyCenters = {};

  // Used only for drawing dots on the screen
  final List<_TapDot> _dots = [];

  // Image size *as laid out* (not original pixel size)
  Size? _imageSize;

  // UI controls
  bool _lockY = true;

  // Optional “fixed Y” for whites and blacks separately
  double? _lockedWhiteY;
  double? _lockedBlackY;
  static const String _prefsKey = 'key_calibration_progress_v1';

  bool get _isOnWhites => _currentIndex < whiteKeys.length;

  String get _currentKeyName => allKeys[_currentIndex];

  double? get _currentLockedY => _isOnWhites ? _lockedWhiteY : _lockedBlackY;

  set _currentLockedY(double? v) {
    if (_isOnWhites) {
      _lockedWhiteY = v;
    } else {
      _lockedBlackY = v;
    }
  }

  Future<void> _handleTap(TapDownDetails details) async {
    try {
      if (_imageSize == null) return;
      if (_currentIndex >= allKeys.length) return;

      final local = details.localPosition;

      // Normalize to 0..1
      final nx = (local.dx / _imageSize!.width).clamp(0.0, 1.0);
      final nyRaw = (local.dy / _imageSize!.height).clamp(0.0, 1.0);

      // If lockY is on, use a stable Y per group (whites vs blacks)
      double ny = nyRaw;
      if (_lockY) {
        final locked = _currentLockedY;
        if (locked == null) {
          // First tap for this group sets the locked Y
          _currentLockedY = nyRaw;
          ny = nyRaw;
        } else {
          ny = locked;
        }
      }

      final norm = Offset(nx, ny);

      final keyName = _currentKeyName;
      _keyCenters.putIfAbsent(keyName, () => []);
      _keyCenters[keyName]!.add(norm);

      // Store dot for rendering (with a label)
      _dots.add(
        _TapDot(
          norm: norm,
          label: keyName,
          isBlack: !_isOnWhites,
        ),
      );

      setState(() {
        _currentIndex++;
      });

      await _saveProgressToPrefs();
      await _copyProgressToClipboard();

      if (_currentIndex >= allKeys.length) {
        _showResultDialog();
      }
    } catch (e, st) {
      debugPrint('❌ Calibration tap failed: $e');
      debugPrint('$st');
    }
  }

  void _undoLast() {
    if (_currentIndex <= 0) return;

    setState(() {
      _currentIndex--;

      final keyName = allKeys[_currentIndex];

      // remove last stored point for that key
      final list = _keyCenters[keyName];
      if (list != null && list.isNotEmpty) {
        list.removeLast();
        if (list.isEmpty) _keyCenters.remove(keyName);
      }

      // remove last dot
      if (_dots.isNotEmpty) _dots.removeLast();
    });
  }

  void _resetAll() {
    setState(() {
      _currentIndex = 0;
      _keyCenters.clear();
      _dots.clear();
      _lockedWhiteY = null;
      _lockedBlackY = null;
    });
    _clearSavedPrefs();
  }

  @override
  void initState() {
    super.initState();
    _loadProgressFromPrefs();
  }

  Future<void> _saveProgressToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final json = _buildProgressJson();
    await prefs.setString(_prefsKey, json);
  }

  Future<void> _clearSavedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_prefsKey);
  }

  Future<bool> _loadProgressFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final text = prefs.getString(_prefsKey);
    if (text == null || text.isEmpty) return false;
    return _restoreFromJson(text);
  }

  String _buildProgressJson() {
    final data = <String, dynamic>{
      'currentIndex': _currentIndex,
      'lockY': _lockY,
      'lockedWhiteY': _lockedWhiteY,
      'lockedBlackY': _lockedBlackY,
      'centers': _keyCenters.map((k, v) => MapEntry(
            k,
            v.map((p) => [p.dx, p.dy]).toList(),
          )),
    };
    return jsonEncode(data);
  }

  bool _restoreFromJson(String text) {
    try {
      final parsed = jsonDecode(text) as Map<String, dynamic>;
      final centers = parsed['centers'] as Map<String, dynamic>? ?? {};
      // Legacy data (no octave suffix) is not compatible with new keys.
      final hasLegacyKeys =
          centers.keys.any((k) => !RegExp(r'\d+$').hasMatch(k));
      if (hasLegacyKeys) {
        _resetAll();
        return false;
      }
      _keyCenters.clear();
      _dots.clear();

      centers.forEach((key, list) {
        final pts = <Offset>[];
        for (final pair in (list as List<dynamic>)) {
          final dx = (pair[0] as num).toDouble();
          final dy = (pair[1] as num).toDouble();
          pts.add(Offset(dx, dy));
          _dots.add(
            _TapDot(
              norm: Offset(dx, dy),
              label: key,
              isBlack: !whiteKeys.contains(key),
            ),
          );
        }
        _keyCenters[key] = pts;
      });

      _currentIndex =
          (parsed['currentIndex'] as num?)?.toInt() ?? _dots.length;
      _currentIndex = _currentIndex.clamp(0, allKeys.length);
      _lockY = (parsed['lockY'] as bool?) ?? _lockY;
      _lockedWhiteY =
          (parsed['lockedWhiteY'] as num?)?.toDouble();
      _lockedBlackY =
          (parsed['lockedBlackY'] as num?)?.toDouble();

      setState(() {});
      return _dots.isNotEmpty;
    } catch (e) {
      debugPrint('Failed to restore progress: $e');
      return false;
    }
  }

  Future<void> _resumeFromFile() async {
    final ok = await _loadProgressFromPrefs();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(ok ? 'Progress restored from file' : 'No saved progress found'),
      ),
    );
  }

  Future<void> _startOver() async {
    _resetAll();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Progress cleared')),
    );
  }

  Future<void> _copyProgressToClipboard() async {
    final result = _buildResult();
    await Clipboard.setData(ClipboardData(text: result));
  }

  List<String> _uniqueInOrder(List<String> list) {
    final out = <String>[];
    final seen = <String>{};
    for (final k in list) {
      if (seen.add(k)) out.add(k);
    }
    return out;
  }

  String _buildResult() {
    final buffer = StringBuffer();
    buffer.writeln('final keyCenters = {');

    for (final k in _uniqueInOrder(whiteKeys)) {
      final pts = _keyCenters[k];
      if (pts == null) continue;
      buffer.writeln('  "$k": [');
      for (final p in pts) {
        buffer.writeln(
          "    Offset(${p.dx.toStringAsFixed(4)}, ${p.dy.toStringAsFixed(4)}),",
        );
      }
      buffer.writeln('  ],');
    }

    for (final k in _uniqueInOrder(blackKeys)) {
      final pts = _keyCenters[k];
      if (pts == null) continue;
      buffer.writeln('  "$k": [');
      for (final p in pts) {
        buffer.writeln(
          "    Offset(${p.dx.toStringAsFixed(4)}, ${p.dy.toStringAsFixed(4)}),",
        );
      }
      buffer.writeln('  ],');
    }

    buffer.writeln('};');
    return buffer.toString();
  }

  Future<void> _showResultDialog() async {
    final result = _buildResult();
    await showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Calibration complete'),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: SelectableText(result),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await Clipboard.setData(ClipboardData(text: result));
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text('Copy'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Future<void> _showProgressSaved() async {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Progress copied to clipboard')),
    );
  }

  Future<void> _saveProgress() async {
    await _saveProgressToPrefs();
    await _copyProgressToClipboard();
    await _showProgressSaved();
  }

  Future<void> _restoreProgress() async {
    final data = await Clipboard.getData('text/plain');
    if (data == null || data.text == null) return;
    // This is a dev tool; we simply surface the clipboard content for manual use.
    if (!mounted) return;
    await showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Clipboard contents'),
        content: SingleChildScrollView(
          child: SelectableText(data.text!),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final done = _currentIndex >= allKeys.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Keyboard Calibration Tool"),
        actions: [
          IconButton(
            tooltip: "Undo",
            onPressed: _undoLast,
            icon: const Icon(Icons.undo),
          ),
          IconButton(
            tooltip: "Reset",
            onPressed: _startOver,
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            tooltip: "Save progress",
            onPressed: _saveProgress,
            icon: const Icon(Icons.save),
          ),
          IconButton(
            tooltip: "Resume",
            onPressed: _resumeFromFile,
            icon: const Icon(Icons.replay),
          ),
          IconButton(
            tooltip: "Show clipboard",
            onPressed: _restoreProgress,
            icon: const Icon(Icons.paste),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 6),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    done
                        ? "✅ Done! Tap Copy to save the output."
                        : "Tap center for: ${allKeys[_currentIndex]}  (${_isOnWhites ? "WHITE" : "BLACK"})",
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
            child: Row(
              children: [
                Switch(
                  value: _lockY,
                  onChanged: (v) => setState(() => _lockY = v),
                ),
                const SizedBox(width: 8),
                Text(_lockY ? "Lock Y (per white/black)" : "Free tap (X+Y)"),
                const Spacer(),
                Text(
                  _lockY
                      ? "Ywhite=${_lockedWhiteY?.toStringAsFixed(3) ?? "-"}  Yblack=${_lockedBlackY?.toStringAsFixed(3) ?? "-"}"
                      : "",
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: AspectRatio(
                aspectRatio: _keyboardAspectRatio,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    _imageSize =
                        Size(constraints.maxWidth, constraints.maxHeight);
                    return GestureDetector(
                      onTapDown: _handleTap,
                      child: Stack(
                        children: [
                          // Keyboard image
                          Image.asset(
                            "assets/keyboard.jpg",
                            width: constraints.maxWidth,
                            height: constraints.maxHeight,
                            fit: BoxFit.contain,
                          ),

                          // Overlay dots
                          ..._dots.map((d) {
                            final x = d.norm.dx * _imageSize!.width;
                            final y = d.norm.dy * _imageSize!.height;
                            return Positioned(
                              left: x - 6,
                              top: y - 6,
                              child: _Dot(
                                label: d.label,
                                isBlack: d.isBlack,
                              ),
                            );
                          }),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TapDot {
  final Offset norm; // 0..1 coords
  final String label;
  final bool isBlack;
  const _TapDot({required this.norm, required this.label, required this.isBlack});
}

class _Dot extends StatelessWidget {
  final String label;
  final bool isBlack;
  const _Dot({required this.label, required this.isBlack});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.green,
            border: Border.all(color: Colors.white, width: 1.5),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.white,
            shadows: [Shadow(blurRadius: 4, color: Colors.black)],
          ),
        ),
      ],
    );
  }
}
