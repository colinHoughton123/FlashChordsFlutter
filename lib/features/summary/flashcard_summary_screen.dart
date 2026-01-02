import 'package:flutter/material.dart';

import 'package:flashchords/l10n/app_localizations.dart';
import 'package:flashchords/core/free_listener_usage.dart';

class FlashcardSummaryScreen extends StatefulWidget {
  final int totalCorrect;
  final int totalIncorrect;
  final int totalCards;

  final double averageSecondsCorrect;
  final double averageSecondsAll;

  final bool showAverage;
  final bool hadErrors;
  final bool isErrorDeck;

  /// Known by caller
  final bool listenerEnabled;

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
    required this.listenerEnabled,
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

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _handleFreeListenerUsage();

      if (!mounted || _usage == null) return;

      final t = AppLocalizations.of(context)!;
      await _maybeShowListenerLimitDialog(context, t, _usage!);
    });
  }

  Future<void> _handleFreeListenerUsage() async {
    if (_usageCounted) return;

    if (!widget.listenerEnabled || widget.isErrorDeck) return;

    final usage = FreeListenerUsage();
    await usage.load();

    await usage.increment(widget.totalCards);
    _usageCounted = true;

    setState(() {
      _usage = usage;
    });
  }

  Future<void> _maybeShowListenerLimitDialog(
    BuildContext context,
    AppLocalizations t,
    FreeListenerUsage usage,
  ) async {
    if (!usage.isLimitReached) return;
    if (usage.dialogShown) return;
    if (widget.hadErrors) return;

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
              // Store launch later
            },
            child: Text(t.upgrade),
          ),
        ],
      ),
    );

    await usage.markDialogShown();
  }

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
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  "${t.summary_incorrect}: ${widget.totalIncorrect}",
                  style: const TextStyle(fontSize: 20),
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

            if (_usage != null && widget.listenerEnabled)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  t.freeUsageStatus(
                    _usage!.played,
                    _usage!.limit,
                  ),
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, 'restart'),
                  child: Text(t.summary_play_again),
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