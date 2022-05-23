part of themes;

enum ThemeAppIconEnum { light, dark }

class ThemeAppIcon {
  static const _channel = MethodChannel('fappchannel');

  static Future<void> setThemeAppIcon(ThemeAppIconEnum iconToChange) async {
    var iconStr = 'natrium';
    switch (iconToChange) {
      case ThemeAppIconEnum.light:
        iconStr = 'thorium';
        break;
      case ThemeAppIconEnum.dark:
        iconStr = 'neptunium';
        break;
      default:
        iconStr = 'natrium';
        break;
    }
    final params = <String, dynamic>{
      'icon': iconStr,
    };
    return _channel.invokeMethod('changeIcon', params);
  }
}
