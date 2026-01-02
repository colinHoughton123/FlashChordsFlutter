import 'package:shared_preferences/shared_preferences.dart';

class FreeListenerUsage {
  // ─────────────────────────────────────
  // 🔧 TUNABLE CONSTANTS (owner-controlled)
  // ─────────────────────────────────────
  static const int freeLimit = 1000;
  static const String upgradePrice = '\$3.99';

  // ─────────────────────────────────────
  // 🔐 Storage keys
  // ─────────────────────────────────────
  static const _playedKey = 'listener_free_played';
  static const _dialogShownKey = 'listener_limit_dialog_shown';

  int _played = 0;
  bool _dialogShown = false;

  int get played => _played;
  int get limit => freeLimit;
  bool get isLimitReached => _played >= freeLimit;
  bool get dialogShown => _dialogShown;

  /// Load persisted values
  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _played = prefs.getInt(_playedKey) ?? 0;
    _dialogShown = prefs.getBool(_dialogShownKey) ?? false;
  }

  /// Increment by N cards (called from Summary)
  Future<void> increment(int count) async {
    if (count <= 0) return;

    final prefs = await SharedPreferences.getInstance();
    _played += count;
    await prefs.setInt(_playedKey, _played);
  }

  /// Mark that the “limit reached” dialog was shown
  Future<void> markDialogShown() async {
    final prefs = await SharedPreferences.getInstance();
    _dialogShown = true;
    await prefs.setBool(_dialogShownKey, true);
  }

  /// Reset helper (debug / future admin tools)
  Future<void> reset() async {
    final prefs = await SharedPreferences.getInstance();
    _played = 0;
    _dialogShown = false;
    await prefs.remove(_playedKey);
    await prefs.remove(_dialogShownKey);
  }
}