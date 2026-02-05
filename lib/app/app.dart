import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flashchords/features/welcome/welcome_screen.dart';
import 'package:flashchords/l10n/app_localizations.dart';
import 'package:flashchords/core/system_error.dart';
import 'package:flashchords/services/chord_detection_services.dart';
import 'package:flashchords/core/system_error.dart';

class FlashChordsApp extends StatefulWidget {
  const FlashChordsApp({super.key});

  static FlashChordsAppState of(BuildContext context) {
    return context.findAncestorStateOfType<FlashChordsAppState>()!;
  }

  @override
  FlashChordsAppState createState() => FlashChordsAppState();
}

class FlashChordsAppState extends State<FlashChordsApp>
    with WidgetsBindingObserver {
  Locale? _locale;

  Locale _localeFromCode(String code) {
    final normalized = code.replaceAll('-', '_');
    final parts = normalized.split('_');
    if (parts.length == 1) {
      return Locale(parts[0]);
    }

    final languageCode = parts[0];
    final subtag = parts[1];

    // Handle script codes like zh_Hant / zh_Hans
    if (subtag.length == 4) {
      return Locale.fromSubtags(languageCode: languageCode, scriptCode: subtag);
    }

    // Fallback to countryCode
    return Locale.fromSubtags(languageCode: languageCode, countryCode: subtag);
  }

  // ─────────────────────────────────────────────
  // 🔑 Load saved language at startup
  // ─────────────────────────────────────────────
  Future<void> _loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString('preferred_language');

    if (code != null && mounted) {
      debugPrint('🌍 Restoring saved locale: $code');
      setState(() {
        _locale = _localeFromCode(code);
      });
    }
  }

  // ─────────────────────────────────────────────
  // 🔑 Save + update language
  // ─────────────────────────────────────────────
  Future<void> updateLocale(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('preferred_language', languageCode);

    debugPrint('🌍 Language saved: $languageCode');

    if (!mounted) return;

    setState(() {
      _locale = _localeFromCode(languageCode);
    });
  }

  // ─────────────────────────────────────────────
  // Lifecycle
  // ─────────────────────────────────────────────
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadSavedLocale(); // ✅ restore language here
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    unawaited(ChordDetectionService.instance.reset());
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      // unawaited(ChordDetectionService.instance.reset());

      debugPrint('📱 App lifecycle → stopping audio');
      ChordDetectionService.instance.hardStop(clearState: true);

    }
  }

  // ─────────────────────────────────────────────
  // Build
  // ─────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        restorationScopeId: null,
        debugShowCheckedModeBanner: false,
        title: 'FlashChords',

        // 🌍 Locale control
        locale: _locale,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],

        builder: (context, child) {
          final mediaQuery = MediaQuery.of(context);
          final clampedScaler = mediaQuery.textScaler.clamp(
            minScaleFactor: 0.9,
            maxScaleFactor: 1.2,
          );

          return MediaQuery(
            data: mediaQuery.copyWith(textScaler: clampedScaler),
            child: child!,
          );
        },

        home: WelcomeScreen(
          onLanguageChanged: updateLocale,
        ),
      ),
    );
  }
}
