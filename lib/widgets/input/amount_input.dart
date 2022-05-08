part of widgets;

class CSAmountInput extends HookWidget {
  const CSAmountInput({
    Key key,
    this.value,
    this.validator,
    this.controller,
    this.hintText,
    this.hintStyle,
    this.onChanged,
    this.step = 0.01,
    this.maxInteger = 10,
    this.maxDecimal = 2,
    this.spinner = true,
    this.unit,
  }) : super(key: key);

  final String value;
  final FieldValidator validator;
  final TextEditingController controller;
  final double step;
  final int maxInteger;
  final int maxDecimal;
  final bool spinner;
  final String unit;

  final String hintText;
  final TextStyle hintStyle;

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final focusNode = useFocusNode();

    void handleChangeValue(String newValue) {
      controller.text = newValue;
      onChanged(newValue);
    }

    return Container(
      padding: context.edgeAll10.copyWith(top: 12),
      height: 48,
      decoration: context.boxDecorationWithBorder(
        borderColor: Color(0xFFcccccc),
        borderWidth: 0.5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (spinner == true)
            CSButtonIcon(
              size: 12,
              borderRadius: 8,
              containerSize: 28,
              padding: EdgeInsets.zero,
              background: context.greyColor,
              icon: CSIcons.Minus,
              onPressed: () {
                focusNode.unfocus();
                handleChangeValue(
                  NumberUtil.isGreater(controller.text, step)
                      ? NumberUtil.minus<String>(controller.text, step)
                      : '0',
                );
              },
            ),
          Expanded(
            child: TextFormField(
              focusNode: focusNode,
              style: context.textBody(bold: true),
              cursorColor: context.bodyColor,
              scrollPadding: EdgeInsets.zero,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: hintStyle ?? context.textPlaceholder(),
                errorStyle: context.textSecondary(color: context.redColor),
                errorMaxLines: 1,
                contentPadding: EdgeInsets.zero,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: OutlineInputBorder(
                  gapPadding: 0,
                  borderSide: BorderSide.none,
                ),
              ),
              keyboardType: TextInputType.numberWithOptions(
                decimal: true,
              ),
              validator: validator,
              controller: controller,
              inputFormatters: [
                NumberTextInputFormatter(
                  maxDecimal: maxDecimal,
                  maxInteger: maxInteger,
                ),
              ],
              textAlign: spinner ? TextAlign.center : TextAlign.left,
              onChanged: onChanged,
            ),
          ),
          if (spinner == false)
            Container(
              width: 40,
              height: 28,
              alignment: Alignment.centerRight,
              child: Text(
                unit,
                style: context.textBody(bold: true),
                maxLines: 1,
              ),
            )
          else
            CSButtonIcon(
              size: 12,
              borderRadius: 8,
              containerSize: 28,
              padding: EdgeInsets.zero,
              background: context.greyColor,
              icon: CSIcons.Plus,
              onPressed: () {
                focusNode.unfocus();
                handleChangeValue(
                  NumberUtil.plus<String>(
                    controller.text.isNotEmpty ? controller.text : 0,
                    step,
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
