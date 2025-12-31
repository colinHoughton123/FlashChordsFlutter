import 'dart:async';
import 'dart:typed_data';

import 'package:record/record.dart';
import 'chord_audio_recorder.dart';

class RecordChordAudioRecorder implements ChordAudioRecorder {
  final AudioRecorder _recorder = AudioRecorder();

  @override
  Future<bool> hasPermission() async {
    return _recorder.hasPermission();
  }

  @override
  Future<Stream<Uint8List>> startStream(RecordConfig config) async {
    return _recorder.startStream(config);
  }

  @override
  Future<void> stop() async {
    await _recorder.stop();
  }
}