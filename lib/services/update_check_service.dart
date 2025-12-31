import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flashchords/core/app_version.dart';
import 'package:flutter/widgets.dart';

class UpdateCheckResult {
  final bool mustUpdate;
  final bool hasUpdate;
  final String title;
  final String body;

  UpdateCheckResult({
    required this.mustUpdate,
    required this.hasUpdate,
    required this.title,
    required this.body,
  });
}

class UpdateCheckService {
  static const String _versionUrl =
      'https://colinhoughton123.github.io/FlashChordsFlutter/meta/version.json';

  static Future<UpdateCheckResult?> check() async {
    try {
      final response = await http.get(Uri.parse(_versionUrl));
      if (response.statusCode != 200) return null;

      final json = jsonDecode(response.body) as Map<String, dynamic>;

      // ─────────────────────────────────────
      // Versions
      // ─────────────────────────────────────
      final latest = json['latest'] as Map<String, dynamic>;
      final minSupported = json['minimum_supported'] as Map<String, dynamic>;

      final latestVersion = latest['version'] as String;
      final latestBuild = latest['build'] as int;

      final minVersion = minSupported['version'] as String;
      final minBuild = minSupported['build'] as int;

      final hasUpdate =
          _compare(AppVersion.version, latestVersion) < 0 ||
          AppVersion.build < latestBuild;

      final mustUpdate =
          _compare(AppVersion.version, minVersion) < 0 ||
          AppVersion.build < minBuild;

      if (!hasUpdate && !mustUpdate) return null;

      // ─────────────────────────────────────
      // Localization
      // ─────────────────────────────────────
      final locale = WidgetsBinding.instance.platformDispatcher.locale;
      final lang = locale.languageCode;

      final messages = json['messages'] as Map<String, dynamic>;
      final selected =
          messages[lang] ?? messages['en'] as Map<String, dynamic>;

      final title = selected['title'] as String;
      final body = selected['body'] as String;

      return UpdateCheckResult(
        mustUpdate: mustUpdate,
        hasUpdate: hasUpdate,
        title: title,
        body: body,
      );
    } catch (_) {
      // Fail silently: app must still launch offline or blocked
      return null;
    }
  }

  /// Semantic version comparison
  /// returns:
  /// <0 → a < b
  ///  0 → equal
  /// >0 → a > b
  static int _compare(String a, String b) {
    final pa = a.split('.').map(int.parse).toList();
    final pb = b.split('.').map(int.parse).toList();

    for (int i = 0; i < 3; i++) {
      final diff = pa[i].compareTo(pb[i]);
      if (diff != 0) return diff;
    }
    return 0;
  }
}