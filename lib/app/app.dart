import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flashchords/l10n/app_localizations.dart';
import 'package:flashchords/features/welcome/welcome_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flashchords/core/system_error_overlay.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// ✅ Import your audio service so we can stop/reset on lifecycle changes
import 'package:flashchords/services/chord_detection_services.dart'; // <-- adjust path if different


    


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

  Future<void> updateLocale(String languageCode) async {
    setState(() {
      _locale = Locale(languageCode);
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // Best-effort cleanup
    unawaited(ChordDetectionService.instance.reset());
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // When the app is backgrounded/terminated, stop audio cleanly
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      unawaited(ChordDetectionService.instance.reset());
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
  child: MaterialApp(
    restorationScopeId: null, // ✅ ADD THIS LINE
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
    home: WelcomeScreen(
      onLanguageChanged: updateLocale,
    ),
  ),
);
  }
}