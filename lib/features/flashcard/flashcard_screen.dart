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
import 'package:flashchords/core/free_listener_usage.dart';

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



@override
void didChangeDependencies() {
  super.didChangeDependencies();
  _reloadListenerState();
}

Future<void> _reloadListenerState() async {
  final repo = SettingsRepository();
  final enabled = await repo.loadListenMode();

  setState(() {
    _listeningEnabled = enabled;
    _listenerEnabledAtDeckStart = enabled;
  });

  debugPrint(
    '🔄 Reloaded listener state → enabled=$enabled',
  );
}

@override
void didChangeAppLifecycleState(AppLifecycleState state) {
  debugPrint('🧬 LIFECYCLE → $state | audioStarted=$_audioStarted | audioStarting=$_audioStarting');

  switch (state) {
    case AppLifecycleState.resumed:
      return;

    case AppLifecycleState.inactive:
      // Android often sends this transiently during permission dialogs / focus changes.
      // Do NOT stop audio here.
      return;

    case AppLifecycleState.paused:
    case AppLifecycleState.detached:
    case AppLifecycleState.hidden: // required by newer SDKs
      if (_audioStarting) {
        debugPrint('🧬 lifecycle stop skipped: audioStarting=true');
        return;
      }
      debugPrint('📱 lifecycle → stopping audio');
      ChordDetectionService.instance.hardStop(clearState: true);
      _audioStarted = false;
      return;
  }
}


void _log(String msg) {
  debugPrint('🧭 [FlashcardScreen] $msg');
}


void _logState(String where) {

  final engine = _engine;
if (engine == null) return;

// final card = engine.currentCard ?? _lastNonNullCard;

  final card = engine.currentCard ?? _lastNonNullCard;
  _log('$where | '
      'card=${card?.root}_${card?.chordType}_${card?.inversion.index} '
      'front=$_cardFrontVisible eval=$_evaluationEnabled auto=$_autoMarked '
      'timerOn=$_timerEnabled rem=$_remainingSeconds '
      'listenOn=$_listeningEnabled audioStarted=$_audioStarted audioStarting=$_audioStarting '
      'shownAt=$_cardShownAt resolved=${_resolvedElapsed?.inMilliseconds}');
}


  FlashcardItem? _lastNonNullCard;  
  FlashcardEngine? _engine;   // ← nullable, NOT late
  bool _engineReady = false;

  final GlobalKey<FlashcardWidgetState> _cardKey =
      GlobalKey<FlashcardWidgetState>();

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
  bool _listenerBooting = false;
  bool _evaluationEnabled = true;
  bool _cardFrontVisible = true;
  bool _frontEverShown = false;
  bool _autoMarked = false;
  bool _advanceInProgress = false;
  bool _revealedDuringTimer = false;

  // late final bool _listenerEnabledAtDeckStart;
  bool _listenerEnabledAtDeckStart = false;
  bool _listenerSnapshotTaken = false;
  bool _listenerStartScheduled = false;

  int _timerSeconds = 5;
  int _remainingSeconds = 5;

  StreamSubscription<ConfirmedChord>? _listenerSub;
  StreamSubscription<DetectedNotesFrame>? _frameSub;

  Set<String>? _previousCorrectTargetNotes;

  Animation<double>? _routeAnimation;
  AnimationStatusListener? _routeStatusListener;


Duration _ensureResolvedElapsed(String reason) {
  if (_resolvedElapsed != null) {
    return _resolvedElapsed!;
  }

  if (_timingStartedAt == null) {
    _resolvedElapsed = Duration.zero;
    return _resolvedElapsed!;
  }

  _resolvedElapsed = DateTime.now().difference(_timingStartedAt!);

  // 🎯 UX CLAMP: eliminate micro-latency when chord already held
  if (_resolvedElapsed! < const Duration(milliseconds: 300)) {
    _resolvedElapsed = Duration.zero;
  }

  debugPrint(
    '⏱ resolveElapsed [$reason]: '
    '${_resolvedElapsed!.inMilliseconds} ms '
    'startedAt=$_timingStartedAt'
  );

  return _resolvedElapsed!;
}
  // ============================================================
  // Lifecycle
  // ============================================================

@override
void initState() {
  super.initState();
  debugPrint('🚀 FlashcardScreen.initState');

  WidgetsBinding.instance.addObserver(this);

  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (!mounted) return;
    _init(); // <-- safe now
  });
}

  Future<void> _init() async {
    debugPrint('⚙️ _init START');

    await _loadSettings();
    await _initEngine();
    debugPrint('⚙️ _init AFTER engineReady=$_engineReady');

    if (!mounted) return;

    setState(() {
      _engineReady = true;
      _startTimingForCurrentCard();

      // If listener is enabled, show overlay immediately.
      if (_listeningEnabled && widget.userPressedStart) {
        _listenerBooting = true;
      }
    });

    // Schedule listener start after the route transition completes.
    _scheduleListenerStartAfterTransition();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    _listenerSub?.cancel();
    _frameSub?.cancel();
    if (_routeAnimation != null && _routeStatusListener != null) {
      _routeAnimation!.removeStatusListener(_routeStatusListener!);
    }
    super.dispose();
  }

  // ============================================================
  // Setup
  // ============================================================

Future<void> _loadSettings() async {
  final repo = SettingsRepository();

  final (timerEnabled, seconds) = await repo.loadTimer();
  final listenEnabled = await repo.loadListenMode();

  final usage = FreeListenerUsage();
  await usage.load();

  // 🔒 Defensive guard (safe even if already enforced elsewhere)
  _listeningEnabled = listenEnabled && !usage.isLimitReached;

  _timerEnabled = timerEnabled;
  _timerSeconds = seconds;
  _remainingSeconds = seconds;

  // 🔑 Freeze listener state for THIS deck
  // _listenerEnabledAtDeckStart = _listeningEnabled;

  //if (_listenerEnabledAtDeckStart == null) {
  //  _listenerEnabledAtDeckStart = _listeningEnabled;
  //  debugPrint(
  //    '📌 listener snapshot at deck start = $_listenerEnabledAtDeckStart'//
  //  );
  _listeningEnabled = listenEnabled && !usage.isLimitReached;


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

//final engine = _engine;
//if (engine == null) return;
_engine = FlashcardEngine(
  filtered.isEmpty ? widget.items : filtered,
);
   //  _engine = FlashcardEngine(filtered.isEmpty ? widget.items : filtered);
  }

  // ============================================================
  // Audio
  // ============================================================

// ============================================================
// Audio
// ============================================================

void _setListenerBooting(bool value) {
  if (_listenerBooting == value) return;
  if (!mounted) {
    _listenerBooting = value;
    return;
  }
  setState(() => _listenerBooting = value);
}

Future<void> _startListeningIfNeeded() async {
  debugPrint(
    '🎧 _startListeningIfNeeded ENTER '
    '| userPressedStart=${widget.userPressedStart} '
    '| listeningEnabled=$_listeningEnabled '
    '| engineReady=$_engineReady '
    '| audioStarted=$_audioStarted '
    '| audioStarting=$_audioStarting '
    '| frontVisible=$_cardFrontVisible'
  );

  _logState('_startListeningIfNeeded ENTER');

  if (!_listeningEnabled) {
    _log('🎧 skip: listening disabled in settings');
    _setListenerBooting(false);
    return;
  }

  if (!_engineReady) {
    _log('🎧 skip: engine not ready');
    _setListenerBooting(false);
    return;
  }

  if (_audioStarted) {
    _log('🎧 skip: audio already started');
    _setListenerBooting(false);
    return;
  }

  if (_audioStarting) {
    _log('🎧 skip: audio already starting');
    _setListenerBooting(false);
    return;
  }

  if (!widget.userPressedStart) {
    _log('🎧 skip: userPressedStart=false');
    _setListenerBooting(false);
    return;
  }

  _audioStarting = true;
  _log('🎧 scheduling audio start (post-frame)');

  // 🔑 THE FIX: defer native audio start until AFTER first frame
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    if (!mounted) {
      _audioStarting = false;
      _setListenerBooting(false);
      return;
    }

    // Double-guard (very important on iOS)
    if (_audioStarted || !_audioStarting) {
      _audioStarting = false;
      _setListenerBooting(false);
      return;
    }

    try {
      _listenerSub ??=
          ChordDetectionService.instance.confirmedChordStream.listen(
        (confirmed) {
          _log('✅ confirmedChordStream: ${confirmed.detected}');
          debugPrint('✅ confirmedChordStream detected=${confirmed.detected}');
          _handleDetectedNotes(confirmed);
        },
        onError: (e, st) {
          _log('❌ confirmedChordStream error: $e');
        },
      );

      _frameSub ??=
          ChordDetectionService.instance.detectedFrameStream.listen(
        (frame) {
          debugPrint(
            '🎞 frame hz=${frame.sampleRate} emitted=${frame.emitted}',
          );

          // Listener becomes "ready" when it emits real notes
          if (_listeningEnabled &&
              _timingStartedAt == null &&
              frame.emitted.isNotEmpty &&
              _evaluationEnabled) {
            _timingStartedAt = frame.at;
            debugPrint('⏱ timing started (listener ready)');
          }
        },
      );

      debugPrint('🎧 CALLING ChordDetectionService.start() (post-frame)');
      final ok = await ChordDetectionService.instance.start();
      debugPrint('🎙 ChordDetectionService.start() COMPLETED ok=$ok');

      if (!mounted) return;

      if (!ok) {
        _audioStarted = false;
        _log('❌ audio NOT started (service reported failure)');

        await _listenerSub?.cancel();
        _listenerSub = null;
        await _frameSub?.cancel();
        _frameSub = null;

        _setListenerBooting(false);
        return; // allow retry later
      }

      _audioStarted = true;
      _log('🎙 audio STARTED ✅');
    } catch (e, st) {
      _log('❌ startListeningIfNeeded exception: $e');
      debugPrint('$st');
    } finally {
      _audioStarting = false;
      _setListenerBooting(false);
      _logState('_startListeningIfNeeded EXIT');
    }
  });
}

void _scheduleListenerStartAfterTransition() {
  if (_listenerStartScheduled) return;
  if (!_listeningEnabled) return;
  if (_audioStarted || _audioStarting) return;
  if (!widget.userPressedStart) return;

  final route = ModalRoute.of(context);
  final animation = route?.animation;

  _setListenerBooting(true);
  _listenerStartScheduled = true;

  if (animation == null) {
    // Delay slightly to avoid jank on first frame.
    Future.delayed(const Duration(milliseconds: 150), _startListeningIfNeeded);
    return;
  }

  if (animation.status == AnimationStatus.completed) {
    Future.delayed(const Duration(milliseconds: 150), _startListeningIfNeeded);
    return;
  }

  _routeAnimation = animation;
  _routeStatusListener ??= (status) {
    if (status != AnimationStatus.completed) return;
    if (_routeAnimation != null && _routeStatusListener != null) {
      _routeAnimation!.removeStatusListener(_routeStatusListener!);
    }
    _routeStatusListener = null;
    Future.delayed(const Duration(milliseconds: 150), _startListeningIfNeeded);
  };

  animation.addStatusListener(_routeStatusListener!);
}
  // ============================================================
  // Timing
  // ============================================================

void _startTimingForCurrentCard() {
  final engine = _engine;
  if (engine == null) return;

  final played = engine.totalCorrect + engine.totalIncorrect;

  final card = engine.currentCard ?? _lastNonNullCard;
  if (card == null) return;

  debugPrint('⏱ startTimingForCurrentCard for ${card.writtenAs}');

  _lastNonNullCard = card;

  // ─────────────────────────────────────────────
  // 🔑 SNAPSHOT listener state ONCE at deck start
  // ─────────────────────────────────────────────
  if (!_listenerSnapshotTaken && played == 0) {
  _listenerEnabledAtDeckStart = _listeningEnabled;
  _listenerSnapshotTaken = true;

  debugPrint(
    '🎬 Deck START → listener snapshot = $_listenerEnabledAtDeckStart'
  );
}

  // ─────────────────────────────────────────────
  // Reset per-card timing / evaluation state
  // ─────────────────────────────────────────────

  
  
  _firstMatchAt = null;
  _resolvedElapsed = null;
  _timingStartedAt = null; // 🔑 reset

  _evaluationEnabled = true;
  _cardFrontVisible = true;
  _frontEverShown = false;
  _autoMarked = false;
  _revealedDuringTimer = false;

  // 🔑 RESET DETECTOR STATE (THIS WAS MISSING)
  ChordDetectionService.instance.prepareForNextCard();

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

          // 🔒 HARD LOCK elapsed time at exact timer duration
          _resolvedElapsed = Duration(seconds: _timerSeconds);

          _revealBack();
        }
      });
  }
}


void _revealBack() {
  _log('🃏 revealBack requested');

  setState(() {
    _ensureResolvedElapsed('revealBack');
    _evaluationEnabled = false;
    _cardFrontVisible = false;

    // Optional polish
    if (!_timerEnabled) {
      _remainingSeconds = 0;
    }
    if (_timerEnabled) {
      _revealedDuringTimer = _remainingSeconds > 0;
    }
  });

  if (_timerEnabled) {
    _timer?.cancel();
  }
}

  // ============================================================
  // Detection
  // ============================================================

Future<void> _handleDetectedNotes(ConfirmedChord confirmed) async {
  _logState('_handleDetectedNotes ENTER');
  _log('🎯 confirmed=${confirmed.detected}');

  // ------------------------------------------------------------
  // Guard rails
  // ------------------------------------------------------------
  if (!_listeningEnabled) {
    _log('🎯 ignore: listening disabled');
    return;
  }
  if (_advanceInProgress) {
    _log('🎯 ignore: advance in progress');
    return;
  }
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

final engine = _engine;
if (engine == null) return;

  final card = engine.currentCard;
  if (card == null) {
    _log('🎯 ignore: no current card');
    return;
  }

  final targetNotes = card.noteSet;

  // ------------------------------------------------------------
  // STEP 1: LOCK ELAPSED TIME ON FIRST CORRECT FRAME (from service)
  // ------------------------------------------------------------
  if (_timingStartedAt != null) {
    _firstMatchAt = confirmed.firstCorrectAt;
    _resolvedElapsed =
        confirmed.firstCorrectAt.difference(_timingStartedAt!);

    _log(
      '⏱ FIRST MATCH (service) — elapsed locked at '
      '${_resolvedElapsed!.inMilliseconds} ms '
      '(startedAt=$_timingStartedAt firstMatchAt=${confirmed.firstCorrectAt})'
    );
  }

  // ------------------------------------------------------------
  // STEP 2: CONFIRMED — AUTO-CORRECT
  // ------------------------------------------------------------
  _log('✅ CONFIRMED by listener at ${confirmed.confirmedAt}');

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
  await _requestCorrectAdvance(source: 'listener');
}

  // ============================================================
  // UI Callbacks
  // ============================================================

void _onCardFrontShown() {
  final engine = _engine;
  if (engine == null) return;

  debugPrint(
    '👀 onFrontShown fired '
    '| card=${engine.currentCard?.writtenAs} '
    '| userPressedStart=${widget.userPressedStart}'
  );

  if (_frontEverShown) {
    _log('👀 ignored: already shown once');
    return;
  }
  _frontEverShown = true;

  // ─────────────────────────────────────────────
  // 🔑 RESET *ALL* per-card evaluation state
  // ─────────────────────────────────────────────
 // _evaluationEnabled = true;  // added for android but may have caused 1st card no longer working

  _firstMatchAt = null;
  _timingStartedAt = null;

  // Optional safety (does NOT affect timing)
  _resolvedElapsed = null;

  _log('🎧 evaluation reset for new card');

  // For timer-only mode, start timing now that the front is visible.
  if (_timerEnabled && !_listeningEnabled) {
    _timingStartedAt = DateTime.now();
  }

  // Listener start is scheduled once from _init after transition completes.
}

  void _onSwipeAnimationStarted() {
    _advanceInProgress = true;
    _evaluationEnabled = false;
  }

  // ============================================================
  // Handlers
  // ============================================================
Future<void> _handleCorrectCommit() async {
  final engine = _engine;
if (engine == null) return;

debugPrint('🟩 handleCorrect fired currentCard=${engine.currentCard}');
  _timer?.cancel();

  final elapsed = _ensureResolvedElapsed('handleCorrect');


engine.markCorrect(elapsed);

  if (engine.deckFinished) {
    _advanceInProgress = false;
    await _showSummary();
    return;
  }

  setState(() {});              // ✅ rebuild with new currentCard
  _startTimingForCurrentCard(); // ✅ arm + timer + listener

  _advanceInProgress = false;
}

Future<void> _handleIncorrect() async {
  final engine = _engine;
if (engine == null) return;
  debugPrint('🟥 handleIncorrect fired currentCard=${engine.currentCard}');
  _timer?.cancel();

  Duration elapsed;
  if (_timerEnabled && _revealedDuringTimer) {
    elapsed = Duration(seconds: _timerSeconds);
  } else {
    elapsed = _ensureResolvedElapsed('handleIncorrect');
  }
  engine.markIncorrect(elapsed);

  if (engine.deckFinished) {
    _advanceInProgress = false;
    await _showSummary();
    return;
  }

  setState(() {});
  _startTimingForCurrentCard();

  _advanceInProgress = false;
}

Future<void> _requestCorrectAdvance({required String source}) async {
  if (_advanceInProgress) {
    _log('🟩 requestCorrectAdvance ignored: already in progress ($source)');
    return;
  }
  _advanceInProgress = true;
  _evaluationEnabled = false;

  _ensureResolvedElapsed('requestCorrectAdvance:$source');

  final cardState = _cardKey.currentState;
  if (cardState != null) {
    await cardState.animateOut(toRight: true);
  }

  if (!mounted) return;
  await _handleCorrectCommit();
}

Future<void> _exitToMainMenu() async {
  debugPrint('🏁 Done — returning to main menu');

  await ChordDetectionService.instance.hardStop();

  if (!mounted) return;
  Navigator.of(context).pop();
}


Future<void> _restartFromSummary() async {
  debugPrint('🔁 Restart requested from summary');

  final engine = _engine;
  if (engine == null) return;

  final repo = SettingsRepository();
  final listenEnabled = await repo.loadListenMode();

  if (!listenEnabled && _audioStarted) {
    await ChordDetectionService.instance.hardStop(clearState: true);
    _audioStarted = false;
    _audioStarting = false;
  }

  setState(() {
    _listeningEnabled = listenEnabled;
    engine.startErrorsDeckOrRestartMain();
    _startTimingForCurrentCard();
  });
}





Future<void> _showSummary() async {



  final engine = _engine;
if (engine == null) return;

  debugPrint('📊 SUMMARY DATA as from _showSummary');
  debugPrint('   correct=${engine.totalCorrect}');
  debugPrint('   incorrect=${engine.totalIncorrect}');
  debugPrint('   avgCorrect=${engine.averageSecondsCorrect}');
  debugPrint('   avgAll=${engine.averageSecondsAll}');

 

  final result = await Navigator.push<String>(
    context,
    MaterialPageRoute(
      builder: (_) => FlashcardSummaryScreen(
        totalCorrect: engine.totalCorrect,
        totalIncorrect: engine.totalIncorrect,
        totalCards: engine.totalCorrect + engine.totalIncorrect,
        averageSecondsCorrect: engine.averageSecondsCorrect,
        averageSecondsAll: engine.averageSecondsAll,
        showAverage: _timerEnabled,
        hadErrors: engine.hasErrorsForNextRound,
        isErrorDeck: engine.usingErrorDeck,
        listenerWasEnabled: _listenerEnabledAtDeckStart ?? false,
      ),
    ),
  );

  debugPrint('📤 Summary returned result=$result');

  if (!mounted) return;

  switch (result) {
    case 'restart':
      _restartFromSummary();
      break;

    case 'listener_forced_off':
      debugPrint('🔇 Listener forced OFF by summary');

      setState(() {
        _listeningEnabled = false;
      });

      // stop audio input the SAME way you already do elsewhere
      // _engine?.stopListening(); // ← use YOUR engine method
      _exitToMainMenu();
      break;

    case 'done':
    default:
      _exitToMainMenu();
  }
}
  // ============================================================
  // BUILD
  // ============================================================

@override
Widget build(BuildContext context) {
  final t = AppLocalizations.of(context)!;

  // ✅ FIRST: guard engine existence
   if (_engine == null || !_engineReady) {
    debugPrint('🏗 build FlashcardScreen | engine not ready');
    return Scaffold(
      body: Stack(
        children: [
          const Center(child: CircularProgressIndicator()),
          if (_listenerBooting)
            Positioned.fill(
              child: Container(
                color: Colors.white.withOpacity(0.92),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(height: 16),
                      Text(
                        t.listenerStarting,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // 🔑 From here on, engine is GUARANTEED
  final engine = _engine!;

  debugPrint(
    '🏗 build FlashcardScreen '
    '| card=${engine.currentCard?.writtenAs} '
    '| audioStarted=$_audioStarted'
  );

  // (optional, if you still want this flag)
  if (!_engineReady) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }

  final card = engine.currentCard;
  if (card == null) {
    return const SizedBox.shrink();
  }

  final cardId = '${card.root}_${card.chordType}_${card.inversion.index}';

  final played = engine.totalCorrect + engine.totalIncorrect;
  final remaining = engine.deckSize - played;

  return Scaffold(
    // ⬅️ rest of your scaffold exactly as before
  backgroundColor: Colors.grey.shade100,

  appBar: AppBar(
    backgroundColor: const Color(0xFFF3E5F5), // washed purple
    elevation: 0,

    leading: IconButton(
      icon: const Icon(Icons.home),
      // tooltip: t.home, // localize if desired
      onPressed: _exitToMainMenu,
    ),

    title: Text(
      engine.usingErrorDeck
          ? t.flash_playing_wrong
          : t.flash_playing_main,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
    ),

    iconTheme: const IconThemeData(color: Colors.black87),
  ),

  body: Stack(
    children: [
      Column(
        children: [
      // ─────────────────────────────────────
      // TOP STATUS BAR (RESPONSIVE)
      // ─────────────────────────────────────
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isNarrow = constraints.maxWidth < 360;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${t.flash_incorrectCountLabel}: ${engine.totalIncorrect}',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${t.flash_correctCountLabel}: ${engine.totalCorrect}',
                        textAlign: TextAlign.end,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  '$played ${t.flash_playedLabel} • '
                  '$remaining ${t.flash_toGoLabel}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),
              ],
            );
          },
        ),
      ),

      // ─────────────────────────────────────
      // FLASHCARD
      // ─────────────────────────────────────
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: FlashcardWidget(
            key: _cardKey,
            cardId: cardId,
            chordLabel: card.writtenAs,
            writtenAs: card.writtenAs,
            writtenAsOriginal: card.writtenAsOriginal,
            cardTitle: _localizedChordName(t, card.chordName),
            inversion: card.inversion,
            imageAssetPaths: card.imagePaths,
            noteSet: card.noteSet,
            noteSetOriginal: card.noteSetOriginal,
            showBack: !_cardFrontVisible,
            onSwipeLeft: _handleIncorrect,
            onSwipeRight: _handleCorrectCommit,
            onRevealRequested: _revealBack,
            onFrontShown: _onCardFrontShown,
            onSwipeAnimationStarted: _onSwipeAnimationStarted,
          ),
        ),
      ),

      // ─────────────────────────────────────
      // LISTENER INDICATOR
      // ─────────────────────────────────────
      if (_listeningEnabled && _evaluationEnabled)
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            t.listeningActive, // localize if you want
            style: TextStyle(
              color: Colors.green.shade700,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),

      const SizedBox(height: 8),

      // ─────────────────────────────────────
      // BOTTOM TIMER (CENTERED)
      // ─────────────────────────────────────
      if (_timerEnabled)
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${t.flash_timeLabel}: $_remainingSeconds s',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  '${t.summary_average_time_correct}: '
                  '${engine.averageSecondsCorrect.toStringAsFixed(1)} ${t.summary_seconds}',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ),
        ],
      ),
      if (_listenerBooting)
        Positioned.fill(
          child: Container(
            color: Colors.white.withOpacity(0.92),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(
                    t.listenerStarting,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    ],
  ),
);


  }
}
