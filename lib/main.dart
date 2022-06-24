// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:async_redux/async_redux.dart';
import 'package:flutter_flipperkit/flutter_flipperkit.dart';

// Project imports:
import 'app.dart';
import 'modules/app/app.dart';
import 'routers/navigator.dart';
import 'themes/themes.dart';
import 'utils/utils.dart';

// 设置生命周期更长的存储对象，放这里的原因是main函数会退出
late Store<AppState> store;

void main() {
  // 确保与本地代码通信正常
  ensureFlutterBindingsInitialized();

  // 设置系统样式
  ThemeDisplay.setPortraitMode();
  ThemeStatusBar.setStatusBarStyle();

  // 设置平台的解析错误函数，设置了全局函数进行集中管理
  Toast.onParseError = AppErrors.parseErrorMessages;

  // 设置flutter错误函数
  FlutterError.onError = (details) {
    FlutterError.dumpErrorToConsole(details);
  };

  // 创建存储数据
  store = createStore();

  // 设置路由数据
  NavigateAction.setNavigatorKey(navigatorKey);

  // Flipper Config
  if (kDebugMode) {
    final flipperClient = FlipperClient.getDefault();
    flipperClient.addPlugin(FlipperNetworkPlugin());
    flipperClient.addPlugin(FlipperReduxInspectorPlugin());
    flipperClient.addPlugin(FlipperSharedPreferencesPlugin());
    flipperClient.start();
  }

  // Run App
  SentryFlutter.init(
    CrashesReport.getSentryOptions,
    appRunner: () => runApp(MyApp(store)),
  );
}
