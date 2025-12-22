import 'package:flutter/material.dart';
import 'package:flashchords/l10n/app_localizations.dart';

class FlashcardSummaryScreen extends StatelessWidget {
  final int totalCorrect;
  final int totalIncorrect;
  final int totalCards;

  // ✅ New, explicit metrics
  final double averageSecondsCorrect;
  final double averageSecondsAll;

  final bool showAverage;
  final bool hadErrors;
  final bool isErrorDeck;

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
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    final accuracy =
        totalCards == 0 ? 0.0 : (totalCorrect / totalCards * 100.0);

    final deckLabel = isErrorDeck
        ? t.summary_from_error_deck
        : t.summary_from_main_deck;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text(t.summary_title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              deckLabel,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Totals row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "${t.summary_correct}: $totalCorrect",
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  "${t.summary_incorrect}: $totalIncorrect",
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),

            const SizedBox(height: 18),

            Text(
              "${t.summary_cards}: $totalCards",
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 18),

            Text(
              "${t.summary_accuracy}: ${accuracy.toStringAsFixed(1)}%",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 18),

            // ✅ NEW: two averages, clearly labeled
            if (showAverage) ...[
              Text(
                "${t.summary_average_time_correct}: "
                "${averageSecondsCorrect.toStringAsFixed(2)} "
                "${t.summary_seconds}",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                "${t.summary_average_time_all}: "
                "${averageSecondsAll.toStringAsFixed(2)} "
                "${t.summary_seconds}",
                style: const TextStyle(fontSize: 18),
              ),
            ],

            const Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, 'restart');
                  },
                  child: Text(t.summary_play_again),
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context, 'done');
                  },
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