import 'package:flutter/material.dart';

class KeyboardKeyCenters {
  // Normalized key centers from calibration (0..1 in image space).
  static const Map<String, List<Offset>> centers = {
    "C1": [Offset(0.0404, 0.8262)],
    "D1": [Offset(0.1035, 0.8262)],
    "E1": [Offset(0.1661, 0.8262)],
    "F1": [Offset(0.2280, 0.8262)],
    "G1": [Offset(0.2911, 0.8262)],
    "A1": [Offset(0.3537, 0.8262)],
    "B1": [Offset(0.4135, 0.8262)],
    "C2": [Offset(0.4747, 0.8262)],
    "D2": [Offset(0.5362, 0.8262)],
    "E2": [Offset(0.5952, 0.8262)],
    "F2": [Offset(0.6540, 0.8262)],
    "G2": [Offset(0.7142, 0.8262)],
    "A2": [Offset(0.7742, 0.8262)],
    "B2": [Offset(0.8303, 0.8262)],
    "C3": [Offset(0.8892, 0.8262)],
    "C#1": [Offset(0.0646, 0.4719)],
    "D#1": [Offset(0.1366, 0.4719)],
    "F#1": [Offset(0.2484, 0.4719)],
    "G#1": [Offset(0.3167, 0.4719)],
    "A#1": [Offset(0.3868, 0.4719)],
    "C#2": [Offset(0.4950, 0.4719)],
    "D#2": [Offset(0.5675, 0.4719)],
    "F#2": [Offset(0.6727, 0.4719)],
    "G#2": [Offset(0.7408, 0.4719)],
    "A#2": [Offset(0.8121, 0.4719)],
  };

  static final Map<String, List<Offset>> _byBase = _buildBaseMap();

  static Map<String, List<Offset>> _buildBaseMap() {
    final map = <String, List<Offset>>{};
    centers.forEach((key, list) {
      final base = key.replaceAll(RegExp(r'\d+$'), '');
      map.putIfAbsent(base, () => []);
      map[base]!.addAll(list);
    });
    for (final entry in map.entries) {
      entry.value.sort((a, b) => a.dx.compareTo(b.dx));
    }
    return map;
  }

  static List<Offset> resolveOrderedNotes(List<String> notes) {
    final normalized = notes.map(_normalizeNote).toList(growable: false);
    final result = <Offset>[];
    double lastX = -1.0;

    for (final note in normalized) {
      final candidates = _byBase[note];
      if (candidates == null || candidates.isEmpty) continue;

      final chosen = candidates.firstWhere(
        (p) => p.dx > lastX + 0.001,
        orElse: () => candidates.first,
      );

      result.add(chosen);
      lastX = chosen.dx;
    }

    return result;
  }

  static String _normalizeNote(String note) {
    var s = note.replaceAll('♭', 'b');
    switch (s) {
      case 'Bb':
        return 'A#';
      case 'Db':
        return 'C#';
      case 'Eb':
        return 'D#';
      case 'Gb':
        return 'F#';
      case 'Ab':
        return 'G#';
      default:
        return s;
    }
  }
}
