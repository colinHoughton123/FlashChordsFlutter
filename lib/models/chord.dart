import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flashchords/models/inversion_type.dart';
import 'package:flashchords/models/instrument.dart';

part 'chord.freezed.dart';

@freezed
abstract class Chord with _$Chord {
  const factory Chord({
    required String root,         // e.g. "C#"
    required String name,         // e.g. "Major 7th"
    required String writtenAs,    // e.g. "C#7"
    required Map<InversionType, Map<Instrument, String>> assets,
  }) = _Chord;
}
