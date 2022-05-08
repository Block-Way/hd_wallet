part of themes;

class ThemeStatusBar {
  static void updateUiOverlayStyle(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    SystemChrome.setSystemUIOverlayStyle(
      isDark
          ? SystemUiOverlayStyle.light.copyWith(
              statusBarColor: Colors.transparent,
            )
          : SystemUiOverlayStyle.dark.copyWith(
              statusBarColor: Colors.transparent,
            ),
    );
  }

  static void setStatusBarStyle() {
    ThemeStatusBar.updateUiOverlayStyle(Brightness.light);
  }
}

class ThemeDisplay {
  static void setPortraitMode() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    if (Platform.isAndroid) {
      // 显示顶部状态栏，底部三大金刚
      SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom],
      );
    }
  }

  static void setLandscapeMode() {
    SystemChrome.setPreferredOrientations([
      if (Platform.isAndroid)
        DeviceOrientation.landscapeLeft
      else
        DeviceOrientation.landscapeRight,
    ]);
    if (Platform.isAndroid) {
      // 隐藏顶部状态栏，底部三大金刚
      SystemChrome.setEnabledSystemUIOverlays([]);
    }
  }
}
