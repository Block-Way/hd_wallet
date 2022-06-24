part of app_module;

class AppLocalizations {
  static Future<Translations> getTranslationsByLocale(Locale locale) async {
    final translations = json.decode(
      await rootBundle.loadString(
        'assets/locales/${locale.toStringWithSeparator(separator: "-")}.json',
      ),
    ) as Map<String, dynamic>;
    return Translations(translations);
  }
}
