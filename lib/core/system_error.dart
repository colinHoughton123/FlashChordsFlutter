
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Holds the active system error code (null = no error)
final systemErrorProvider =
    StateNotifierProvider<SystemErrorNotifier, int?>(
  (ref) => SystemErrorNotifier(),
);

class SystemErrorNotifier extends StateNotifier<int?> {
  SystemErrorNotifier() : super(null);

  void set(int code) => state = code;
  void clear() => state = null;
}

class SystemError {
  /// Report an error from UI or service-adapter layer
  static void report(int code, WidgetRef ref) {
    ref.read(systemErrorProvider.notifier).set(code);
  }

  static void clear(WidgetRef ref) {
    ref.read(systemErrorProvider.notifier).clear();
  }
}