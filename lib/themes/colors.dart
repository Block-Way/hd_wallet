part of themes;

extension ColorStyles on BuildContext {
  Color dynamicColor({Color light, Color dark}) {
    return Theme.of(this).brightness == Brightness.light ? light : dark;
  }

  ///*** Colors ***///

  /// #333333
  Color get titleColor {
    return const Color(0xFF333333);
  }

  /// #333333
  Color get bodyColor {
    return const Color(0xFF333333);
  }

  /// #666666
  Color get labelColor {
    return const Color(0xFF666666);
  }

  /// #999999
  Color get placeholderColor {
    // return const Color(0xFF999999);
    return const Color(0xFFE2ECF7);
  }

  /// #FFDF0C
  Color get primaryColor {
    // return const Color(0xFFF1B434);
    return const Color(0xFF32383E);
  }

  ///#1F2229
  Color get mainColor{
    return const Color(0xFF1F2229);
  }

  Color get helpColor{
    return const Color(0xFF303644);
  }

  ///#2B2E37
  Color get cardColor{
    return const Color(0xFF2B2E37);
  }

  //#949699
  Color get iconColor {
    return const Color(0xFF949699);
  }

  Color get copyColor {
    return const Color(0xFFDEAE6A);
  }

  ///#EAEAEB
  Color get cardTitleColor {
    return const Color(0xFFEAEAEB);
  }

  ///#2e3343
  Color get searchBgColor {
    return const Color(0xFF2E3343);
  }

  ///#202328
  Color get searchTextColor {
    return const Color(0xFF202328);
  }

  ///#7F8187#
  Color get cardSecondColor {
    return const Color(0xFF7F8187);
  }

  ///#95969B
  Color get cardSecondWordColor {
    return const Color(0xFF95969B);
  }

  ///#d9d7d8
  Color get tabBarColor {
    return const Color(0xFFD9D7D8);
  }

  ///#DEAE6A
  Color get refreshBtnColor {
    return const Color(0xFFDEAE6A);
  }

  ///#ECC586
  Color get confirmTopColor {
    return const Color(0xFFECC586 );
  }

  ///#DCAA65
  Color get confirmBottomColor {
    return const Color(0xFFDCAA65);
  }

  ///#673704
  Color get confirmWordColor {
    return const Color(0xFF673704);
  }

  ///#FF4141
  Color get warninColor {
    return const Color(0xFFFF4141);
  }

  ///#8A8A8A
  Color get drawMoreColor {
    return const Color(0xFF8A8A8A);
  }

  ///#1F2229
  Color get languageBgColor {
    return const Color(0xFF1F2229);
  }

  /// #999999
  Color get secondaryColor {
    return const Color(0xFF999999);
  }

  /// #40CD6A
  Color get greenColor {
    return const Color(0xFF2CBC85);
  }

  /// #FF3B0B
  Color get redColor {
    return const Color(0xFFFF5C5B);
  }

  /// #FF9300
  Color get orangeColor {
    return const Color(0xFFFF9300);
  }

  /// #EDEBE8
  Color get borderColor {
    return const Color(0xFFEDEBE8);
  }

  /// #F0F0F0
  Color get greyColor {
    return const Color(0xFFF0F0F0);
  }

  /// #F5F5F5
  Color get greyDarkColor {
    return const Color(0xFF32383E);
  }

  /// #FFFFFF
  Color get whiteColor {
    return Colors.white;
  }

  /// #000000
  Color get blackColor {
    return Colors.black;
  }

  /// CCD3E6
  Color get whiteLightColor {
    return const Color(0xFFCCD3E6);
  }

  ///*** Buttons ***///

  /// #FFDF0C
  Color get btnPrimaryBgColor {
    // return const Color(0xFFFFDF0C);ru
    return const Color(0xFF17191C);
  }

  /// #333333
  Color get btnPrimaryTextColor {
    return const Color(0xFF333333);
  }

  /// #FFDF0C withOpacity
  Color get btnDisabledBgColor {
    return const Color(0xFF17191C).withOpacity(0.5);
  }

  /// #1F2229
  Color get btnDisabledTextColor {
    // return const Color(0xFF333333).withOpacity(0.5);
    return const Color(0xFF1F2229).withOpacity(0.5);
  }

  ///*** Backgrounds ***///

  /// #FAF9F7
  Color get bgScaffoldColor {
    return const Color(0xFFFAF9F7);
  }

  /// #FFFFFF
  Color get bgPrimaryColor {
    return const Color(0xFFFFFFFF);
  }

  /// #FAF9F8
  Color get bgSecondaryColor {
    return const Color(0xFF999999);
  }

  Color get backdropColor {
    return Colors.black.withOpacity(0.3);
  }

  //  Color get bgPrimaryColor => dynamicColor(light: Color(0xFFffffff),
  // dark: Color(0xFF333333)); }

}
