// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:async_redux/async_redux.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:oktoast/oktoast.dart';

// Project imports:
import 'modules/app/app.dart';
import 'routers/navigator.dart';
import 'themes/themes.dart';

void ensureFlutterBindingsInitialized() =>
    WidgetsFlutterBinding.ensureInitialized();

Store<AppState> createStore() {
  return Store<AppState>(
    persistor: appPersistor,
    initialState: AppState.initialState(),
    modelObserver: DefaultModelObserver(),
    actionObservers: [Log.printer(formatter: Log.verySimpleFormatter)],
  );
}

class MyApp extends StatelessWidget {
  const MyApp(this.store);

  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return OKToast(
      textPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      backgroundColor: Colors.black54,
      dismissOtherOnShow: true,
      child: StoreProvider<AppState>(
        store: store,
        child: EasyLocalization(
          path: 'assets/locales',
          assetLoader: AppLocalizationsLoader(),
          useOnlyLangCode: true,
          startLocale: Locale(AppConstants.defaultLanguage),
          fallbackLocale: Locale(AppConstants.defaultLanguage),
          preloaderColor: Colors.black,
          supportedLocales: AppLanguages.supportedLocales,
          child: Builder(
            builder: (context) => GestureDetector(
              onTap: () {
                // Hide keyboard when click outside
                if (FocusManager.instance.primaryFocus?.hasPrimaryFocus ==
                    true) {
                  FocusManager.instance.primaryFocus?.unfocus();
                }
              },
              child: MaterialApp(
                key: Key(context.locale.languageCode),
                theme: AppThemes.getLightTheme(context),
                locale: context.locale,
                supportedLocales: context.supportedLocales,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                navigatorKey: navigatorKey,
                onGenerateRoute: AppNavigator.onGenerateRoute,
                builder: (context, child) => MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    textScaleFactor: 1.0,
                  ),
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
