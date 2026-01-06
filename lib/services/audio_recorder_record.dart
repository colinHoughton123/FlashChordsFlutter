import 'dart:async';
import 'dart:typed_data';

import 'package:record/record.dart';
import 'chord_audio_recorder.dart';

class RecordChordAudioRecorder implements ChordAudioRecorder {
  AudioRecorder? _recorder;

  void _ensureRecorder() {
    _recorder ??= AudioRecorder();
  }

  @override
  Future<bool> hasPermission() async {
    _ensureRecorder();
    return _recorder!.hasPermission();
  }

  @override
  Future<Stream<Uint8List>> startStream(RecordConfig config) async {
    _ensureRecorder();
    return _recorder!.startStream(config);
  }

  @override
  Future<void> stop() async {
    try {
      await _recorder?.stop();
    } catch (_) {}

    try {
      await _recorder?.dispose();
    } catch (_) {}

    _recorder = null;
  }
}