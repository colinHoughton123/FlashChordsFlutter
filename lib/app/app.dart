import 'package:flutter/material.dart';
import 'package:flashchords/l10n/app_localizations.dart';
import 'package:flashchords/data/settings_repository.dart';
import 'package:flashchords/features/welcome/welcome_screen.dart';
import 'package:flashchords/features/config/config_screen.dart';
import 'package:flashchords/features/flashcard/flashcard_screen.dart'; // <-- add
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flashchords/core/system_error_listener.dart';
import 'package:flashchords/core/system_error_overlay.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart'; // ✅ ProviderScope



class FlashChordsApp extends StatefulWidget {
  const FlashChordsApp({super.key});

  /// Optional helper (still fine to keep)
  static FlashChordsAppState of(BuildContext context) {
    return context.findAncestorStateOfType<FlashChordsAppState>()!;
  }

  @override
  FlashChordsAppState createState() => FlashChordsAppState();
}

class FlashChordsAppState extends State<FlashChordsApp> {
  Locale? _locale;

  Future<void> updateLocale(String languageCode) async {
    setState(() {
      _locale = Locale(languageCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FlashChords',
        locale: _locale,

        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,

        builder: (context, child) {
          return Stack(
            children: [
              if (child != null) child,
              const SystemErrorOverlay(),
            ],
          );
        },

        // ✅ WelcomeScreen exists only here
        home: WelcomeScreen(
          onLanguageChanged: updateLocale,
        ),
      ),
    );
  }
}