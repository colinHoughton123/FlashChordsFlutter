import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:flashchords/l10n/app_localizations.dart';
import 'package:flashchords/data/settings_repository.dart';

import 'package:flashchords/models/inversion_type.dart';
import 'package:flashchords/models/flashcard_item.dart';

import 'package:flashchords/features/flashcard/flashcard_engine.dart';
import 'package:flashchords/features/flashcard/flashcard_widget.dart';
import 'package:flashchords/features/summary/flashcard_summary_screen.dart';

import 'package:flashchords/services/chord_detection_services.dart';
import 'package:flashchords/core/system_error.dart';
import 'package:flashchords/core/system_error_code.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';


/// ---------- Localization helpers ----------

String _localizedChordName(AppLocalizations t, String chordName) {
  var r = chordName;
  r = r.replaceAll('Augmented', t.chord_augmented);
  r = r.replaceAll('Diminished', t.chord_diminished);
  r = r.replaceAll('Dominant 7th', t.chord_dominant7);
  r = r.replaceAll('Major 7th', t.chord_major7);
  r = r.replaceAll('Minor 7th', t.chord_minor7);
  r = r.replaceAll('Major', t.chord_major);
  r = r.replaceAll('Minor', t.chord_minor);
  r = r.replaceAll('Suspended 2', t.chord_suspended2);
  r = r.replaceAll('Suspended 4', t.chord_suspended4);
  r = r.replaceAll('&#9837;', '♭');
  return r;
}

/// ---------- Widget ----------

class FlashcardScreen extends ConsumerStatefulWidget {
  final List<FlashcardItem> items;
  final bool userPressedStart;

  const FlashcardScreen({
    super.key,
    required this.items,
    required this.userPressedStart,
  });
  

  @override
  ConsumerState<FlashcardScreen> createState() =>
      _FlashcardScreenState();
}

class _FlashcardScreenState extends ConsumerState<FlashcardScreen>
    with WidgetsBindingObserver {
  static const Duration _detectionBaseline = Duration(milliseconds: 300);
  static const bool _showDebugOverlay = false;

  late FlashcardEngine _engine;
  bool _engineReady = false;

  final GlobalKey<FlashcardWidgetState> _cardKey =
      GlobalKey<FlashcardWidgetState>();

  Timer? _timer;
  DateTime? _cardShownAt;


int _detectionCount = 0;
bool _firstFrameSeen = false;
DetectedNotesFrame? _lastFrame;
  bool _userPressedStart = false;
  bool _audioStarted = false;
  bool _audioStarting = false;

  bool _timerEnabled = false;
  bool _listeningEnabled = false;
  bool _evaluationEnabled = true;
  bool _cardFrontVisible = true;
  bool _frontEverShown = false;
  bool _autoMarked = false;
  bool _timedOut = false;

  int _timerSeconds = 5;
  int _remainingSeconds = 5;
  int _initialSeconds = 5;

  StreamSubscription<Set<String>>? _listenerSub;
  StreamSubscription<DetectedNotesFrame>? _frameSub;

  Set<String>? _previousChordNotes;
  Set<String>? _previousCorrectTargetNotes;

  DateTime? _lastDetectionAt;
  Set<String>? _lastDetectedNotes;
  String _lastDecision = '-';

  // ============================================================
  // Lifecycle
  // ============================================================

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
     _userPressedStart = widget.userPressedStart;
    _init();
  }

Future<void> _init() async {
  await _loadSettings();
  await _initEngine();

  if (!mounted) return;

  setState(() {
    _engineReady = true;
    _startTimingForCurrentCard(); // arms the target notes
  });

  // ✅ Start audio AFTER first UI paint, when everything is settled.
  //WidgetsBinding.instance.addPostFrameCallback((_) async {
   // await _startListeningIfNeeded();
  //});
}

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    _listenerSub?.cancel();
    _frameSub?.cancel();

    // 🔴 HARD audio shutdown (critical)
    // ChordDetectionService.instance.reset();

    // ChordDetectionService.instance.hardStop(); // 👈 

    super.dispose();
  }

  // ============================================================
  // Setup
  // ============================================================

  Future<void> _loadSettings() async {
    final repo = SettingsRepository();
    final (timerEnabled, seconds) = await repo.loadTimer();
    final listenEnabled = await repo.loadListenMode();

    _timerEnabled = timerEnabled;
    _timerSeconds = seconds;
    _remainingSeconds = seconds;
    _listeningEnabled = listenEnabled;
  }

  Future<void> _initEngine() async {
    final repo = SettingsRepository();

    final selectedRoots = await repo.loadRoots();
    final selectedTypes = await repo.loadChordTypes();
    final selectedInversions = await repo.loadInversions();
    final orderMode = await repo.loadCardOrder();

    String invKey(InversionType i) =>
        i == InversionType.root ? 'root' : i == InversionType.first ? 'first' : 'second';

    final filtered = widget.items.where((item) {
      return (selectedRoots.isEmpty || selectedRoots.contains(item.root)) &&
             (selectedTypes.isEmpty || selectedTypes.contains(item.chordType)) &&
             (selectedInversions.isEmpty || selectedInversions.contains(invKey(item.inversion)));
    }).toList();

    filtered.sort((a, b) {
      final inv = a.inversion.index.compareTo(b.inversion.index);
      if (inv != 0) return inv;
      final type = a.chordType.compareTo(b.chordType);
      if (type != 0) return type;
      return a.root.compareTo(b.root);
    });

    if (orderMode == 'random') filtered.shuffle();

    _engine = FlashcardEngine(filtered.isEmpty ? widget.items : filtered);
  }

  // ============================================================
  // Audio start (SAFE)
  // ============================================================
void _subscribeToDetectedNotesIfNeeded() {
  if (!_listeningEnabled) return;
  if (_listenerSub != null) return;

  _listenerSub =
      ChordDetectionService.instance.detectedNotesStream.listen((detected) {
    _detectionCount++;
    _lastDetectionAt = DateTime.now();

    if (!mounted) return;

    setState(() {
      _handleDetectedNotes(detected);
    });
  });
}

void _subscribeToFramesIfNeeded() {
  if (_frameSub != null) return;

  _frameSub =
      ChordDetectionService.instance.detectedFrameStream.listen((frame) {
    if (!_firstFrameSeen) {
      _firstFrameSeen = true;
    }

    _lastFrame = frame;

    if (mounted) {
      setState(() {});
    }
  });
}


Future<void> _startListeningIfNeeded() async {
  debugPrint(
  '🎧 startListeningIfNeeded: '
  'listening=$_listeningEnabled '
  'engineReady=$_engineReady '
  'audioStarted=$_audioStarted '
  'audioStarting=$_audioStarting'
);
if (!_userPressedStart) {
  debugPrint('⛔ from startListingIfNeeded - audio blocked: user has not pressed START');
  return;
}
  if (!_listeningEnabled) return;
  if (!_engineReady) return;
  if (_audioStarted || _audioStarting) return;

  _audioStarting = true;

  try {
    // ✅ 1️⃣ SUBSCRIBE FIRST (critical)
    _subscribeToDetectedNotesIfNeeded();
    _subscribeToFramesIfNeeded();

    // ✅ 2️⃣ allow subscriptions to attach
    await Future<void>.delayed(Duration.zero);

    // ✅ 3️⃣ start audio LAST
    await ChordDetectionService.instance.start();

    if (!mounted) return;

    setState(() {
      _audioStarted = true;
    });

    debugPrint('🎙 Listening STARTED (audio + streams active)');
  } catch (e, st) {
    debugPrint('🎙 Audio start failed safely: $e');
    debugPrint('$st');
  } finally {
    _audioStarting = false;
  }
}



  void _subscribeToDetectedNotes() {
    _listenerSub ??=
        ChordDetectionService.instance.detectedNotesStream.listen(_handleDetectedNotes);
  }

  void _subscribeToFrames() {
    _frameSub ??=
        ChordDetectionService.instance.detectedFrameStream.listen((frame) {
          if (!mounted) return;
          setState(() {});
        });
  }

  // ============================================================
  // Card timing
  // ============================================================

void _startTimingForCurrentCard() {
  debugPrint('⏱ startTimingForCurrentCard');

  final currentCard = _engine.currentCard;
  if (currentCard == null) return;

  // 🔒 ARM FIRST — before audio can ever start
  ChordDetectionService.instance.armForChord(
    currentCard.noteSet,
    previousChordNotes: _previousCorrectTargetNotes,
  );

  debugPrint('🎼 ARM issued for ${currentCard.noteSet.join(",")}');

  // Reset card state
  _timer?.cancel();
  _timedOut = false;
  _frontEverShown = false;

  _cardShownAt = null;
  WidgetsBinding.instance.addPostFrameCallback((_) {
    _cardShownAt = DateTime.now();
  });

  _remainingSeconds = _timerSeconds;
  _initialSeconds = _timerSeconds;

  _cardFrontVisible = true;
  _evaluationEnabled = true;
  _autoMarked = false;

  if (_timerEnabled) {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() => _remainingSeconds--);
      if (_remainingSeconds <= 0) {
        timer.cancel();
        _revealBackDueToTimeout();
      }
    });
  }
}

  // ============================================================
  // Detection handling
  // ============================================================

  void _handleDetectedNotes(Set<String> detected) {
    _lastDetectedNotes = detected;
    _lastDetectionAt = DateTime.now();

    if (!_evaluationEnabled || !_cardFrontVisible || _autoMarked) return;

    final card = _engine.currentCard;
    if (card == null) return;

    final confirmedAt =
        ChordDetectionService.instance.evaluateCandidate(detected);

    if (confirmedAt == null || _cardShownAt == null) return;

    final elapsed = confirmedAt.difference(_cardShownAt!);

    _autoMarked = true;
    _evaluationEnabled = false;
    _previousCorrectTargetNotes = card.noteSet;

    _cardKey.currentState?.animateCorrect();
  }

  void _revealBackDueToTimeout() {
    _timedOut = true;
    _evaluationEnabled = false;
    _cardFrontVisible = false;
    _cardKey.currentState?.flipToBack();
  }

  // ============================================================
  // UI callbacks
  // ============================================================

 void _onCardFrontShown() {
  debugPrint('🟢 onCardFrontShown fired');

  // Only once per card
  if (_frontEverShown) return;

  setState(() {
    _frontEverShown = true;
    _cardFrontVisible = true;
    _lastDecision = 'front shown';
  });

  // 🔒 HARD GATES — do NOT auto-start audio
  if (!_userPressedStart) {
    debugPrint('⛔ audio NOT started: user has not pressed START');
    return;
  }

  if (!_engineReady) {
    debugPrint('⛔ audio NOT started: engine not ready');
    return;
  }

  _startListeningIfNeeded();
}

    void _onCardBackShown() {
    if (!_frontEverShown) return;
    _cardFrontVisible = false;
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    if (!_engineReady) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final card = _engine.currentCard;
    if (card == null) return const SizedBox.shrink();

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
  body: Column(
    children: [
      // 🎧 LISTENING INDICATOR (RESTORED)
      _buildListeningIndicator(t),
      const SizedBox(height: 6),

      // 📊 Progress line
      Text(
        t.flash_cards_played(played, remaining),
        style: Theme.of(context).textTheme.bodyMedium,
      ),

      const SizedBox(height: 8),

      // 🎴 Flashcard
      Expanded(
        child: Stack(
          children: [
            FlashcardWidget(
              key: _cardKey,
              cardId:
                  '${card.root}_${card.chordType}_${card.inversion.index}',
              chordLabel: card.writtenAs,
              cardTitle: _localizedChordName(t, card.chordName),
              inversion: card.inversion,
              imageAssetPaths: card.imagePaths,
              onSwipeLeft: _handleIncorrect,
              onSwipeRight: _handleCorrect,
              onRevealRequested: _revealBackDueToTimeout,
              onFrontShown: _onCardFrontShown,
              onBackShown: _onCardBackShown,
            ),

            // 🐞 Optional debug overlay (unchanged)
            // if (_showDebugOverlay) _buildDebugOverlay(),
          ],
        ),
      ),

      // ⏱ TIMER (unchanged)
      if (_timerEnabled)
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            '${t.flash_timeLabel}: $_remainingSeconds s',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
    ],
  ),
);
  }


Widget _buildListeningIndicator(AppLocalizations t) {
  if (!_listeningEnabled || !_audioStarted || !_cardFrontVisible) {
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


Future<void> _handleIncorrect() async {
  _timer?.cancel();

  final elapsed = _timedOut
      ? Duration(seconds: _initialSeconds)
      : (_cardShownAt != null
          ? DateTime.now().difference(_cardShownAt!)
          : Duration.zero);

  _engine.markIncorrect(elapsed: elapsed);

  if (_engine.deckFinished) {
    await _showSummaryScreen();
    return;
  }

  setState(() => _startTimingForCurrentCard());
}


  Future<void> _handleCorrect({Duration? elapsedOverride}) async {
    final elapsed = elapsedOverride ??
        (_timedOut
            ? Duration(seconds: _initialSeconds)
            : DateTime.now().difference(_cardShownAt!));

    _engine.markCorrect(elapsed);

    if (_engine.deckFinished) {
      await _showSummaryScreen();
      return;
    }

    setState(_startTimingForCurrentCard);
  }

  Future<void> _showSummaryScreen() async {
    final choice = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (_) => FlashcardSummaryScreen(
          totalCorrect: _engine.totalCorrect,
          totalIncorrect: _engine.totalIncorrect,
          totalCards: _engine.totalCorrect + _engine.totalIncorrect,
          averageSecondsCorrect: _engine.averageSecondsCorrect,
          averageSecondsAll: _engine.averageSecondsAll,
          showAverage: _timerEnabled,
          hadErrors: _engine.hasErrorsForNextRound,
          isErrorDeck: _engine.usingErrorDeck,
        ),
      ),
    );

    if (!mounted) return;

    if (choice == 'restart') {
      _engine.startErrorsDeckOrRestartMain();
      _startTimingForCurrentCard();
    } else {
      Navigator.of(context).pop();
    }
  }
}