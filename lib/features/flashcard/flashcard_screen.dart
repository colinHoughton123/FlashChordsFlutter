import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/foundation.dart';

import 'package:flashchords/l10n/app_localizations.dart';
import 'package:flashchords/data/settings_repository.dart';
import 'package:flashchords/data/chord_xml_parser.dart';

import 'package:flashchords/models/inversion_type.dart';
import 'package:flashchords/models/flashcard_item.dart';

import 'package:flashchords/features/flashcard/flashcard_engine.dart';
import 'package:flashchords/features/flashcard/flashcard_widget.dart';
import 'package:flashchords/features/summary/flashcard_summary_screen.dart';

import 'package:flashchords/services/chord_detection_services.dart';
import 'package:flashchords/core/system_error.dart';
import 'package:flashchords/core/system_error_code.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

///
/// ---------- Localization helpers (OK outside class) ----------
///

String _localizedChordName(AppLocalizations t, String chordName) {
  String result = chordName;
  result = result.replaceAll('Augmented', t.chord_augmented);
  result = result.replaceAll('Diminished', t.chord_diminished);
  result = result.replaceAll('Dominant 7th', t.chord_dominant7);
  result = result.replaceAll('Major 7th', t.chord_major7);
  result = result.replaceAll('Minor 7th', t.chord_minor7);
  result = result.replaceAll('Major', t.chord_major);
  result = result.replaceAll('Minor', t.chord_minor);
  result = result.replaceAll('Suspended 2', t.chord_suspended2);
  result = result.replaceAll('Suspended 4', t.chord_suspended4);
  result = result.replaceAll('&#9837;', '♭');
  return result;
}

///
/// ---------- Widget ----------
///

class FlashcardScreen extends ConsumerStatefulWidget {
  final List<FlashcardItem> items;

  const FlashcardScreen({
    super.key,
    required this.items,
  });

  @override
  ConsumerState<FlashcardScreen> createState() =>
      _FlashcardScreenState();
}

class _FlashcardScreenState
    extends ConsumerState<FlashcardScreen> {


  // 🔎 Debug / diagnostics


bool _subscribedToListener = false;
bool _firstFrameSeen = false;
int _detectionCount = 0;
DateTime? _lastDetectionAt;
String _lastDecision = '-';
// Optional: show raw vs filtered mags from ChordDetectionService
DetectedNotesFrame? _lastFrame;
StreamSubscription<DetectedNotesFrame>? _frameSub;


   // ⏱ How long since last detection (for overlay)
  int get _lastDetectionMsAgo {
    final t = _lastDetectionAt;
    if (t == null) return -1;
    return DateTime.now().difference(t).inMilliseconds;
  }



bool _timerCancelled = false;
bool _timedOut = false;

Set<String>? _lastDetectedNotes;

Set<String>? _previousCorrectTargetNotes; // null until we have an auto/manual correct




  // ---------- Core state ----------
  late FlashcardEngine _engine;
  bool _engineReady = false;

 // bool _evaluationEnabled = true;
// bool _cardFrontVisible = true;
// bool _autoMarked = false;

// Set<String>? _previousChordNotes;


  // --- Previous chord release gating ---

bool _waitingForPreviousRelease = false;

  // ---------- Card + timing ----------
  final GlobalKey<FlashcardWidgetState> _cardKey =
      GlobalKey<FlashcardWidgetState>();

  DateTime? _cardShownAt;
  Timer? _timer;

  DateTime? _lastMatchAt;
Set<String>? _lastMatchDetected;
Set<String>? _lastMatchTarget;
String? _lastMatchCardLabel; // optional (e.g. "A7")


  bool _timerEnabled = false;
  int _timerSeconds = 5;
  int _remainingSeconds = 5;
  int _initialSeconds = 5;

  // ---------- Listening ----------
  bool _listeningEnabled = false;
  StreamSubscription<Set<String>>? _listenerSub;
  bool _autoMarked = false;

  // --- New gating state ---
Set<String>? _previousChordNotes;
bool _evaluationEnabled = true;  
bool _cardFrontVisible = true;
bool _frontEverShown = false;



int get _lastMatchMsAgo {
  final t = _lastMatchAt;
  if (t == null) return -1;
  return DateTime.now().difference(t).inMilliseconds;
}


//void _beginSession() {
 // _engineArmTime = DateTime.now(); // ⏱ START CLOCK
 // _engine.armForChord(_currentChord);
// }



  // ============================================================
  // Lifecycle
  // ============================================================

// ============================================================
// Lifecycle
// ============================================================

@override
void initState() {
  super.initState();

  // Build engine using settings-filtered deck
  _initEngine().then((_) {
    _engineReady = true;
    

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        await ChordDetectionService.instance.start();
        _subscribeToDetectedNotesIfNeeded();
        _subscribeToFramesIfNeeded();
        setState(() {
          _engineReady = true;
          _startTimingForCurrentCard();
        });
      } catch (e) {
        if (e is SystemErrorCode) {
          SystemError.report(e.code, ref);
        } else {
          SystemError.report(201, ref);
        }
      }
    });

    setState(() {});
  });
}

@override
void didChangeDependencies() {
  super.didChangeDependencies();
  _loadSettings();
}

@override
void dispose() {
  _timer?.cancel();

  _listenerSub?.cancel();
  _listenerSub = null;

  _frameSub?.cancel();
  _frameSub = null;

  super.dispose();
}




  // ============================================================
  // Setup
  // ============================================================

bool _isStrictSuperset(Set<String> a, Set<String> b) {
  return a.length > b.length && a.containsAll(b);
}

bool _shouldSwapForReleaseSafety(
  FlashcardItem current,
  FlashcardItem next,
) {
  final a = current.noteSet;
  final b = next.noteSet;

  // Swap if:
  // current ⊃ next   (A7 → A, Amaj7 → A)
  return a.containsAll(b) && a.length > b.length;
}



void reorderDeckForReleaseSafety(List<FlashcardItem> deck) {
  bool changed;

  do {
    changed = false;

    for (int i = 0; i < deck.length - 1; i++) {
      final a = deck[i];
      final b = deck[i + 1];

      if (_shouldSwapForReleaseSafety(a, b)) {
        deck[i] = b;
        deck[i + 1] = a;
        changed = true;
      }
    }
  } while (changed);
}

void _subscribeToDetectedNotesIfNeeded() {
  if (!_listeningEnabled) return;
  if (_listenerSub != null) return;

  _listenerSub =
      ChordDetectionService.instance.detectedNotesStream.listen((detected) {
    _detectionCount++;
    _lastDetectionAt = DateTime.now();
        // 👇 Let overlay repaint in response to decision changes
    setState(() {
      _handleDetectedNotes(detected);
    });
  });

  _subscribedToListener = true;
}

Future<void> _setup() async {
  await _loadSettings();
  await _initEngine();
 // START has been PRESSED
   setState(() {
    // 🔄 HARD RESET of listening / evaluation state


    _frontEverShown = false;
    _engineReady = true;

    _resetListeningAndEvaluationState();

  });
}


void _subscribeToFramesIfNeeded() {
  if (_frameSub != null) return;

  _frameSub = ChordDetectionService.instance.detectedFrameStream.listen((frame) {
       if (!_firstFrameSeen) {
      _firstFrameSeen = true;
      debugPrint(
        '🎧 FIRST AUDIO FRAME '
        ' | t=${frame.at.toIso8601String()}'
        ' | sr=${frame.sampleRate}'
      );
    }
   
    _lastFrame = frame;

    // Optional: trigger overlay repaint (cheap)
    if (mounted) setState(() {});
  });
}


  Future<void> _loadSettings() async {
    final repo = SettingsRepository();
    final (timerEnabled, seconds) = await repo.loadTimer();
    final listenEnabled = await repo.loadListenMode();

    setState(() {
      _timerEnabled = timerEnabled;
      _timerSeconds = seconds;
      _remainingSeconds = seconds;
      _listeningEnabled = listenEnabled;
    });
  }

  Future<void> _initEngine() async {
    // final allItems = await loadFlashcardsFromXml();
    final allItems = widget.items;
    final repo = SettingsRepository();

    final selectedRoots = await repo.loadRoots();
    final selectedTypes = await repo.loadChordTypes();
    final selectedInversions = await repo.loadInversions();
    final orderMode = await repo.loadCardOrder();

    String inversionKey(InversionType inv) {
      switch (inv) {
        case InversionType.root:
          return 'root';
        case InversionType.first:
          return 'first';
        case InversionType.second:
          return 'second';
      }
    }

    final filtered = allItems.where((item) {
      final rootOk =
          selectedRoots.isEmpty || selectedRoots.contains(item.root);
      final typeOk =
          selectedTypes.isEmpty || selectedTypes.contains(item.chordType);
      final invOk = selectedInversions.isEmpty ||
          selectedInversions.contains(inversionKey(item.inversion));
      return rootOk && typeOk && invOk;
    }).toList();

    filtered.sort((a, b) {
      final r = a.root.compareTo(b.root);
      if (r != 0) return r;
      final c = a.chordType.compareTo(b.chordType);
      if (c != 0) return c;
      return a.inversion.index.compareTo(b.inversion.index);
    });

    if (orderMode == 'random') {
      filtered.shuffle();
    }

    reorderDeckForReleaseSafety(filtered);



    setState(() {
      
      _engine = FlashcardEngine(filtered.isEmpty ? widget.items : filtered);
      _startTimingForCurrentCard();
    });
  }

  // ============================================================
  // Listening
  // ============================================================

void _revealBackDueToTimeout() {
  _timedOut = true;
  // Stop timer
  _timer?.cancel();

  // Disable evaluation + auto marking
  _evaluationEnabled = false;
  _autoMarked = false;

  // Stop listening logic (but DO NOT stop mic)
  _cardFrontVisible = false;

  // Clear any pending previous-chord state
  _previousChordNotes = null;

  // Flip card
  _cardKey.currentState?.flipToBack();

  setState(() {
    _timerCancelled = true;
    _remainingSeconds = 0;
  });
}

void _handleDetectedNotes(Set<String> detected) {
  _lastDetectedNotes = detected;
  _lastDetectionAt = DateTime.now();

  // --------------------------------------------------
  // Hard guards
  // --------------------------------------------------
  if (!_listeningEnabled) {
    _lastDecision = 'blocked: listening off';
    return;
  }

  if (!_cardFrontVisible) {
    _lastDecision = 'blocked: back shown';
    return;
  }

  // --------------------------------------------------
  // 1️⃣ Waiting for previous chord release
  // --------------------------------------------------
  if (_previousChordNotes != null) {
    final stillHoldingPrevious =
        detected.containsAll(_previousChordNotes!);

    _lastDecision = stillHoldingPrevious
        ? 'blocked: waiting release ${_previousChordNotes!.join(",")}'
        : 'release detected';

    if (!stillHoldingPrevious) {
      _previousChordNotes = null;
      _autoMarked = false;
    }
    return;
  }

  // --------------------------------------------------
  // 2️⃣ Normal evaluation
  // --------------------------------------------------
  if (_autoMarked) {
    _lastDecision = 'blocked: autoMarked';
    return;
  }

  final card = _engine.currentCard;
  if (card == null) {
    _lastDecision = 'blocked: no card';
    return;
  }

  final target = card.noteSet;

  _lastDecision = 'evaluating det=${detected.join(",")}';

  // --- Subset-transition protection ---
  if (_previousCorrectTargetNotes != null) {
    final prev = _previousCorrectTargetNotes!;
    if (prev.containsAll(target) && prev.length > target.length) {
      final extras = prev.difference(target);
      if (detected.intersection(extras).isNotEmpty) {
        _lastDecision = 'blocked: extras still ${extras.join(",")}';
        return;
      }
    }
  }

  final matches = ChordDetectionService.instance.matchesTarget(
    detected: detected,
    target: target,
  );

  if (!matches) {
    _lastDecision = 'no match';
    return;
  }

  // --------------------------------------------------
  // 3️⃣ MATCH
  // --------------------------------------------------
    // ✅ record match for overlay *immediately*
  _lastDecision = 'MATCH ✅';
    debugPrint('MATCH found ');
  _lastMatchAt = DateTime.now();
  _lastMatchDetected = Set.of(detected);
  _lastMatchTarget = Set.of(target);
  _lastMatchCardLabel = card.writtenAs;

  _autoMarked = true;
  _evaluationEnabled = false;        // lock until next card front shown
  _previousChordNotes = target;      // (optional: if you still use release gating)
  _previousCorrectTargetNotes = target;

  _handleCorrect(autoTriggered: true);
}


void _resetListeningAndEvaluationState() {
  // Evaluation / gating
  _evaluationEnabled = true;
  _autoMarked = false;
  _cardFrontVisible = true;

  _previousChordNotes = null;
  _previousCorrectTargetNotes = null;

  // Debug / overlay
  _lastDetectedNotes = const <String>{};
  _lastDetectionAt = null;
  _lastDecision = 'reset';
  _firstFrameSeen = false;

  // Safety: any illegal partial-lock state is gone
}


void _checkForChordRelease(Set<String> detected) {
  if (_previousChordNotes == null) return;

  final stillHeld =
      detected.intersection(_previousChordNotes!);

  if (stillHeld.isEmpty) {
    // Player released at least one note
    _previousChordNotes = null;
    //. _evaluationEnabled = true;   // xxx
    _autoMarked = false;

    debugPrint('🎧 Ready for next chord');
  }
}


  // ============================================================
  // Timing + game logic
  // ============================================================

void _startTimingForCurrentCard() {
  debugPrint('⏱ CARD TIMING STARTED');
  _timer?.cancel();
_timedOut = false; 
_frontEverShown = false;


  //_cardShownAt = DateTime.now();
  _cardShownAt = null;
  WidgetsBinding.instance.addPostFrameCallback((_) {
  _cardShownAt = DateTime.now();
});
  _timerCancelled = false;

  _remainingSeconds = _timerSeconds;
  _initialSeconds = _timerSeconds;

  // ✅ HARD RESET for every new card
  _cardFrontVisible = true;
  _evaluationEnabled = true;
  _previousChordNotes = null;
  _autoMarked = false;
  // _frontEverShown = false;

  if (!_timerEnabled) return;

  _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
    if (!mounted) return;

    setState(() => _remainingSeconds--);

if (_remainingSeconds <= 0) {
  timer.cancel();              // 🛑 stop further ticks
  
  _revealBackDueToTimeout();    // 🔄 transition exactly once
}
  });
}

Future<void> _handleCorrect({bool autoTriggered = false}) async {
  // --------------------------------------------------
  // ⏱ DEBUG: timing at entry
  // --------------------------------------------------
  final nowAtEntry = DateTime.now();
  final cardShownAt = _cardShownAt ?? nowAtEntry;
  final elapsedAtEntry = nowAtEntry.difference(cardShownAt);

  debugPrint(
    '⏱ CORRECT entry'
    ' | auto=$autoTriggered'
    ' | elapsed=${elapsedAtEntry.inMilliseconds}ms'
  );

  // --------------------------------------------------
  // Stop timer & normalize card state
  // --------------------------------------------------
  _timer?.cancel();
  _cardKey.currentState?.forceShowFront();

  _evaluationEnabled = false;
  _cardFrontVisible = true;

  // --------------------------------------------------
  // Capture previous chord state (for subset logic)
  // --------------------------------------------------
  final solvedCard = _engine.currentCard;
  if (solvedCard != null) {
    _previousChordNotes = Set.of(solvedCard.noteSet);
    _previousCorrectTargetNotes = solvedCard.noteSet;
  }

  // --------------------------------------------------
  // 🧮 Compute elapsed ONCE (this is what engine records)
  // --------------------------------------------------
 // final elapsedForEngine = (_timerEnabled && _remainingSeconds <= 0)
 //     ? Duration(seconds: _initialSeconds)
 //     : DateTime.now().difference(cardShownAt);

      final now = DateTime.now();
final shownAt = _cardShownAt ?? now;
final elapsed = _timedOut
    ? Duration(seconds: _initialSeconds)
    : DateTime.now().difference(_cardShownAt!);

  debugPrint(
  '⏱ CORRECT engine-mark'
  ' | elapsed=${elapsed.inMilliseconds}ms'
  ' | delta=${elapsed.inMilliseconds - elapsedAtEntry.inMilliseconds}ms'
);

  // --------------------------------------------------
  // Record result
  // --------------------------------------------------
  _engine.markCorrect(elapsed);

  // --------------------------------------------------
  // Deck finished?
  // --------------------------------------------------
  if (_engine.deckFinished) {
    await _showSummaryScreen();
    return;
  }

  // --------------------------------------------------
  // Prepare next card
  // --------------------------------------------------
  setState(() {
    _autoMarked = false;
    _startTimingForCurrentCard();
  });



}

  Future<void> _handleIncorrect() async {
    _evaluationEnabled = false;
_cardFrontVisible = true;
    _cardKey.currentState?.forceShowFront();
    _timer?.cancel();
    _engine.markIncorrect();

    if (_engine.deckFinished) {
      await _showSummaryScreen();
      return;
    }

    setState(() => _startTimingForCurrentCard());
  }

  Future<void> _showSummaryScreen() async {
    if (!mounted) return;

_previousCorrectTargetNotes = null;
    final choice = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (_) => FlashcardSummaryScreen(
          totalCorrect: _engine.totalCorrect,
          totalIncorrect: _engine.totalIncorrect,
          totalCards: _engine.totalCorrect + _engine.totalIncorrect,
          averageSeconds: _engine.averageSecondsPerCard,
          showAverage: _timerEnabled,
          hadErrors: _engine.hasErrorsForNextRound,
          isErrorDeck: _engine.usingErrorDeck,
        ),
      ),
    );

    if (!mounted) return;

    if (choice == 'restart') {
      _resetListeningAndEvaluationState();
      setState(() {
        _engine.startErrorsDeckOrRestartMain();
        _startTimingForCurrentCard();
      });
    } else {
      Navigator.pop(context);
    }
  }

  // ============================================================
  // UI helpers
  // ============================================================




Widget _buildDebugOverlay() {
  final det = _lastDetectedNotes?.join(',') ?? '-';
  final last = _lastDetectionMsAgo < 0 ? '-' : '${_lastDetectionMsAgo}ms';


final matchAgo = _lastMatchMsAgo;
final matchLine = matchAgo < 0
    ? 'lastMatch=-'
    : 'lastMatch=${matchAgo}ms\n'
      'mDet=${_lastMatchDetected?.join(",") ?? "-"}\n'
      'mTgt=${_lastMatchTarget?.join(",") ?? "-"}';


  // Optional raw/filtered magnitudes (top 6 strongest)
  String magsLine(Map<String, double>? m) {
    if (m == null || m.isEmpty) return '-';
    final entries = m.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return entries.take(6).map((e) => '${e.key}:${e.value.toStringAsFixed(3)}').join(' ');
  }

  final raw = magsLine(_lastFrame?.raw);
  final filt = magsLine(_lastFrame?.filtered);

  return Positioned(
    top: 8,
    left: 8,
    child: Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        'front=$_cardFrontVisible  eval=$_evaluationEnabled\n'
        'auto=$_autoMarked\n  prev=${_previousChordNotes?.join(",") ?? "-"}\n'
        'last=$last  det=$det\n'
        'decision=$_lastDecision\n'
        'matchLine\n'
        'raw=$raw\n'
        'filt=$filt',
        style: const TextStyle(color: Colors.white, fontSize: 11),
      ),
    ),
  );
}


Widget _buildListeningIndicator(AppLocalizations t) {
  if (!_listeningEnabled ||
      !_evaluationEnabled ||
      !_cardFrontVisible) {
    return const SizedBox.shrink();
  }

  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Icon(Icons.headphones, size: 16, color: Colors.green),
      const SizedBox(width: 6),
      Text(
        t.listeningActive,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.green,
              fontStyle: FontStyle.italic,
            ),
      ),
    ],
  );
}
  // ============================================================
  // BUILD
  // ============================================================

void _onCardFrontShown() {
  // 🔒 Guard: only once per card
  if (_frontEverShown) return;
  _frontEverShown = true;

  _cardFrontVisible = true;
  _lastDecision = 'front shown';
}

void _onCardBackShown() {
  // 🛑 Ignore spurious initial build callback
    if (!_frontEverShown) {
    // ⛔ Ignore phantom back during initial layout
    return;
  }
  if (_evaluationEnabled) return;

  _cardFrontVisible = false;
}



  @override
Widget build(BuildContext context) {
  final t = AppLocalizations.of(context)!;

  if (!_engineReady) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }

  final card = _engine.currentCard;
  final played = _engine.playedInCurrentDeck;
  final remaining = _engine.totalInCurrentDeck - played;

  return Scaffold(
    backgroundColor: Colors.grey.shade100,
    appBar: AppBar(
      title: Text(
        _engine.usingErrorDeck
            ? t.flash_playing_wrong
            : t.flash_playing_main,
      ),
    ),

    // ✅ BODY BELONGS TO SCAFFOLD
    body: Column(
      children: [
        _buildListeningIndicator(t),
        const SizedBox(height: 8),
        Text(t.flash_cards_played(played, remaining)),

        Expanded(
          child: Center(
            child: card == null
                ? const SizedBox.shrink()
                : Stack(
                    children: [
                      FlashcardWidget(
                        key: _cardKey,
                        cardId:
                            '${card.root}_${card.chordType}_${card.inversion.index}_${played}',
                        cardTitle:
                            _localizedChordName(t, card.chordName),
                        chordLabel: card.writtenAs,
                        inversion: card.inversion,
                        imageAssetPaths: card.imagePaths,

                        onSwipeLeft: _handleIncorrect,
                        onSwipeRight: _handleCorrect,
                        onRevealRequested: _revealBackDueToTimeout,
                        onFrontShown: _onCardFrontShown,
                        onBackShown: _onCardBackShown,
                      ),

                      // 🔎 TEMP DEBUG OVERLAY
                      _buildDebugOverlay(),
                    ],
                  ),
          ),
        ),

        if (_timerEnabled)
  Padding(
    padding: const EdgeInsets.all(8),
    child: Text(
      _timerCancelled
          ? t.flash_timerCancelled
          : '${t.flash_timeLabel}: $_remainingSeconds s',
    ),
  ),
      ],
    ),
  );
}
}