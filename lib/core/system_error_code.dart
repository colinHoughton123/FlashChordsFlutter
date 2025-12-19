// lib/core/system_error_code.dart
class SystemErrorCode implements Exception {
  final int code;
  final String? technical;

  const SystemErrorCode(this.code, {this.technical});

  @override
  String toString() => 'SystemErrorCode($code)';
}