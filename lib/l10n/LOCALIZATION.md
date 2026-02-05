# FlashChords Localization Guide

This document explains how to add a new language to FlashChords and keep
the Dart localization files in sync.

## Quick Summary
1. Add a new ARB file in `lib/l10n/` (copy `app_en.arb`).
2. Update the language picker list in `lib/l10n/language_options.dart`.
3. Regenerate localization Dart files with `flutter gen-l10n`.
4. Verify the app shows the new language and that all strings are translated.

---

## 1) Create a New ARB File

Location: `lib/l10n/`

Steps:
1. Copy `lib/l10n/app_en.arb` to a new file:
   - Example: `lib/l10n/app_fr.arb`
2. Set the locale metadata at the top of the new file:
   - `"@@locale": "fr"`
3. Translate all values. Keep the keys unchanged.

Notes:
- ARB files are the source of truth for translations.
- Use the same placeholders as English (e.g., `{limit}`, `{price}`).

---

## 2) Update the Language Picker List

File: `lib/l10n/language_options.dart`

Add your new language to `kSupportedLanguages`:
```dart
const List<LanguageOption> kSupportedLanguages = [
  LanguageOption('en', 'English'),
  LanguageOption('es', 'Español'),
  LanguageOption('fr', 'French'),
];
```

Important:
- The language picker uses this list for the UI.
- Make sure every language here has a matching ARB file.

---

## 3) Regenerate Localization Dart Files

The project uses Flutter's gen-l10n (enabled in `pubspec.yaml`).
Run:
```bash
flutter gen-l10n
```

This regenerates:
- `lib/l10n/app_localizations.dart`
- `lib/l10n/app_localizations_<lang>.dart`

If you prefer, `flutter pub get` will also generate when `flutter: generate: true`
is enabled, but `flutter gen-l10n` is the most explicit.

---

## 4) Verify Supported Locales in the App

`MaterialApp` uses:
```dart
supportedLocales: AppLocalizations.supportedLocales,
```

This list is auto-generated from your ARB files.
If your ARB file is missing or malformed, your locale will not appear.

---

## 5) iOS / Android Locale Declarations (Optional but Recommended)

iOS:
- In `ios/Runner/Info.plist`, ensure the locale is listed under
  `CFBundleLocalizations` if you are explicitly managing that list.

Android:
- Android generally uses the app resources automatically, but if you have
  custom locale handling, verify it includes the new language.

---

## 6) Common Pitfalls

- **Missing ARB keys:** causes build errors or missing strings.
- **Language picker shows a locale with no ARB:** the app will not localize.
- **Forgetting to regenerate:** new language won’t show up in the UI.
- **Placeholder mismatch:** keep placeholders consistent across languages.

---

## 7) Update Remote Version Messages

FlashChords also shows update messages from a remote `version.json`.
When you add a new language, update the `messages` section so the update
prompt is localized too.

Location:
```
https://github.com/colinHoughton123/FlashChordsFlutter/blob/main/meta/version.json
```

Example structure:
```json
{
  "messages": {
    "en": { "title": "Update available", "body": "..." },
    "es": { "title": "Actualización disponible", "body": "..." },
    "fr": { "title": "Mise à jour disponible", "body": "..." }
  }
}
```

Add a new language entry with translated `title` and `body`.

---

## Checklist for Adding a Language

- [ ] Add `lib/l10n/app_<code>.arb`
- [ ] Include `"@@locale": "<code>"`
- [ ] Translate every string
- [ ] Update `lib/l10n/language_options.dart`
- [ ] Run `flutter gen-l10n`
- [ ] Update `meta/version.json` messages
- [ ] Verify in the app
