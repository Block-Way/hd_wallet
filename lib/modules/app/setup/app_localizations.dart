part of app_module;

class AppLocalizationsLoader extends AssetLoader {
  AppLocalizationsLoader({
    this.isFromNetwork = false,
  });

  final bool isFromNetwork;

  Future<String> getLocaleLocalPath(Locale locale) async {
    final localDir = await getApplicationDocumentsDirectory();
    return '${localDir.path}/locales/${localeToString(locale, separator: "-")}_v1.json';
  }

  Future<String> getLocalePath(String basePath, Locale locale) async {
    // final localCopy = File(await getLocaleLocalPath(locale));
    // if (await localCopy.exists()) {
    //   return localCopy.path;
    // }
    return '$basePath/${localeToString(locale, separator: "-")}.json';
  }

  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) async {
    dev.log('Load $isFromNetwork asset from $path', name: 'AppLocalizations');

    if (isFromNetwork) {
      try {
        // Load from network
        final data = await Request().getExternalObject<Map<String, dynamic>>(
          '/posts/${1 ?? locale.languageCode}',
          baseUrl: 'https://jsonplaceholder.typicode.com',
        );
        final file = File(await getLocaleLocalPath(locale));
        await file.create(recursive: true);
        await file.writeAsString(json.encode(data), flush: true);
        return data;
      } catch (error) {
        dev.log('Error update from network $error', name: 'AppLocalizations');
      }
    }

    final localePath = await getLocalePath(path, locale);
    return json.decode(await rootBundle.loadString(localePath))
        as Map<String, dynamic>;
  }
}

class AppLocalizations {
  static Future<Translations> getTranslationsByLocale(Locale locale) async {
    final translations = json.decode(await rootBundle.loadString(
            'assets/locales/${localeToString(locale, separator: "-")}.json'))
        as Map<String, dynamic>;

    return Translations(translations);
  }

  static void updateFromNetwork(BuildContext context) {
    final localization = EasyLocalization.of(context);
    localization.bloc.onChange(
      Resource(
        path: localization.parent.path,
        locale: context.locale,
        assetLoader: AppLocalizationsLoader(isFromNetwork: true),
        useOnlyLangCode: true,
      ),
    );
  }

  static const List<LocalizationsDelegate> localizationsDelegates = [
    // Built-in localization of basic text for Material widgets
    GlobalMaterialLocalizations.delegate,
    // Built-in localization of basic text for Cupertino widgets
    GlobalCupertinoLocalizations.delegate,
    // Built-in localization for text direction LTR/RTL
    GlobalWidgetsLocalizations.delegate,
  ];
}
