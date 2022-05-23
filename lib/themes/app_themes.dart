part of themes;

class AppThemes {
  static bool isDarkTheme(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  static ThemeData getLightTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: context.textFont.fontFamily,
      // Cursor color
      cupertinoOverrideTheme: CupertinoThemeData(
        primaryColor: Colors.black,
        barBackgroundColor: context.primaryColor,
        scaffoldBackgroundColor: context.primaryColor,
      ),
      cardColor: context.primaryColor,
      primaryColor: context.primaryColor,
      backgroundColor: context.bgScaffoldColor,
      scaffoldBackgroundColor: context.bgScaffoldColor,
      dialogBackgroundColor: context.bgScaffoldColor,
      bottomAppBarColor: context.bgPrimaryColor,
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: context.backdropColor,
      ),
      // canvasColor: Colors.transparent,
      appBarTheme: AppBarTheme(
        elevation: 0,
        color: context.bgPrimaryColor,
        iconTheme: IconThemeData(
          color: context.bodyColor,
        ),
        actionsIconTheme: IconThemeData(
          color: context.bodyColor,
        ),
      ),
    );
  }
}
