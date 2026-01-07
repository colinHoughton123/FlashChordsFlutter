import 'dart:io';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

FirebaseAnalytics? analytics = _initAnalytics();

FirebaseAnalytics? _initAnalytics() {
  if (kIsWeb) return null;
  if (Platform.isMacOS) return null; // 👈 IMPORTANT
  return FirebaseAnalytics.instance;
}