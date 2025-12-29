import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:xml/xml.dart';

import 'package:flashchords/models/inversion_type.dart';
// import 'package:flashchords/features/flashcard/flashcard_engine.dart';
import 'package:flashchords/models/flashcard_item.dart';
const _kChordsXmlPath = 'assets/Chords.xml';

/// Convenience extension so we can safely call `.firstOrNull`
extension XmlFirstOrNull on Iterable<XmlElement> {
  XmlElement? get firstOrNull => isEmpty ? null : first;
}


// test GIT BACKUP line

 /// help for normaliztiong of flats and sharp it the noteSets
 /// 

Set<String> _parseNoteSet(String raw) {
  if (raw.trim().isEmpty) return {};

  return raw
      .split(',')
      .map((s) => s.trim())
      .map(_normalizePitchClass)
      .toSet();
}

String _normalizePitchClass(String note) {
  // Uppercase first letter, preserve accidentals
  final n = note.trim();

  const flatMap = {
    'Cb': 'B',
    'Fb': 'E',
    'Bb': 'A#',
    'Eb': 'D#',
    'Ab': 'G#',
    'Db': 'C#',
    'Gb': 'F#',
  };

  const sharpMap = {
    'E#': 'F',
    'B#': 'C',
  };

  if (flatMap.containsKey(n)) return flatMap[n]!;
  if (sharpMap.containsKey(n)) return sharpMap[n]!;

  return n; // C, C#, F#, etc.
}



/// Normalize the chord type from XML into a stable code
/// used for localization (`localizedChordTypeLabel`).
String _normalizeChordTypeCode(String rawTitle) {
  final t = rawTitle.trim().toLowerCase();

  switch (t) {
    case 'major':
      return 'major';
    case 'minor':
      return 'minor';
    case '7th':
    case 'dominant 7th':
    case 'dominant7':
      return 'dominant7';
    case 'minor 7th':
    case 'minor7':
      return 'minor7';
    case 'diminished':
      return 'diminished';
    case 'augmented':
      return 'augmented';
    case 'major 7th':
    case 'major7':
    case 'maj7':
      return 'major7';
    case 'sus2':
    case 'suspended 2nd':
      return 'sus2';
    case 'sus4':
    case 'suspended 4th':
      return 'sus4';
    default:
      return t;
  }
}

/// Map XML chord title -> folder suffix used on disk.
///
/// Example folders you showed:
///   assets/Chords/A_Chords/A_Major
///   assets/Chords/A_Chords/A_Dominant_7th
///   assets/Chords/A_Chords/A_Sus_2
String _folderNameForChordTitle(String rawTitle) {
  final t = rawTitle.trim().toLowerCase();

  switch (t) {
    case 'major':
      return 'Major';
    case 'minor':
      return 'Minor';
    case '7th':
    case 'dominant 7th':
    case 'dominant7':
      return 'Dominant_7th';
    case 'minor 7th':
    case 'minor7':
      return 'Minor_7th';
    case 'diminished':
      return 'Diminished';
    case 'augmented':
      return 'Augmented';
    case 'major 7th':
    case 'major7':
    case 'maj7':
      return 'Major_7th';
    case 'sus2':
    case 'suspended 2nd':
      return 'Major_Sus_2'; // capital S
    case 'sus4':
    case 'suspended 4th':
      return 'Major_Sus_4';  // lower m
    default:
      // Fallback: best guess
      return rawTitle.trim().replaceAll(' ', '_');
  }
}

/// Load all flashcards from assets/Chords.xml
Future<List<FlashcardItem>> loadFlashcardsFromXml() async {
  final xmlString = await rootBundle.loadString(_kChordsXmlPath);
  final doc = XmlDocument.parse(xmlString);

  final result = <FlashcardItem>[];

  String _normalizeChordType(String raw) {
  raw = raw.toLowerCase().trim();

  if (raw.contains("sus2") || raw.contains("suspended 2")) return "suspended2";
  if (raw.contains("sus4") || raw.contains("suspended 4")) return "suspended4";

  if (raw.contains("aug")) return "augmented";
  if (raw.contains("dim")) return "diminished";

  if (raw.contains("minor 7") || raw.contains("min7")) return "minor7";
  if (raw.contains("major 7") || raw.contains("maj7")) return "major7";


  if (raw.contains("dominant7") || raw.contains("dominant 7") || raw == "7th") {
    return "dominant7";
  }

  return raw.replaceAll(" ", "");
}


  // <note title="Ab (G#)" notePath="Ab">
  for (final note in doc.findAllElements('note')) {
    final titleAttr = note.getAttribute('title')?.trim() ?? '';
    final notePathAttr = note.getAttribute('notePath')?.trim();
    
    // This is the root *used in folder names* like "Ab_Chords"

    String _normalizeRoot(String p) {
  final v = p.toLowerCase();
  switch (v) {
    case 'csharp':
      return 'Db';
    case 'fsharp':
      return 'Gb';
    default:
      return p;
  }
}

   final safeRoot = _normalizeRoot(
  (notePathAttr != null && notePathAttr.isNotEmpty)
      ? notePathAttr
      : titleAttr.split(' ').first,
);
    debugPrint('NOTE FOUND: $titleAttr');

    // ----- chords inside this note -----
    for (final chord in note.findElements('chord')) {
      final chordTitleAttr = chord.getAttribute('title')?.trim() ?? '';
      final noteSetAttr = chord.getAttribute('noteSet') ?? '';  
      if (chordTitleAttr.isEmpty) continue;
      final chordNameElement = chord.findElements('chordName').firstOrNull;
      final chordName = chordNameElement?.text.trim() ?? '';
      final chordTypeCode = _normalizeChordTypeCode(chordTitleAttr);
      final chordTypeFolder = _folderNameForChordTitle(chordTitleAttr);
      final normalizedType = _normalizeChordType(chordTitleAttr);
      // e.g. assets/Chords/Ab_Chords/Ab_Major
      final chordFolder =
          "assets/Chords/${safeRoot}_Chords/${safeRoot}_${chordTypeFolder}";

      // <writtenAs> ... </writtenAs>
      final writtenEl = chord.findElements('writtenAs').firstOrNull;
      final writtenAs = (writtenEl == null)
          ? '$safeRoot $chordTitleAttr'
          : writtenEl.text.trim();

      // Helper to parse each inversion
      void parseInversion(XmlElement inv, InversionType inversionType) {
        String textOf(String tag) {
          final el = inv.findElements(tag).firstOrNull;
          return el == null ? '' : el.text.trim();
        }

        final treble = textOf('treble');
        final bass = textOf('bass');
        final fingering = textOf('fingering');

        if (treble.isEmpty && bass.isEmpty && fingering.isEmpty) return;

       // debugPrint('DEBUG XML PARSER:'
         //   '\n root: $safeRoot'
         //   '\n folder: $chordFolder'
        //    '\n treble: $treble'
        //    '\n bass: $bass'
        //    '\n fingering: $fingering');
          final noteSet = _parseNoteSet(noteSetAttr); 

          // debugPrint('NOTESET: ${noteSet.join(", ")}');

        result.add(
          FlashcardItem(
            root: safeRoot,
            chordName: chordName,      // new property
            chordType: normalizedType,
            inversion: inversionType,
            writtenAs: writtenAs,
            imagePaths: [
              "$chordFolder/$fingering", // keyboard
              "$chordFolder/$treble",    // treble staff
              "$chordFolder/$bass",      // bass staff
            ],
            noteSet: noteSet,
          ),
        );
      }

      // inversion0, inversion1, inversion2
      for (final inv in chord.findElements('inversion0')) {
        parseInversion(inv, InversionType.root);
      }
      for (final inv in chord.findElements('inversion1')) {
        parseInversion(inv, InversionType.first);
      }
      for (final inv in chord.findElements('inversion2')) {
        parseInversion(inv, InversionType.second);
      }
    }
  }
  // debugPrint('XML Parsing complete.');

  return result;
}