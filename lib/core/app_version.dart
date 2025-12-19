/// Single source of truth for app identity.
/// Update ONLY when creating a formal build.
class AppVersion {
  // Semantic versioning
  static const String version = '0.1.1';

  // Increment when you decide a new build exists
  static const int build = 1;

  /// Human-readable
  static String get display => 'v$version (build $build)';

  /// Machine-readable (logs, diagnostics)
  static String get diagnostic => 'FlashChords/$version+$build';
}