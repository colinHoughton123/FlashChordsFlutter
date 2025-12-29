// lib/features/flashcard/flashcard_screen.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flashchords/l10n/app_localizations.dart';
import 'package:flashchords/data/settings_repository.dart';
import 'package:flashchords/models/inversion_type.dart';
import 'package:flashchords/models/flashcard_item.dart';
import 'package:flashchords/features/flashcard/flashcard_engine.dart';
import 'package:flashchords/features/flashcard/flashcard_widget.dart';
import 'package:flashchords/features/summary/flashcard_summary_screen.dart';
import 'package:flashchords/features/welcome/welcome_screen.dart';
import 'package:flashchords/services/chord_detection_services.dart';

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
  ConsumerState<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends ConsumerState<FlashcardScreen>
    with WidgetsBindingObserver {



  FlashcardItem? _lastNonNullCard;  
  late FlashcardEngine _engine;
  bool _engineReady = false;

  //final GlobalKey<FlashcardWidgetState> _cardKey =
  //    GlobalKey<FlashcardWidgetState>();

  Timer? _timer;

  // 🔑 Timing (single source of truth)
  DateTime? _cardShownAt;
  Duration? _resolvedElapsed;

  bool _timerEnabled = false;
  bool _listeningEnabled = false;
  bool _audioStarted = false;
  bool _audioStarting = false;
  bool _evaluationEnabled = true;
  bool _cardFrontVisible = true;
  bool _frontEverShown = false;
  bool _autoMarked = false;

  int _timerSeconds = 5;
  int _remainingSeconds = 5;

  StreamSubscription<Set<String>>? _listenerSub;
  StreamSubscription<DetectedNotesFrame>? _frameSub;

  Set<String>? _previousCorrectTargetNotes;


Duration _ensureResolvedElapsed(String reason) {
  if (_resolvedElapsed != null) {
    debugPrint('⏱ elapsed already resolved: ${_resolvedElapsed!.inMilliseconds} ms');
    return _resolvedElapsed!;
  }

  if (_cardShownAt == null) {
    debugPrint('⚠️ elapsed unresolved (no cardShownAt)');
    _resolvedElapsed = Duration.zero;
    return _resolvedElapsed!;
  }

  _resolvedElapsed = DateTime.now().difference(_cardShownAt!);

  debugPrint(
    '⏱ resolveElapsed [$reason]: '
    '${_resolvedElapsed!.inMilliseconds} ms '
    'shownAt=$_cardShownAt'
  );

  return _resolvedElapsed!;
}

  // ============================================================
  // Lifecycle
  // ============================================================

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _init();
  }

  Future<void> _init() async {
    await _loadSettings();
    await _initEngine();

    if (!mounted) return;

    setState(() {
      _engineReady = true;
      _startTimingForCurrentCard();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    _listenerSub?.cancel();
    _frameSub?.cancel();
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

    if (orderMode == 'random') filtered.shuffle();

    _engine = FlashcardEngine(filtered.isEmpty ? widget.items : filtered);
  }

  // ============================================================
  // Audio
  // ============================================================

  Future<void> _startListeningIfNeeded() async {
    if (!_listeningEnabled ||
        !_engineReady ||
        _audioStarted ||
        _audioStarting ||
        !widget.userPressedStart) {
      return;
    }

    _audioStarting = true;

    try {
      _listenerSub ??=
          ChordDetectionService.instance.detectedNotesStream.listen(_handleDetectedNotes);

      _frameSub ??=
          ChordDetectionService.instance.detectedFrameStream.listen((_) {});

      await ChordDetectionService.instance.start();

      if (!mounted) return;
      _audioStarted = true;
    } finally {
      _audioStarting = false;
    }
  }

  // ============================================================
  // Timing
  // ============================================================

  void _startTimingForCurrentCard() {
    final card = _engine.currentCard ?? _lastNonNullCard;

if (card == null) {
  return; // only possible at startup
}

debugPrint('⏱ startTimingForCurrentCard for ${card.writtenAs}');

_lastNonNullCard = card;

    // Reset timing
    _cardShownAt = DateTime.now();
    _resolvedElapsed = null;

    _evaluationEnabled = true;
    _cardFrontVisible = true;
    _frontEverShown = false;
    _autoMarked = false;

    ChordDetectionService.instance.armForChord(
      card.noteSet,
      previousChordNotes: _previousCorrectTargetNotes,
    );

    _remainingSeconds = _timerSeconds;
    _timer?.cancel();

    if (_timerEnabled) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (!mounted) return;
        setState(() => _remainingSeconds--);
        if (_remainingSeconds <= 0) {
          timer.cancel();
          _revealBack();
        }
      });
    }
  }

void _revealBack() {
  _ensureResolvedElapsed('timeout or user reveal');

  setState(() {
    _evaluationEnabled = false;
    _cardFrontVisible = false; // ⬅️ THIS drives the widget
  });
}

  // ============================================================
  // Detection
  // ============================================================

  void _handleDetectedNotes(Set<String> detected) {
    if (!_evaluationEnabled || !_cardFrontVisible || _autoMarked) return;

    final confirmedAt =
        ChordDetectionService.instance.evaluateCandidate(detected);

    if (confirmedAt == null) return;

    _autoMarked = true;
    _previousCorrectTargetNotes = _engine.currentCard?.noteSet;

    // 🔑 Listener success REVEALS back — does not compute time
    _revealBack();
  }

  // ============================================================
  // UI Callbacks
  // ============================================================

  void _onCardFrontShown() {
    if (_frontEverShown) return;
    _frontEverShown = true;
    _startListeningIfNeeded();
  }

  void _onSwipeAnimationStarted() {
    // _startTimingForCurrentCard();
  }

  // ============================================================
  // Handlers
  // ============================================================
Future<void> _handleCorrect() async {
  debugPrint('🟩 handleCorrect fired currentCard=${_engine.currentCard}');
  _timer?.cancel();

  final elapsed = _ensureResolvedElapsed('handleCorrect');
  _engine.markCorrect(elapsed);

  if (_engine.deckFinished) {
    await _showSummary();
    return;
  }

  setState(() {});              // ✅ rebuild with new currentCard
  _startTimingForCurrentCard(); // ✅ arm + timer + listener
}

Future<void> _handleIncorrect() async {
  debugPrint('🟥 handleIncorrect fired currentCard=${_engine.currentCard}');
  _timer?.cancel();

  final elapsed = _ensureResolvedElapsed('handleIncorrect');
  _engine.markIncorrect(elapsed);

  if (_engine.deckFinished) {
    await _showSummary();
    return;
  }

  setState(() {});
  _startTimingForCurrentCard();
}

void _exitToMainMenu() {
  debugPrint('🏁 Done — returning to main menu');
  Navigator.of(context).pop();


}


void _restartFromSummary() {
  debugPrint('🔁 Restart requested from summary');

  setState(() {
    _engine.startErrorsDeckOrRestartMain(); // IMPORTANT: this must respect error deck state
    _startTimingForCurrentCard();
  });
}


Future<void> _showSummary() async {
  debugPrint('📊 SUMMARY DATA as from _showSummary');
  debugPrint('   correct=${_engine.totalCorrect}');
  debugPrint('   incorrect=${_engine.totalIncorrect}');
  debugPrint('   avgCorrect=${_engine.averageSecondsCorrect}');
  debugPrint('   avgAll=${_engine.averageSecondsAll}');

  final result = await Navigator.push<String>(
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

  debugPrint('📤 Summary returned result=$result');

  if (!mounted) return;

  switch (result) {
    case 'restart':
      _restartFromSummary();
      break;

    case 'done':
      _exitToMainMenu();
      break;

    default:
      // User backed out or system pop — treat as done
      _exitToMainMenu();
  }
}
  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    if (!_engineReady) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final card = _engine.currentCard;
    if (card == null) return const SizedBox.shrink();


  final cardId = '${card.root}_${card.chordType}_${card.inversion.index}';




    return Scaffold(
      appBar: AppBar(
        title: Text(_engine.usingErrorDeck
            ? t.flash_playing_wrong
            : t.flash_playing_main),
      ),
      body: Column(
        children: [
          Expanded(
            child: FlashcardWidget(
              key: ValueKey(cardId),          // ✅ this replaces GlobalKey
              cardId: cardId,                 // ✅ same id, passed separately
              chordLabel: card.writtenAs,
              cardTitle: _localizedChordName(t, card.chordName),
              inversion: card.inversion,
              imageAssetPaths: card.imagePaths,
              showBack: !_cardFrontVisible,
              onSwipeLeft: _handleIncorrect,
              onSwipeRight: _handleCorrect,
              onRevealRequested: _revealBack,
              onFrontShown: _onCardFrontShown,
              onSwipeAnimationStarted: _onSwipeAnimationStarted,
            ),
          ),
          if (_timerEnabled)
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text('${t.flash_timeLabel}: $_remainingSeconds s'),
            ),
        ],
      ),
    );
  }
}