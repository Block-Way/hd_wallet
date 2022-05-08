part of common_domain_module;

abstract class _BaseAction extends ReduxAction<AppState> {
  //
}

class CommonActionCheckDefaultLanguage extends _BaseAction {
  CommonActionCheckDefaultLanguage(this.completer);

  final Completer<AppLanguage> completer;

  @override
  Future<AppState> reduce() async {
    final settings = CommonRepository().getSettings();
    final deviceLanguageCode = Platform.localeName.split('_').first;

    if (settings?.languageIsSet == true ||
        settings?.language == deviceLanguageCode) {
      completer.complete(null);
    } else {
      final suggestedLang = AppLanguages.languages.firstWhere(
        (lang) => lang.locale.languageCode == deviceLanguageCode,
        orElse: () => null,
      );

      completer.complete(suggestedLang);
    }
    return null;
  }

  @override
  Object wrapError(dynamic error) {
    completer.completeError(error);
    return error;
  }
}

class CommonActionChangeLanguage extends _BaseAction {
  CommonActionChangeLanguage(this.language);

  final String language;

  @override
  AppState reduce() {
    final settings = CommonRepository().getSettings();
    settings.language = language;
    settings.languageIsSet = true;
    settings.save();
    return state.rebuild(
      (b) => b.commonState.language = language,
    );
  }

  @override
  void after() {
    Request().updateLanguage(store.state.commonState.languageForApi);

    dispatch(AppActionAfterChangeLanguage(language));
  }
}

class CommonActionChangeFiatCurrency extends _BaseAction {
  CommonActionChangeFiatCurrency(this.fiatCurrency);

  final String fiatCurrency;

  @override
  AppState reduce() {
    final settings = CommonRepository().getSettings();
    settings.fiatCurrency = fiatCurrency;
    settings.save();
    return state.rebuild(
      (b) => b.commonState.fiatCurrency = fiatCurrency,
    );
  }

  @override
  void after() {
    dispatch(AppActionAfterChangeFiatCurrency(fiatCurrency));
  }
}

class CommonActionCheckVersion extends _BaseAction {
  CommonActionCheckVersion(
    this.completer, {
    this.checkBeta,
  });

  final Completer<ConfigUpdateData> completer;
  final bool checkBeta;

  @override
  Future<AppState> reduce() async {
    if (AppConstants.isBeta && checkBeta == true) {
      final data = await CommonRepository().getLastVersionBeta();
      completer.complete(data);
      if (data != null) {
        return state.rebuild(
          (b) => b.commonState.newVersion.replace(ConfigUpdate(
            (a) => a
              ..needUpdate = true
              ..data = data?.toBuilder(),
          )),
        );
      }
      return null;
    }

    final newVersion = await CommonRepository().getLastVersionProd();

    // newVersion = newVersion.rebuild((a) => a
    //   ..needUpdate = true
    //   ..data = ConfigUpdateData(
    //     (c) => c.downloadUrl = 'test_code_url',
    //   ).toBuilder());

    if (newVersion.hasNewVersion == true) {
      completer.complete(newVersion.data);
    } else {
      completer.complete(null);
    }

    return state.rebuild(
      (b) => b.commonState.newVersion.replace(newVersion),
    );
  }

  @override
  Object wrapError(dynamic error) {
    completer.completeError(error);
    return error;
  }
}
