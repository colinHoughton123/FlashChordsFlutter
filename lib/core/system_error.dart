import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Holds the currently active system error code (if any).
/// null = no error
final systemErrorProvider =
    StateNotifierProvider<SystemErrorNotifier, int?>(
  (ref) => SystemErrorNotifier(),
);

class SystemErrorNotifier extends StateNotifier<int?> {
  SystemErrorNotifier() : super(null);

  /// Report a system-level error.
  /// This will trigger the global error UI.
  void report(int errorCode) {
    state = errorCode;
  }

  /// Clear the current system error
  /// (called after user acknowledgment).
  void clear() {
    state = null;
  }
}

/// Convenience façade so services don’t need to import Riverpod types.
class SystemError {
  static late Ref _ref;

  /// Called once during app startup
  static void init(Ref ref) {
    _ref = ref;
  }

  /// Report a system error by code
  static void report(int errorCode) {
    _ref.read(systemErrorProvider.notifier).report(errorCode);
  }

  /// Clear the active error
  static void clear() {
    _ref.read(systemErrorProvider.notifier).clear();
  }
}