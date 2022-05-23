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
    return const Color(0xFF999999);
  }

  /// #FFDF0C
  Color get primaryColor {
    return const Color(0xFFFFDF0C);
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
    return const Color(0xFFFF654C);
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
    return const Color(0xFFF5F5F5);
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
    return const Color(0xFFFFDF0C);
  }

  /// #333333
  Color get btnPrimaryTextColor {
    return const Color(0xFF333333);
  }

  /// #FFDF0C withOpacity
  Color get btnDisabledBgColor {
    return const Color(0xFFFFDF0C).withOpacity(0.5);
  }

  /// #333333 withOpacity
  Color get btnDisabledTextColor {
    return const Color(0xFF333333).withOpacity(0.5);
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
    return const Color(0xFFFAF9F8);
  }

  Color get backdropColor {
    return Colors.black.withOpacity(0.3);
  }

  //  Color get bgPrimaryColor => dynamicColor(light: Color(0xFFffffff),
  // dark: Color(0xFF333333)); }

}
