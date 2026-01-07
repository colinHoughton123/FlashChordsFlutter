import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';
import 'package:flashchords/core/system_error.dart';

// 🔥 Firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

// 🔎 Optional: shared analytics instance (safe global)
final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ─────────────────────────────────────
  // 🔥 Firebase initialization (ADD THIS)
  // ─────────────────────────────────────
  try {
    await Firebase.initializeApp();
    debugPrint('🔥 Firebase initialized');
  } catch (e, stack) {
    debugPrint('🔥 Firebase init failed: $e');
    debugPrint('$stack');
  }

  // ─────────────────────────────────────
  // Load persisted language
  // ─────────────────────────────────────
  final prefs = await SharedPreferences.getInstance();
  final savedLanguage = prefs.getString('preferred_language');

  debugPrint('🌍 Saved language = $savedLanguage');

  // ─────────────────────────────────────
  // Global error handling
  // ─────────────────────────────────────
  FlutterError.onError = (details) {
    debugPrint('🔥 FlutterError: ${details.exceptionAsString()}');
    debugPrint('${details.stack}');
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    debugPrint('🔥 PlatformDispatcher: $error');
    debugPrint('$stack');
    return true;
  };

  // ─────────────────────────────────────
  // App startup
  // ─────────────────────────────────────
  runZonedGuarded(() {
    debugPrint('✅ main() reached');

    runApp(
      const ProviderScope(
        child: FlashChordsApp(),
      ),
    );
  }, (error, stack) {
    debugPrint('🔥 runZonedGuarded: $error');
    debugPrint('$stack');
  });

  // Optional heartbeat
  Timer.periodic(const Duration(seconds: 2), (_) {
    debugPrint('💓 heartbeat');
  });
}