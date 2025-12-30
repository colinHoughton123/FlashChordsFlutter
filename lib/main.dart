import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/app.dart';
import 'package:flashchords/core/system_error.dart';
import 'dart:async';
import 'dart:ui';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
      FlashChordsApp());
  }, (error, stack) {
    debugPrint('🔥 runZonedGuarded: $error');
    debugPrint('$stack');
  });

  // Optional heartbeat
  Timer.periodic(const Duration(seconds: 2), (_) {
    debugPrint('💓 heartbeat');
  });
}