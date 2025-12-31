import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

class StoreLauncher {
  static const _iosUrl =
      'https://apps.apple.com/app/idXXXXXXXXX';
  static const _androidUrl =
      'https://play.google.com/store/apps/details?id=XXXX';

  static Future<void> openStore() async {
    final url = Platform.isIOS ? _iosUrl : _androidUrl;
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}