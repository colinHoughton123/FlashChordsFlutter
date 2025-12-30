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


void _log(String msg) {
  debugPrint('🧭 [FlashcardScreen] $msg');
}


void _logState(String where) {
  final card = _engine.currentCard ?? _lastNonNullCard;
  _log('$where | '
      'card=${card?.root}_${card?.chordType}_${card?.inversion.index} '
      'front=$_cardFrontVisible eval=$_evaluationEnabled auto=$_autoMarked '
      'timerOn=$_timerEnabled rem=$_remainingSeconds '
      'listenOn=$_listeningEnabled audioStarted=$_audioStarted audioStarting=$_audioStarting '
      'shownAt=$_cardShownAt resolved=${_resolvedElapsed?.inMilliseconds}');
}


  FlashcardItem? _lastNonNullCard;  
  late FlashcardEngine _engine;
  bool _engineReady = false;

  //final GlobalKey<FlashcardWidgetState> _cardKey =
  //    GlobalKey<FlashcardWidgetState>();

  Timer? _timer;

  // 🔑 Timing (single source of truth)
  DateTime? _timingStartedAt;   // when time actually starts counting

  DateTime? _firstMatchAt;

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

  final start = _timingStartedAt;
  if (start == null) {
    debugPrint('⚠️ elapsed unresolved (timing never started)');
    _resolvedElapsed = Duration.zero;
    return _resolvedElapsed!;
  }

  _resolvedElapsed = DateTime.now().difference(start);

  debugPrint(
    '⏱ resolveElapsed [$reason]: '
    '${_resolvedElapsed!.inMilliseconds} ms '
    'startedAt=$start',
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
  _logState('_startListeningIfNeeded ENTER');

  if (!_listeningEnabled) { _log('🎧 skip: listening disabled in settings'); return; }
  if (!_engineReady) { _log('🎧 skip: engine not ready'); return; }
  if (_audioStarted) { _log('🎧 skip: audio already started'); return; }
  if (_audioStarting) { _log('🎧 skip: audio already starting'); return; }
  if (!widget.userPressedStart) { _log('🎧 skip: userPressedStart=false'); return; }

  _audioStarting = true;
  _log('🎧 starting audio + subscriptions...');

  try {
    _listenerSub ??= ChordDetectionService.instance.detectedNotesStream.listen((notes) {
      _log('🎯 detectedNotesStream: $notes');
      _handleDetectedNotes(notes);
    }, onError: (e, st) {
      _log('❌ detectedNotesStream error: $e');
    });

      _frameSub ??=
            ChordDetectionService.instance.detectedFrameStream.listen((frame) {
          // Debug
          debugPrint(
            '🎞 frame hz=${frame.sampleRate} emitted=${frame.emitted}',
          );

          // 🔑 Listener becomes "ready" when it emits real notes
          if (_listeningEnabled &&
              _timingStartedAt == null &&
              frame.emitted.isNotEmpty &&
              _evaluationEnabled) {

            _timingStartedAt = frame.at;
            debugPrint('⏱ timing started (listener ready)');
          }
        });

    await ChordDetectionService.instance.start();

    if (!mounted) return;
    _audioStarted = true;
    _log('🎙 audio STARTED ✅');
  } catch (e, st) {
    _log('❌ startListeningIfNeeded exception: $e');
  } finally {
    _audioStarting = false;
    _logState('_startListeningIfNeeded EXIT');
  }
}

  // ============================================================
  // Timing
  // ============================================================

void _startTimingForCurrentCard() {
  final card = _engine.currentCard ?? _lastNonNullCard;
  if (card == null) return;

  debugPrint('⏱ startTimingForCurrentCard for ${card.writtenAs}');

  _lastNonNullCard = card;

  _firstMatchAt = null;
  _resolvedElapsed = null;
  _timingStartedAt = null;   // 🔑 reset

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

  // ⏱ TIMER MODE (no listener)
  if (_timerEnabled && !_listeningEnabled) {
    _timingStartedAt = DateTime.now();
  }

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
  _log('🃏 revealBack requested');
  _ensureResolvedElapsed('revealBack');
  _evaluationEnabled = false;
  _cardFrontVisible = false;

  // IMPORTANT: actually show the back via widget callback
  // (you said timeout “show back” was lost — this is usually why)
  // Make sure FlashcardWidget has a method or callback to flip.
  // If you have widget.showBack (as you pasted), call it:
  // widget.showBack();  <-- see note below (belongs inside widget)
}

  // ============================================================
  // Detection
  // ============================================================

Future<void> _handleDetectedNotes(Set<String> detected) async {
  _logState('_handleDetectedNotes ENTER');
  _log('🎯 detected=$detected');

  // ------------------------------------------------------------
  // Guard rails
  // ------------------------------------------------------------
  if (!_evaluationEnabled) {
    _log('🎯 ignore: evaluation disabled');
    return;
  }
  if (!_cardFrontVisible) {
    _log('🎯 ignore: front not visible');
    return;
  }
  if (_autoMarked) {
    _log('🎯 ignore: already autoMarked');
    return;
  }

  final card = _engine.currentCard;
  if (card == null) {
    _log('🎯 ignore: no current card');
    return;
  }

  final targetNotes = card.noteSet;

  // ------------------------------------------------------------
  // 🔑 STEP 1: LOCK ELAPSED TIME ON *FIRST* MATCHING FRAME
  // ------------------------------------------------------------
  if (_firstMatchAt == null &&
      _timingStartedAt != null &&
      detected.containsAll(targetNotes)) {

    _firstMatchAt = DateTime.now();

    _resolvedElapsed =
        _firstMatchAt!.difference(_timingStartedAt!);

    _log(
      '⏱ FIRST MATCH — elapsed locked at '
      '${_resolvedElapsed!.inMilliseconds} ms '
      '(startedAt=$_timingStartedAt firstMatchAt=$_firstMatchAt)'
    );
  }

  // ------------------------------------------------------------
  // STEP 2: RUN CONFIRMATION LOGIC (noise filtering)
  // ------------------------------------------------------------
  final confirmedAt =
      ChordDetectionService.instance.evaluateCandidate(detected);

  if (confirmedAt == null) {
    _log('🎯 candidate not confirmed');
    return;
  }

  // ------------------------------------------------------------
  // STEP 3: CONFIRMED — AUTO-CORRECT
  // ------------------------------------------------------------
  _log('✅ CONFIRMED by listener at $confirmedAt');

  _autoMarked = true;
  _previousCorrectTargetNotes = targetNotes;

  // Safety: if for some reason first-match never fired,
  // fall back to "now" exactly once (should be rare)
  if (_resolvedElapsed == null) {
    _log('⚠️ fallback: resolving elapsed at confirmation time');
    _ensureResolvedElapsed('listenerConfirmedFallback');
  }

  _log('🧭 [FlashcardScreen] 🎯 AUTO-CORRECT by listener');

  // Treat exactly like a correct swipe
  await _handleCorrect();
}

  // ============================================================
  // UI Callbacks
  // ============================================================

 void _onCardFrontShown() {
  _log('👀 onFrontShown fired');
  if (_frontEverShown) { _log('👀 ignored: already shown once'); return; }
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