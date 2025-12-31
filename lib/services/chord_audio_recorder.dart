import 'dart:async';
import 'dart:typed_data';

import 'package:record/record.dart';

abstract class ChordAudioRecorder {
  Future<bool> hasPermission();
  Future<Stream<Uint8List>> startStream(RecordConfig config);
  Future<void> stop();
}