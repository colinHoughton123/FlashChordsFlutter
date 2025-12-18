import 'package:flashchords/models/inversion_type.dart';

class FlashcardItem {
  final String root;
  final String chordName;
  final String chordType;
  final InversionType inversion;
  final String writtenAs;
  final List<String> imagePaths;
  final Set<String> noteSet;

  const FlashcardItem({
    required this.root,
    required this.chordName,
    required this.chordType,
    required this.inversion,
    required this.writtenAs,
    required this.imagePaths,
    required this.noteSet,
  });
}