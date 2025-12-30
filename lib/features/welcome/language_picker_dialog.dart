import 'package:flutter/material.dart';
import 'package:flashchords/l10n/app_localizations.dart';
import 'package:flashchords/l10n/language_options.dart';

class LanguagePickerDialog extends StatelessWidget {
  final void Function(String code) onSelected;

  const LanguagePickerDialog({
    super.key,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(t.language_picker_title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: kSupportedLanguages.map((lang) {
          return ListTile(
            title: Text(lang.label), // English / Español / Français
            onTap: () {
              onSelected(lang.code);
              Navigator.pop(context);
            },
          );
        }).toList(),
      ),
    );
  }
}