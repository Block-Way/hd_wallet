part of widgets;

enum FormBoxType {
  child,
  inputText,
  inputNumber,
  inputPassword,
}

class FormBox extends HookWidget {
  const FormBox({
    Key key,
    this.title,
    this.titleStyle,
    this.titleAction,
    this.hintText,
    this.hintStyle,
    this.iconName,
    this.iconSize = 18.0,
    this.iconColor,
    this.iconText,
    this.iconWidget,
    this.onPressIcon,
    this.type,
    this.value,
    this.initialValue,
    this.validator,
    this.inputFormatters,
    this.controller,
    this.maxLines = 1,
    this.maxLength,
    this.margin,
    this.autoFocus = false,
    this.editable = true,
    this.readOnly = false,
    this.bordered = false,
    this.obscureText,
    this.showCounterText = false,
    this.maxLengthChineseDouble = false,
    this.child,
    this.inputTextStyle,
    this.inputLeftWidget,
    this.onChanged,
    this.onFocusChanged,
  }) : super(key: key);

  /// Title on Top-Left
  final String title;
  final TextStyle titleStyle;
  final Widget titleAction;

  final String hintText;
  final TextStyle hintStyle;

  ///  Icon next to Input
  final IconData iconName;
  final String iconText;
  final double iconSize;
  final Color iconColor;
  final Widget iconWidget;
  final VoidCallback onPressIcon;

  /// Form Input
  final String value;
  final String initialValue;
  final FormBoxType type;
  final FieldValidator validator;
  final List<TextInputFormatter> inputFormatters;
  final TextEditingController controller;

  final int maxLines;
  final int maxLength;

  /// 长度判断 中文是否为双字节
  final bool maxLengthChineseDouble;

  /// 是否为密文显示
  final bool obscureText;

  final EdgeInsetsGeometry margin;
  final bool autoFocus;
  final bool editable;
  final bool readOnly;
  final bool bordered;
  final Widget child;
  final TextStyle inputTextStyle;
  final Widget inputLeftWidget;

  /// If true, show text length and maxLength limit
  final bool showCounterText;

  final ValueChanged<String> onChanged;
  final Function(bool hasFocus) onFocusChanged;

  Widget buildSuffixWidget(
    BuildContext context,
  ) {
    if (iconName != null) {
      return CSButtonIcon(
        margin: context.edgeRight,
        padding: EdgeInsets.zero,
        containerSize: 28,
        size: iconSize,
        borderRadius: 8,
        onPressed: onPressIcon,
        icon: iconName,
        color: iconColor ?? context.bodyColor,
      );
    }
    if (iconText != null) {
      return CSButton(
        margin: context.edgeRight,
        padding: EdgeInsets.zero,
        width: 28,
        height: 28,
        borderRadius: 8,
        onPressed: onPressIcon,
        label: iconText,
        textStyle: context.textSmall(
          bold: true,
          color: iconColor ?? context.bodyColor,
        ),
      );
    }
    if (showCounterText == true) {
      return Container(
        width: 50,
        margin: context.edgeRight,
        alignment: Alignment.centerRight,
        child: ValueListenableBuilder<TextEditingValue>(
          valueListenable: controller,
          builder: (context, value, _) {
            final length = StringUtils.strLength(
              value.text,
              chineseDouble: maxLengthChineseDouble,
            );
            return Text(
              '$length/$maxLength',
              style: context.textSecondary(
                color: length < maxLength
                    ? context.placeholderColor
                    : context.redColor,
              ),
            );
          },
        ),
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final focusNode = useFocusNode();

    // ignore: invalid_use_of_protected_member
    if (onFocusChanged != null && !focusNode.hasListeners) {
      focusNode.addListener(() {
        onFocusChanged(focusNode.hasFocus);
      });
    }

    return Container(
      margin: margin ?? context.edgeAll,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: context.edgeBottom,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: titleStyle ??
                        context.textBody(
                          bold: true,
                          color: context.labelColor,
                        ),
                  ),
                ),
                if (titleAction != null) titleAction,
              ],
            ),
          ),
          if (bordered == true) SizedBox(height: context.edgeSize),
          child ??
              TextFormField(
                enabled: editable,
                readOnly: readOnly,
                focusNode: focusNode,
                autofocus: autoFocus,
                initialValue: controller != null ? null : initialValue ?? value,
                cursorColor: context.bodyColor,
                style: inputTextStyle ?? context.textBody(),
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: hintStyle ?? context.textPlaceholder(),
                  errorStyle: context.textSecondary(color: context.redColor),
                  errorMaxLines: 3,
                  alignLabelWithHint: true,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  prefix: inputLeftWidget,
                  contentPadding:
                      context.edgeHorizontal.copyWith(top: 24, bottom: 24),
                  counterText: '', // counter handled by buildSuffixWidget
                  suffixIcon: buildSuffixWidget(context),
                  suffixIconConstraints: BoxConstraints(
                    minHeight: 28,
                    minWidth: 28,
                  ),
                  filled: true,
                  fillColor: context.whiteColor,
                  border: OutlineInputBorder(
                    gapPadding: 0,
                    borderSide: bordered == true
                        ? BorderSide(color: context.borderColor)
                        : BorderSide.none,
                    borderRadius: context.radiusAll,
                  ),
                  focusedBorder: OutlineInputBorder(
                    gapPadding: 0,
                    borderSide: bordered == true
                        ? BorderSide(color: context.borderColor)
                        : BorderSide.none,
                    borderRadius: context.radiusAll,
                  ),
                  enabledBorder: OutlineInputBorder(
                    gapPadding: 0,
                    borderSide: bordered == true
                        ? BorderSide(color: context.borderColor)
                        : BorderSide.none,
                    borderRadius: context.radiusAll,
                  ),
                ),
                maxLines: maxLines,
                maxLength: maxLength,
                obscureText: obscureText ?? type == FormBoxType.inputPassword,
                keyboardType: type == FormBoxType.inputNumber
                    ? TextInputType.numberWithOptions(decimal: true)
                    : TextInputType.text,
                validator: validator,
                controller: controller,
                inputFormatters: [
                  ...inputFormatters ?? [],
                  if (maxLengthChineseDouble) ChineseDoubleFormatter(maxLength),
                ],
                onChanged: onChanged,
              ),
        ],
      ),
    );
  }
}
