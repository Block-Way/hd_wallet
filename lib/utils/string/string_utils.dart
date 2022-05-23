part of utils;

class StringUtils {
  /// 这是汉语的这则表达式
  static const String _chineseRegEx = '[\u0391-\uFFE5]';

  static String strCut(
    String str, {
    int startKeep = 10,
    int endKeep = 10,
    String filler = '...',
  }) {
    if (str != null && str.length > (endKeep + startKeep)) {
      return '''${str.substring(0, startKeep)}$filler${str.substring(str.length - endKeep, str.length)}''';
    }
    return str;
  }

  static String displaySize(double amount, [int precision = 2]) {
    if (amount <= 0) {
      return '0';
    }
    final mul = math.log(amount) ~/ math.log(1000);
    if (mul < 0) {
      return amount.toStringAsFixed(precision);
    }
    final result = amount > 0 ? amount / math.pow(1000, mul) : 0;
    final unit = ['', 'K', 'M', 'B', 'T', 'Q', 'Q'][mul];
    return '${NumberUtil.truncateDecimal<String>(result, precision)}$unit';
  }

  static int strLength(String value, {bool chineseDouble = false}) {
    if (!chineseDouble) {
      return value.length;
    }

    final reg = RegExp(_chineseRegEx);
    var length = 0;
    for (int i = 0; i < value.length; i++) {
      if (reg.hasMatch(value.substring(i, i + 1))) {
        /* 中文字符长度为2 */
        length += 2;
      } else {
        /* 其他字符长度为1 */
        length += 1;
      }
    }
    return length;
  }

  static String subString(
    String value,
    int start,
    int end, {
    bool chineseDouble = false,
  }) {
    final mEnd = value.length - start > end ? end : value.length - start;
    if (!chineseDouble) {
      return value.substring(start, mEnd);
    }

    final base = value.substring(start, mEnd);
    final reg = RegExp(_chineseRegEx);
    final buffer = StringBuffer();
    var totalLength = 0;
    for (final item in base.split('')) {
      totalLength += reg.hasMatch(item) ? 2 : 1;
      if (totalLength > end) {
        return buffer.toString();
      }
      buffer.write(item);
    }

    return buffer.toString();
  }

  static int chineseWorldCount(String value) {
    final reg = RegExp(_chineseRegEx);
    var totalLength = 0;
    for (final item in value.split('')) {
      totalLength += reg.hasMatch(item) ? 1 : 0;
    }
    return totalLength;
  }
}
