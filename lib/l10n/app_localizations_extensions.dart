import 'app_localizations.dart';

extension SystemErrorLocalization on AppLocalizations {
  String errorTitle(int code) {
    switch (code) {
      case 101:
        return flash_error_101;
      case 102:
        return flash_error_102;
      case 103:
        return flash_error_103;
      case 201:
        return flash_error_201;
      case 301:
        return flash_error_301;
      default:
        return flash_error_201;
    }
  }

  String errorHint(int code) {
    switch (code) {
      case 101:
        return flash_error_101_hint;
      case 102:
        return flash_error_102_hint;
      case 103:
        return flash_error_103_hint;
      case 201:
        return flash_error_201_hint;
      case 301:
        return flash_error_301_hint;
      default:
        return flash_error_201_hint;
    }
  }
}