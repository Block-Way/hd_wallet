part of widgets;

class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({
    int decimalRange,
    bool activatedNegativeValues = false,
  }) : assert(decimalRange == null || decimalRange >= 0,
            'DecimalTextInputFormatter declaretion error') {
    final dp = (decimalRange != null && decimalRange > 0)
        ? '([.][0-9]{0,$decimalRange}){0,1}'
        : '';
    final numRegex = '[0-9]*$dp';

    if (activatedNegativeValues) {
      _exp = RegExp('^((((-){0,1})|((-){0,1}[0-9]$numRegex))){0,1}\$');
    } else {
      _exp = RegExp('^($numRegex){0,1}\$');
    }
  }

  RegExp _exp;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (_exp.hasMatch(newValue.text)) {
      return newValue;
    }
    return oldValue;
  }
}

class NumberTextInputFormatter extends TextInputFormatter {
  NumberTextInputFormatter({
    @required int maxInteger,
    @required int maxDecimal,
  }) {
    final integerRegEx = '([0-9]{0,$maxInteger}){0,1}';
    final decimalRegEx = '([.][0-9]{0,$maxDecimal}){0,1}';

    _exp = RegExp('^(($integerRegEx)($decimalRegEx){0,1})\$');
  }

  RegExp _exp;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (_exp.hasMatch(newValue.text)) {
      return newValue;
    }
    return oldValue;
  }
}

class ChineseDoubleFormatter extends TextInputFormatter {
  ChineseDoubleFormatter(this.maxLength);
  final int maxLength;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final count = StringUtils.strLength(
      newValue.text,
      chineseDouble: true,
    );
    if (count > maxLength) {
      final str = StringUtils.subString(
        newValue.text,
        0,
        maxLength,
        chineseDouble: true,
      );

      return TextEditingValue(
        text: str,
        selection: TextSelection.collapsed(offset: str.length),
      );
    }
    return newValue;
  }
}
