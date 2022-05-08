// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:async_redux/async_redux.dart';

// Project imports:
import 'app.dart';
import 'modules/app/app.dart';
import 'routers/navigator.dart';
import 'themes/themes.dart';
import 'utils/utils.dart';

Store<AppState> store;

void main() {
  ensureFlutterBindingsInitialized();
  ThemeDisplay.setPortraitMode();
  ThemeStatusBar.setStatusBarStyle();

  Toast.onParseError = AppErrors.parseErrorMessages;

  FlutterError.onError = (details) {
    Zone.current.handleUncaughtError(details.exception, details.stack);
  };

  store = createStore();

  NavigateAction.setNavigatorKey(navigatorKey);

  // Run App
  SentryFlutter.init(
    CrashesReport.getSentryOptions,
    appRunner: () => runApp(MyApp(store)),
  );
}
