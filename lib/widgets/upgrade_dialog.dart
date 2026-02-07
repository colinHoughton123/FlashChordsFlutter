import 'package:flutter/material.dart';
import 'package:flashchords/l10n/app_localizations.dart';

Future<void> showUpgradeRequiredDialog({
  required BuildContext context,
  required AppLocalizations t,
  required int limit,
}) async {
  await showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(t.listenerLimitReachedTitle),
      content: Text(t.listenerLimitReachedBody(limit)),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(t.later),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            // Placeholder: upgrade flow to be wired later.
          },
          child: Text(t.upgrade),
        ),
      ],
    ),
  );
}
