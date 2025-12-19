import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/app.dart';
import 'package:flashchords/core/system_error.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final savedLanguageCode = prefs.getString('preferred_language');

  runApp(
    ProviderScope(
      child: FlashChordsApp(
        initialLocaleCode: savedLanguageCode,
      ),
    ),
  );
}