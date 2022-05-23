part of utils;

class NumberUtil {
  static final BigInt rawPerNano = BigInt.from(10).pow(18);

  /// Max digits after decimal, for cryptos typically is 8
  static const int maxDecimalDigits = 8;

  /// Get the numbers of decimals digits of a given number
  /// [Examples]
  /// if value is 1.1234 then return 4
  ///
  static int getDecimalDigits(dynamic value) {
    if (value != null) {
      final list = '$value'.split('.');
      if (list != null && list.length > 1) {
        return list[1].length;
      }
    }
    return 0;
  }

  /// Get the minimum value of the specified decimal place
  /// [Examples]
  /// if precision is 0 then return 0.1
  /// if precision is 1 then return 0.1
  /// if precision is 2 then return 0.01
  /// if precision is 3 then return 0.001
  ///
  static double getDecimalMinValue(int precision) {
    if (precision <= 1) {
      return 0.1;
    }
    return double.tryParse('1e-$precision') ?? 0.1;
  }

  /// Return a double from any
  ///
  static double getDouble(dynamic raw, [double valueIfNull = 0.0]) {
    if (raw == null) {
      return valueIfNull;
    }
    if (raw is double) {
      return raw;
    }
    return double.tryParse(raw.toString()) ?? valueIfNull ?? 0.0;
  }

  /// Return a int from any
  ///
  static int getInt(dynamic raw, [int valueIfNull = 0]) {
    if (raw == null) {
      return valueIfNull;
    }
    if (raw is int) {
      return raw;
    }
    return int.tryParse(raw.toString()) ?? valueIfNull ?? 0;
  }

  /// Return a Decimal from any
  ///
  static Decimal getDecimal(dynamic raw, [Decimal valueIfNull]) {
    if (raw == null) {
      return valueIfNull;
    }
    return Decimal.parse(raw.toString());
  }

  /// Truncate a value to a specific precision
  /// - Default it uses maxDecimalDigits, equals to 8
  ///
  /// @param input 1.059
  /// @return double value 1.05
  ///
  static T truncateDecimal<T>(
    dynamic raw, [
    int precision = maxDecimalDigits,
  ]) {
    if (raw == null) {
      return _typeConvert<T>('0.0');
    }

    final amount = Decimal.parse(raw.toString());
    final powPrecision = math.pow(10, precision);

    final result =
        (amount * Decimal.fromInt(powPrecision.toInt())).truncateToDouble() /
            powPrecision;

    return _typeConvert<T>(result.toString());
  }

  /// Convert raw to ban and return as BigDecimal
  ///
  /// @param raw 100000000000000000000000000000
  /// @return Decimal value 1.000000000000000000000000000000
  ///
  static Decimal getRawAsUsableDecimal(String raw) {
    final amount = Decimal.parse(raw.toString());
    final result = amount / Decimal.parse(rawPerNano.toString());
    return result;
  }

  /// Return raw as a normal amount.
  ///
  /// @param raw 100000000000000000000000000000
  /// @returns 1
  ///
  static String getRawAsUsableString(String raw) {
    final nf = NumberFormat.currency(
      locale: 'en_US',
      decimalDigits: maxDecimalDigits,
      symbol: '',
    );

    var asString = nf.format(truncateDecimal(getRawAsUsableDecimal(raw)));
    final split = asString.split('.');
    if (split.length > 1) {
      // Remove trailing 0s from this
      if (int.parse(split[1]) == 0) {
        asString = split[0];
      } else {
        var newStr = '${split[0]}.';
        var digits = split[1];
        var endIndex = digits.length;
        for (var i = 1; i <= digits.length; i++) {
          if (int.parse(digits[digits.length - i]) == 0) {
            endIndex--;
          } else {
            break;
          }
        }
        digits = digits.substring(0, endIndex);
        newStr = '${split[0]}.$digits';
        asString = newStr;
      }
    }
    return asString;
  }

  /// Return readable amount as int string
  ///
  /// @param amount 1.01
  /// @returns  101000000000000000000000000000 (base on precision)
  /// @default precision = 18
  ///
  static int getAmountAsInt(dynamic amount, [int precision = 18]) {
    if (amount is num && getDecimalDigits(amount) > 10) {
      return (amount * math.pow(10, precision)).toInt();
    }

    final asPrecision = BigInt.from(10).pow(precision);
    final asDecimal = Decimal.parse(amount.toString());
    final rawDecimal = Decimal.parse(asPrecision.toString());
    return (asDecimal * rawDecimal).toInt();
  }

  /// Return readable amount as double string
  ///
  /// @param amount 112345678
  /// @returns  1.12345678 (base on precision)
  ///
  static double getIntAmountAsDouble(dynamic amount, [int precision = 18]) {
    if (amount is num && getDecimalDigits(amount) > 10) {
      return amount / math.pow(10, precision);
    }

    final asPrecision = BigInt.from(10).pow(precision);
    final asDecimal = Decimal.parse(amount.toString());
    final rawDecimal = Decimal.parse(asPrecision.toString());
    return (asDecimal / rawDecimal).toDouble();
  }

  /// Return percentage of total supply
  ///
  /// @param amount 10020243004141
  /// @return 0.0000001%
  ///
  static String getPercentOfTotalSupply(BigInt amount) {
    final totalSupply =
        Decimal.parse('133248290000000000000000000000000000000');
    final amountRaw = Decimal.parse(amount.toString());
    return ((amountRaw / totalSupply) * Decimal.fromInt(100))
        .toStringAsFixed(4);
  }

  /// Sanitize a number as something that can actually
  /// be parsed. Expects "." to be decimal separator
  ///
  /// @param amount $1,512
  /// @returns 1.512
  ///
  static String sanitizeNumber(
    String input, {
    int maxDecimalDigits = maxDecimalDigits,
  }) {
    var sanitized = '';
    final splitStr = input.split('.');
    if (splitStr.length > 1) {
      if (splitStr[1].length > maxDecimalDigits) {
        splitStr[1] = splitStr[1].substring(0, maxDecimalDigits);
        // ignore: parameter_assignments
        input = '${splitStr[0]}.${splitStr[1]}';
      }
    }
    for (var i = 0; i < input.length; i++) {
      try {
        if (input[i] == '.') {
          sanitized = sanitized + input[i];
        } else {
          int.parse(input[i]);
          sanitized = sanitized + input[i];
        }
      } catch (e) {
        //
      }
    }
    return sanitized;
  }

  ///*** Number operator ****/

  static Type _typeOf<T>() => T;

  static T _typeConvert<T>(String value) {
    final type = '${_typeOf<T>()}';
    if (type == 'double') {
      return double.parse(value, (_) => null) as T;
    } else if (type == 'int') {
      return double.parse(value, (_) => null).toInt() as T;
    } else {
      return value as T;
    }
  }

  static T plus<T>(dynamic v1, dynamic v2) {
    try {
      final value = Decimal.parse('$v1') + Decimal.parse('$v2');
      return _typeConvert<T>(value.toString());
    } catch (e) {
      return null;
    }
  }

  static T minus<T>(dynamic v1, dynamic v2) {
    try {
      final value = Decimal.parse('$v1') - Decimal.parse('$v2');
      return _typeConvert<T>(value.toString());
    } catch (_) {
      return null;
    }
  }

  static T multiply<T>(dynamic v1, dynamic v2, [int precision]) {
    try {
      final value = Decimal.parse('$v1') * Decimal.parse('$v2');
      if (precision != null) {
        return _typeConvert<T>(truncateDecimal(value, precision).toString());
      }
      return _typeConvert<T>(value.toString());
    } catch (_) {
      return null;
    }
  }

  static T divide<T>(dynamic v1, dynamic v2, [int precision]) {
    try {
      final value = Decimal.parse('$v1') / Decimal.parse('$v2');
      if (precision != null) {
        return _typeConvert<T>(truncateDecimal(value, precision).toString());
      }
      return _typeConvert<T>(value.toString());
    } catch (_) {
      return null;
    }
  }

  static bool isGreater<T>(dynamic v1, dynamic v2) {
    try {
      final value = Decimal.parse('$v1') > Decimal.parse('$v2');
      return value;
    } catch (_) {
      return false;
    }
  }

  static bool isLess<T>(dynamic v1, dynamic v2) {
    try {
      final value = Decimal.parse('$v1') < Decimal.parse('$v2');
      return value;
    } catch (_) {
      return false;
    }
  }

  static bool isLessOrEqual<T>(dynamic v1, dynamic v2) {
    try {
      final value = Decimal.parse('$v1') <= Decimal.parse('$v2');
      return value;
    } catch (_) {
      return false;
    }
  }
}
