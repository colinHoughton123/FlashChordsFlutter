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
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 320),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Scrollbar(
                thumbVisibility: true,
                child: ListView(
                  shrinkWrap: true,
                  children: kSupportedLanguages.map((lang) {
                    return ListTile(
                      title: Text(lang.label),
                      onTap: () {
                        onSelected(lang.code);
                        Navigator.pop(context);
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              t.language_picker_scroll_hint,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.black54),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
