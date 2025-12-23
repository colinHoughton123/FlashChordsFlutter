import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/app.dart';
import 'package:flashchords/core/system_error.dart';



void main() {
  runApp(
    const ProviderScope(
      child: FlashChordsApp(),
    ),
  );
}