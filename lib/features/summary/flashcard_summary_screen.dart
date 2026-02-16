import 'package:flutter/material.dart';

import 'package:flashchords/l10n/app_localizations.dart';
import 'package:flashchords/core/free_listener_usage.dart';
import 'package:flashchords/data/settings_repository.dart';
import 'package:flashchords/services/analytics_service.dart';
import 'package:flashchords/widgets/upgrade_dialog.dart';

class FlashcardSummaryScreen extends StatefulWidget {

 
  final int totalCorrect;
  final int totalIncorrect;
  final int totalCards;

  final double averageSecondsCorrect;
  final double averageSecondsAll;

  final bool showAverage;
  final bool hadErrors;
  final bool isErrorDeck;

  /// Listener state at time the deck was played
  //final bool listenerEnabled;
  final bool listenerWasEnabled;

  const FlashcardSummaryScreen({
    super.key,
    required this.totalCorrect,
    required this.totalIncorrect,
    required this.totalCards,
    required this.averageSecondsCorrect,
    required this.averageSecondsAll,
    required this.showAverage,
    required this.hadErrors,
    required this.isErrorDeck,
    required this.listenerWasEnabled,
  });

  @override
  State<FlashcardSummaryScreen> createState() =>
      _FlashcardSummaryScreenState();
}

class _FlashcardSummaryScreenState extends State<FlashcardSummaryScreen> {
  bool _usageCounted = false;
  FreeListenerUsage? _usage;

  @override
  void initState() {
    super.initState();


    analytics?.logEvent(
      name: 'summary_screen_viewed',
    );
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _handleFreeListenerUsage();

      if (!mounted || _usage == null) return;

      final t = AppLocalizations.of(context)!;
      await _maybeShowListenerLimitDialog(context, t, _usage!);
    });
  }

  // ─────────────────────────────────────────────
  // 🔴 Persistently force listener OFF
  // ─────────────────────────────────────────────
  Future<void> _forceListenerOff() async {
    final repo = SettingsRepository();
    await repo.saveListenMode(false);
  }

  // ─────────────────────────────────────────────
  // 🔢 Load + increment free listener usage
  // ─────────────────────────────────────────────
  Future<void> _handleFreeListenerUsage() async {

    debugPrint('🧮 USAGE CHECK in handleFreeListenerUsage');
debugPrint('   listenerWasEnabled=${widget.listenerWasEnabled}');
debugPrint('   isErrorDeck=${widget.isErrorDeck}');
debugPrint('   totalCards=${widget.totalCards}');


    if (_usageCounted) return;

    final usage = FreeListenerUsage();
    await usage.load();

    // ✅ Increment exactly once per MAIN deck summary
   if (widget.listenerWasEnabled && !widget.isErrorDeck) {
      await usage.increment(widget.totalCards);
      }

    _usageCounted = true;

    if (!mounted) return;
    setState(() {
      _usage = usage;
    });
  }

  // ─────────────────────────────────────────────
  // 🚨 Listener limit dialog + shutdown
  // ─────────────────────────────────────────────
  Future<void> _maybeShowListenerLimitDialog(
    BuildContext context,
    AppLocalizations t,
    FreeListenerUsage usage,
  ) async {
    if (!usage.isLimitReached) return;
    if (usage.dialogShown) return;
    if (widget.hadErrors) return;

    // 🔴 FORCE LISTENER OFF IMMEDIATELY
    await _forceListenerOff();

    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => AlertDialog(
        title: Text(t.listenerLimitDialogTitle),
        content: Text(
          t.listenerLimitDialogBody(FreeListenerUsage.upgradePrice),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(t.later),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              showUpgradeRequiredDialog(
                context: context,
                t: t,
                limit: usage.limit,
              );
            },
            child: Text(t.upgrade),
          ),
        ],
      ),
    );

    await usage.markDialogShown();

    // 🔑 Notify parent that listener is now OFF
    await _forceListenerOff();
  }

  // ─────────────────────────────────────────────
  // 🖼 UI
  // ─────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    final accuracy = widget.totalCards == 0
        ? 0.0
        : (widget.totalCorrect / widget.totalCards * 100.0);

    final deckLabel = widget.isErrorDeck
        ? t.summary_from_error_deck
        : t.summary_from_main_deck;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () => Navigator.pop(context, 'done'),
        ),
        title: Text(t.summary_title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              deckLabel,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "${t.summary_correct}: ${widget.totalCorrect}",
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  "${t.summary_incorrect}: ${widget.totalIncorrect}",
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),

            const SizedBox(height: 18),

            Text(
              "${t.summary_cards}: ${widget.totalCards}",
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 18),

            Text(
              "${t.summary_accuracy}: ${accuracy.toStringAsFixed(1)}%",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 18),

            if (widget.showAverage) ...[
              Text(
                "${t.summary_average_time_correct}: "
                "${widget.averageSecondsCorrect.toStringAsFixed(2)} "
                "${t.summary_seconds}",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                "${t.summary_average_time_all}: "
                "${widget.averageSecondsAll.toStringAsFixed(2)} "
                "${t.summary_seconds}",
                style: const TextStyle(fontSize: 18),
              ),
            ],

            const Spacer(),

            // ✅ Show usage only when no error deck remains
            if (_usage != null && !widget.hadErrors)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: GestureDetector(
                  onTap: _usage!.isLimitReached
                      ? () {
                          showUpgradeRequiredDialog(
                            context: context,
                            t: t,
                            limit: _usage!.limit,
                          );
                        }
                      : null,
                  child: Text(
                    _usage!.isLimitReached
                        ? t.listenerLimitReachedBody(_usage!.limit)
                        : t.freeUsageStatus(
                            _usage!.limit,
                            _usage!.played,
                          ),
                    style: TextStyle(
                      fontSize: 13,
                      color: _usage!.isLimitReached
                          ? Colors.redAccent
                          : Colors.black54,
                      decoration: _usage!.isLimitReached
                          ? TextDecoration.underline
                          : TextDecoration.none,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.hadErrors)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context, 'restart'),
                      child: Text(t.summary_play_again),
                    ),
                  ),
                OutlinedButton(
                  onPressed: () => Navigator.pop(context, 'done'),
                  child: Text(t.summary_done),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
