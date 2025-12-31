// lib/features/flashcard/flashcard_engine.dart

import 'package:flashchords/models/inversion_type.dart';
import 'package:flashchords/models/flashcard_item.dart';


/// Engine to walk through a deck and track stats.
class FlashcardEngine {
  final List<FlashcardItem> _mainDeck;
  late List<FlashcardItem> _currentDeck;
  final List<FlashcardItem> _errorDeck = [];


  // Total time spent on cards answered CORRECTLY
  Duration _totalCorrectTime = Duration.zero;

  // int get deckSize => _currentDeck.length;

  int _correctCount = 0;

  int _currentIndex = 0;
  int totalCorrect = 0;
  int totalIncorrect = 0;
  // final List<Duration> _allTimes = [];
  final List<Duration> _correctTimes = [];
  final List<Duration> _allAttemptTimes = [];
  

  bool usingErrorDeck = false;

  FlashcardEngine(List<FlashcardItem> deck)
      : _mainDeck = List.unmodifiable(deck) {
    _currentDeck = List<FlashcardItem>.from(deck);

    
  }

int get deckSize => _currentDeck.length;


  FlashcardItem? get currentCard {
    if (_currentIndex < 0 || _currentIndex >= _currentDeck.length) {
      return null;
    }
    return _currentDeck[_currentIndex];
  }

  int get playedInCurrentDeck =>
      _currentIndex.clamp(0, _currentDeck.length);

 int get remainingInCurrentDeck =>
    (_currentDeck.length - _currentIndex).clamp(0, _currentDeck.length);

    int get totalInCurrentDeck => _currentDeck.length;

  bool get deckFinished => _currentIndex >= _currentDeck.length;

  bool get hasErrorsForNextRound => _errorDeck.isNotEmpty;

  double get averageSecondsCorrect {
    if (_correctTimes.isEmpty) return 0.0;
    final totalSeconds = _correctTimes
        .map((d) => d.inMilliseconds / 1000.0)
        .fold<double>(0.0, (a, b) => a + b);
    return totalSeconds / _correctTimes.length;
  }

  double get averageSecondsAll {
    if (_allAttemptTimes.isEmpty) return 0.0;
    final totalSeconds = _allAttemptTimes
        .map((d) => d.inMilliseconds / 1000.0)
        .fold<double>(0.0, (a, b) => a + b);
    return totalSeconds / _allAttemptTimes.length;
  }

  

  void _advance() {
    _currentIndex++;
  }



void _resetSessionStats() {
  totalCorrect = 0;
  totalIncorrect = 0;

  _correctTimes.clear();
  _allAttemptTimes.clear();
}


  
void markCorrect(Duration elapsed) {
  if (elapsed.inMilliseconds > 300) {   // ignore “instant” presses
    _correctTimes.add(elapsed);
    _allAttemptTimes.add(elapsed);
  }

  totalCorrect++;
  _advance();
}

void markIncorrect(Duration elapsed) {
  totalIncorrect++;
  _errorDeck.add(_currentDeck[_currentIndex]);

  _allAttemptTimes.add(elapsed); // ✅ always record

  _advance();
}



  /// After a round is finished, either play only the errors, or restart main deck.
  void startErrorsDeckOrRestartMain() {


   // if (_errorDeck.isNotEmpty) {
   if (_errorDeck.isNotEmpty) {
  _currentDeck = List<FlashcardItem>.from(_errorDeck);
  _errorDeck.clear();
  usingErrorDeck = true;
  _currentIndex = 0;

  _resetSessionStats();   // ✅ RESET averages for error deck

  print('ENGINE: starting ERROR deck');
} else {
  _currentDeck = List<FlashcardItem>.from(_mainDeck);
  usingErrorDeck = false;
  _currentIndex = 0;

  _resetSessionStats();   // ✅ RESET averages for new main run

  print('ENGINE: starting MAIN deck');
}
  }
}