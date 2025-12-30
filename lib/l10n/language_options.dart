class LanguageOption {
  final String code;
  final String label;

  const LanguageOption(this.code, this.label);
}

const List<LanguageOption> kSupportedLanguages = [
  LanguageOption('en', 'English'),
  LanguageOption('es', 'Español'),
  LanguageOption('fr', 'French'),
];