part of widgets;

/// same function signature as FormTextField's validator;
typedef ValidatorFunction<T> = T Function(T value);

abstract class FieldValidator<T> {
  FieldValidator(this.errorText) : assert(errorText != null);
  final accountPasswordRegex =
      r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d!@#%&*_?/]{8,20}$';

  /// the errorText to display when the validation fails
  final String errorText;

  /// checks the input against the given conditions
  bool isValid(T value);

  /// call is a special function that makes a class callable
  /// returns null if the input is valid otherwise it
  /// returns the provided error errorText
  String call(T value) {
    return isValid(value) ? null : errorText;
  }
}

abstract class TextFieldValidator extends FieldValidator<String> {
  TextFieldValidator(String errorText) : super(errorText);

  // return false if you want the validator to return error
  // message when the value is empty.
  bool get ignoreEmptyValues => true;

  @override
  String call(String value) {
    return (ignoreEmptyValues && value.isEmpty) ? null : super.call(value);
  }

  /// helper function to check if an input matches a given pattern
  bool hasMatch(String pattern, String input) =>
      RegExp(pattern).hasMatch(input);
}

class RequiredValidator extends TextFieldValidator {
  RequiredValidator({
    @required String errorText,
  }) : super(errorText);

  @override
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(String value) {
    return value.isNotEmpty;
  }

  @override
  String call(String value) {
    return isValid(value) ? null : errorText;
  }
}

class RequiredCreateAd extends TextFieldValidator {
  RequiredCreateAd({
    @required String errorText,
    this.inputController,
    this.text,
    this.errorZeroText,
  }) : super(errorText);

  final TextEditingController inputController;
  final String text;
  final String errorZeroText;

  @override
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(String value) {
    return value.isNotEmpty;
  }

  @override
  String call(String value) {
    final amount = inputController?.text;
    if (isValid(value) == false) {
      return errorText;
    }

    if (double.tryParse(value) == 0) {
      return errorZeroText;
    }

    if (amount != null &&
        ((double.tryParse(value) ?? 0) < (double.tryParse(amount) ?? 0))) {
      return text;
    }
    return null;
  }
}

class MaxLengthValidator extends TextFieldValidator {
  MaxLengthValidator(this.max, {@required String errorText}) : super(errorText);
  final int max;

  @override
  bool isValid(String value) {
    return value.length <= max;
  }
}

class MinLengthValidator extends TextFieldValidator {
  MinLengthValidator(this.min, {@required String errorText}) : super(errorText);
  final int min;

  @override
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(String value) {
    return value.length >= min;
  }
}

class LengthRangeValidator extends TextFieldValidator {
  LengthRangeValidator({
    @required this.min,
    @required this.max,
    @required String errorText,
  }) : super(errorText);

  final int min;
  final int max;

  @override
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(String value) {
    return value.length >= min && value.length <= max;
  }
}

class RangeValidator extends TextFieldValidator {
  RangeValidator({
    @required this.min,
    @required this.max,
    @required String errorText,
    this.graterThen = false,
    this.isRequired = false,
  }) : super(errorText);
  final num min;
  final num max;
  final bool graterThen;
  final bool isRequired;

  @override
  bool get ignoreEmptyValues => !isRequired;

  @override
  bool isValid(String value) {
    if (isRequired && value?.isEmpty == true) {
      return false;
    }

    try {
      final numericValue = num.parse(value);
      return graterThen
          ? numericValue > min && numericValue < max
          : numericValue >= min && numericValue <= max;
    } catch (_) {
      return false;
    }
  }
}

class EmailValidator extends TextFieldValidator {
  EmailValidator({@required String errorText}) : super(errorText);

  /// regex pattern to validate email inputs.
  final String emailRegex =
      r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$";

  @override
  bool isValid(String value) => hasMatch(emailRegex, value);
}

class PatternValidator extends TextFieldValidator {
  PatternValidator(this.pattern, {@required String errorText})
      : super(errorText);

  final String pattern;

  @override
  bool isValid(String value) => hasMatch(pattern, value);
}

class DateValidator extends TextFieldValidator {
  DateValidator(
    this.format, {
    @required String errorText,
  }) : super(errorText);
  final String format;

  @override
  bool isValid(String value) {
    try {
      final dateTime = DateFormat(format).parseStrict(value);
      return dateTime != null;
    } catch (_) {
      return false;
    }
  }
}

class MultiValidator extends FieldValidator {
  MultiValidator(this.validators) : super(_errorText);
  final List<FieldValidator> validators;
  static String _errorText = '';

  @override
  bool isValid(dynamic value) {
    for (final validator in validators) {
      if (!validator.isValid(value)) {
        _errorText = validator.errorText;
        return false;
      }
    }
    return true;
  }

  @override
  String call(dynamic value) {
    return isValid(value) ? null : _errorText;
  }
}

/// a special match validator to check
/// if the input equals another provided value;
class MatchValidator {
  MatchValidator({@required this.errorText});
  final String errorText;

  String validateMatch(String value, String value2) {
    return value == value2 ? null : errorText;
  }
}

class AccountPasswordValidator extends TextFieldValidator {
  AccountPasswordValidator({@required String errorText}) : super(errorText);
  @override
  bool isValid(String value) => hasMatch(accountPasswordRegex, value);
}

class WalletPasswordValidator extends TextFieldValidator {
  WalletPasswordValidator({@required String errorText}) : super(errorText);
  static const walletPasswordMaxLength = 10000;
  static const walletPasswordRegex =
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[^]{8,10000}$';

  @override
  bool isValid(String value) => hasMatch(walletPasswordRegex, value);
}

// 单纯判断两个密码是否一致 密码规则，为空用 别的方法判断
class AccountPasswordAgainValidator extends RequiredValidator {
  AccountPasswordAgainValidator(
      {@required String errorText, @required this.fieldPwd})
      : super(errorText: errorText);
  final TextEditingController fieldPwd;

  @override
  bool isValid(String value) {
    if (fieldPwd.text != value) {
      return false;
    }
    return true;
  }
}

class ProjectNameValidator extends RequiredValidator {
  ProjectNameValidator({@required String errorText})
      : super(errorText: errorText);
  final String enRegex = r'^[A-Za-z\s]+$';

  @override
  bool isValid(String value) => hasMatch(enRegex, value);
}

class SymbolValidator extends RequiredValidator {
  SymbolValidator({@required String errorText}) : super(errorText: errorText);
  final String enRegex = r'^[A-Za-z]+$';

  @override
  bool isValid(String value) => hasMatch(enRegex, value);
}

class WebUrlValidator extends RequiredValidator {
  WebUrlValidator({@required String errorText}) : super(errorText: errorText);

  final String webUrlRegex =
      r'(?=^.{3,255}$)[\s\S]{0,62}(\.[a-zA-Z0-9][-a-zA-Z0-9]{0,62})+$';

  @override
  bool isValid(String value) => hasMatch(webUrlRegex, value);
}
