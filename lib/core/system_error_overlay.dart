import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flashchords/core/system_error.dart';
import 'package:flashchords/l10n/app_localizations.dart';
import 'package:flashchords/l10n/app_localizations_extensions.dart';

class SystemErrorOverlay extends ConsumerWidget {
  const SystemErrorOverlay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final errorCode = ref.watch(systemErrorProvider);

    if (errorCode == null) {
      return const SizedBox.shrink();
    }

    final t = AppLocalizations.of(context)!;

    return Stack(
      children: [
        // dim background
        ModalBarrier(
          dismissible: false,
          color: Colors.black54,
        ),

        Center(
          child: AlertDialog(
            title: Text(t.errorTitle(errorCode)),
            content: Text(t.errorHint(errorCode)),
            actions: [
              TextButton(
                onPressed: () {
                  SystemError.clear(ref);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}