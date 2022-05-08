part of utils;

class EnumToString {
  static String parse(dynamic enumItem) {
    if (enumItem == null) {
      return null;
    }
    return enumItem.toString().split('.')[1].toLowerCase();
  }

  static T fromString<T>(List<T> enumValues, String value) {
    if (value == null || enumValues == null) {
      return null;
    }
    return enumValues.singleWhere(
      (enumItem) =>
          EnumToString.parse(enumItem)?.toLowerCase() == value?.toLowerCase(),
      orElse: () => null,
    );
  }
}
