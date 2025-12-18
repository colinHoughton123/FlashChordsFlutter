import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../app/localization/locale_provider.dart';

class LanguagePickerDialog extends ConsumerWidget {
  const LanguagePickerDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(localeProvider.notifier);

    return AlertDialog(
      title: const Text("Select Language / Seleccionar idioma"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildOption(context, controller, 'en', 'English'),
          _buildOption(context, controller, 'es', 'Español'),
 
        ],
      ),
    );
  }

  Widget _buildOption(
      BuildContext context, LocaleController controller, String code, String label) {
    return ListTile(
      title: Text(label),
      onTap: () {
        controller.setLocale(Locale(code));
        Navigator.pop(context);
      },
    );
  }
}
