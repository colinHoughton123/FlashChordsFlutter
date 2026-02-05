class LanguageOption {
  final String code;
  final String label;

  const LanguageOption(this.code, this.label);
}

const List<LanguageOption> kSupportedLanguages = [
  LanguageOption('en', 'English'),

  LanguageOption('bn', 'বাংলা / Bengali'),
  LanguageOption('de', 'Deutsch / German'),
  LanguageOption('es', 'Español / Spanish'),
  LanguageOption('fr', 'Français / French'),
  LanguageOption('hi', 'हिन्दी / Hindi'),

  LanguageOption('it', 'Italiano / Italian'),
  LanguageOption('ja', '日本語 / Japanese'),
  LanguageOption('ko', '한국어 / Korean'),

  LanguageOption('nl', 'Nederlands / Dutch'),
  LanguageOption('pl', 'Polski / Polish'),
  LanguageOption('pt', 'Português / Portuguese'),

  LanguageOption('ru', 'Русский / Russian'),
  LanguageOption('th', 'ไทย / Thai'),
  LanguageOption('tr', 'Türkçe / Turkish'),
  LanguageOption('uk', 'Українська / Ukrainian'),

  LanguageOption('zh', '中文（简体）/ Chinese (Simplified)'),
  LanguageOption('zh_Hant', '中文（繁體）/ Chinese (Traditional)'),
];