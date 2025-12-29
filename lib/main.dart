import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/app.dart';
import 'package:flashchords/core/system_error.dart';
import 'dart:async';
import 'dart:ui';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (details) {
    debugPrint('🔥 FlutterError: ${details.exceptionAsString()}');
    debugPrint('${details.stack}');
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    debugPrint('🔥 PlatformDispatcher: $error');
    debugPrint('$stack');
    return true;
  };

  runZonedGuarded(() {
    debugPrint('✅ main() reached');
    runApp(const FlashChordsApp());
  }, (error, stack) {
    debugPrint('🔥 runZonedGuarded: $error');
    debugPrint('$stack');
  });

  // Optional heartbeat so you can *see* it’s alive in logs
  Timer.periodic(const Duration(seconds: 2), (_) {
    debugPrint('💓 heartbeat');
  });
}