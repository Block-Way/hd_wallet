part of app_module;

class AppLanguage {
  const AppLanguage(this.name, this.locale);
  final String name;
  final Locale locale;

  String get languageCode => locale.languageCode;
}

class AppLanguages {
  static const languages = [
    AppLanguage('English', Locale('en')),
    AppLanguage('中文', Locale('zh')),
    AppLanguage('Pусский', Locale('ru')),
    AppLanguage('日本語', Locale('ja')),
    AppLanguage('한국어', Locale('ko')),
  ];

  static List<Locale> supportedLocales =
      languages.map((e) => e.locale).toList();

  static String getCurrencyByLanguage(String lang) =>
      lang == 'zh' ? 'CNY' : 'USD';
}
