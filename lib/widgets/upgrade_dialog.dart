import 'package:flutter/material.dart';
import 'package:flashchords/l10n/app_localizations.dart';
import 'package:flashchords/services/purchase_service.dart';

Future<void> showUpgradeRequiredDialog({
  required BuildContext context,
  required AppLocalizations t,
  required int limit,
}) async {
  await showDialog(
    context: context,
    builder: (dialogContext) {
      bool isBusy = false;
      return StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(t.listenerLimitReachedTitle),
          content: Text(t.listenerLimitReachedBody(limit)),
          actions: [
            TextButton(
              onPressed: isBusy ? null : () => Navigator.pop(context),
              child: Text(t.later),
            ),
            TextButton(
              onPressed: isBusy
                  ? null
                  : () async {
                      setState(() => isBusy = true);
                      final started =
                          await PurchaseService.instance.buyUpgrade();
                      if (!context.mounted) return;
                      setState(() => isBusy = false);

                      if (!started) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Upgrade is not available right now.',
                            ),
                          ),
                        );
                        return;
                      }

                      Navigator.pop(context);
                    },
              child: Text(t.upgrade),
            ),
          ],
        ),
      );
    },
  );
}
