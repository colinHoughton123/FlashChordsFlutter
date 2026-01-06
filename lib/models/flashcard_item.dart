import 'package:flashchords/models/inversion_type.dart';

class FlashcardItem {
  final String root;
  final String chordName;
  final String chordType;
  final InversionType inversion;
  final String writtenAs;
  final String writtenAsOriginal;
  final List<String> imagePaths;
  final Set<String> noteSet;
  final List<String> noteSetOriginal;

  const FlashcardItem({
    required this.root,
    required this.chordName,
    required this.chordType,
    required this.inversion,
    required this.writtenAs,
    required this.writtenAsOriginal,
    required this.imagePaths,
    required this.noteSet,
    required this.noteSetOriginal,
  });
}