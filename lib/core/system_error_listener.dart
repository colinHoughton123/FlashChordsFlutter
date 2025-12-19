import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../l10n/app_localizations.dart';
import 'system_error.dart';

class SystemErrorListener extends ConsumerWidget {
  const SystemErrorListener({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<int?>(systemErrorProvider, (previous, next) {
      if (next == null) return;

      final l10n = AppLocalizations.of(context)!;
      final errorKey = 'flash_error_$next';
      final hintKey = 'flash_error_${next}_hint';

      // Resolve localized strings dynamically
      final errorText = _lookup(l10n, errorKey);
      final hintText = _lookup(l10n, hintKey);

      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          title: Text('Error $next'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(errorText),
              const SizedBox(height: 12),
              Text(
                hintText,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ref.read(systemErrorProvider.notifier).clear();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    });

    return child;
  }

  /// Dynamically resolve localization keys without hard-coding getters
  String _lookup(AppLocalizations l10n, String key) {
    final map = l10n as dynamic;
    try {
      return map[key] as String;
    } catch (_) {
      return key; // fallback if missing
    }
  }
}