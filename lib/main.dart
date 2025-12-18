import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load saved language BEFORE building the widget tree
  final prefs = await SharedPreferences.getInstance();
  final savedLanguageCode = prefs.getString('preferred_language');

  print("MAIN.DART — loaded saved language: $savedLanguageCode");

  runApp(
    ProviderScope(
      child: FlashChordsApp(
        initialLocaleCode: savedLanguageCode, // may be null → default to system
      ),
    ),
  );
}