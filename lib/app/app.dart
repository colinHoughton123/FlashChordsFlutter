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

class FlashChordsApp extends StatefulWidget {
  final String? initialLocaleCode;

  const FlashChordsApp({
    super.key,
    required this.initialLocaleCode,
  });

  @override
  State<FlashChordsApp> createState() => _FlashChordsAppState();
}

class _FlashChordsAppState extends State<FlashChordsApp> {
  Locale? _locale;

  @override
  void initState() {
    super.initState();

    // Initialize starting locale once
    if (widget.initialLocaleCode != null) {
      _locale = Locale(widget.initialLocaleCode!);
    }
  }

  Future<void> updateLocale(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('preferred_language', code);

    setState(() {
      _locale = Locale(code);
    });
  }

  @override
Widget build(BuildContext context) {
return MaterialApp(
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
        const SystemErrorOverlay(), // ✅ GLOBAL ERROR LAYER
      ],
    );
  },

  home: Builder(
    builder: (context) {
      return WelcomeScreen(
      onStart: (items) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FlashcardScreen(items: items),
          ),
        );
      },
        onLanguageChanged: updateLocale,
      );
    },
  ),
);
}
}
