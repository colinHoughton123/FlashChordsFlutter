import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository {
  static const _keyLanguage = 'preferred_language';
  static const _keyRoots = 'selected_roots';
  static const _keyChordTypes = 'selected_chord_types';
  static const _keyInversions = 'selected_inversions';
  static const _keyTimerEnabled = 'timer_enabled';
  static const _keyTimerSeconds = 'timer_seconds';
  static const _keyListenMode = 'listen_mode_enabled';
  static const _keyIsUpgraded = 'is_upgraded';
  static const _keyListenerInversionNoticeDismissed =
      'listener_inversion_notice_dismissed';



  // ----------------- LANGUAGE -----------------

  Future<void> saveLanguage(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLanguage, code);
  }

  Future<String?> loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyLanguage);
  }

  // ----------------- ROOTS -----------------

  Future<void> saveRoots(List<String> roots) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_keyRoots, roots);
  }

  Future<List<String>> loadRoots() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_keyRoots) ?? [];
  }

  // ----------------- CHORD TYPES -----------------

  Future<void> saveChordTypes(List<String> types) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_keyChordTypes, types);
  }

  Future<List<String>> loadChordTypes() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_keyChordTypes) ?? [];
  }

  // ----------------- INVERSIONS -----------------

  Future<void> saveInversions(List<String> inv) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_keyInversions, inv);
  }

  Future<List<String>> loadInversions() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_keyInversions) ?? [];
  }

  // ----------------- TIMER -----------------

  Future<void> saveTimer(bool enabled, int seconds) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyTimerEnabled, enabled);
    await prefs.setInt(_keyTimerSeconds, seconds);
  }

  Future<(bool enabled, int seconds)> loadTimer() async {
    final prefs = await SharedPreferences.getInstance();
    final enabled = prefs.getBool(_keyTimerEnabled) ?? false;
    final seconds = prefs.getInt(_keyTimerSeconds) ?? 5;
    return (enabled, seconds);
  }


  // ---

    // ------------------------------------------------------------
  // CARD ORDER: Random vs Sorted (true = random, false = sorted)
  // ------------------------------------------------------------

  Future<bool> loadCardOrderRandom() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('cardOrderRandom') ?? true; // default = random
  }

  Future<void> saveCardOrderRandom(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('cardOrderRandom', value);
  }
  
  // ----------------- SORT ORDER ----------------------------------
  static const _keyCardOrder = 'card_order'; // "random" or "sorted"

Future<void> saveCardOrder(String mode) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(_keyCardOrder, mode);
}

Future<String> loadCardOrder() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(_keyCardOrder) ?? 'random';
}
  // ----------------- LISTEN MODE (FUTURE FEATURE) -----------------

  Future<void> saveListenMode(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyListenMode, enabled);
  }

  Future<bool> loadListenMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyListenMode) ?? false;
  }

  // ----------------- UPGRADE STATUS -----------------

  Future<void> saveIsUpgraded(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsUpgraded, value);
  }

  Future<bool> loadIsUpgraded() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsUpgraded) ?? false;
  }

  // ----------------- LISTENER INVERSION NOTICE -----------------

  Future<void> saveListenerInversionNoticeDismissed(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyListenerInversionNoticeDismissed, value);
  }

  Future<bool> loadListenerInversionNoticeDismissed() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyListenerInversionNoticeDismissed) ?? false;
  }
}
