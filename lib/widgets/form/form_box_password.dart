part of widgets;

class FormBoxPassword extends HookWidget {
  const FormBoxPassword({
    @required this.controller,
    Key key,
    this.maxLength = WalletPasswordValidator.walletPasswordMaxLength,
    this.hintText,
    this.autoFocus = false,
    this.bordered,
    this.validator,
    this.title,
    this.titleStyle,
    this.margin,
    this.onChanged,
    this.onFocusChanged,
    this.titleAction,
  }) : super(key: key);

  final TextEditingController controller;
  final int maxLength;
  final String hintText;
  final String title;
  final TextStyle titleStyle;
  final bool autoFocus;
  final bool bordered;
  final FieldValidator validator;
  final EdgeInsetsGeometry margin;
  final ValueChanged<String> onChanged;
  final Function(bool hasFocus) onFocusChanged;
  final Widget titleAction;

  @override
  Widget build(BuildContext context) {
    final obscurePwd = useState(true);

    return FormBox(
      margin: margin,
      type: FormBoxType.inputPassword,
      title: title,
      titleStyle: titleStyle,
      titleAction: titleAction,
      autoFocus: autoFocus,
      bordered: bordered,
      validator: validator,
      controller: controller,
      hintText: hintText,
      iconName: obscurePwd.value ? CSIcons.EyeClose : CSIcons.EyeOpen,
      iconColor: context.blackColor,
      obscureText: obscurePwd.value,
      onPressIcon: () {
        obscurePwd.value = !obscurePwd.value;
      },
      maxLength: maxLength,
      onChanged: onChanged,
      onFocusChanged: onFocusChanged,
    );
  }
}
