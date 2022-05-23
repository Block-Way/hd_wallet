part of trade_ui_module;

class RowItemBar extends StatelessWidget {
  const RowItemBar(
    this.label,
    this.value, {
    this.color,
    this.valueColor,
    this.bold = false,
    this.valueBold = false,
    this.textStyle,
    this.valueStyle,
    this.valueWidget,
    this.valueFlex = 1,
    this.labelAlignment = Alignment.centerLeft,
    this.child,
    Key key,
  }) : super(key: key);

  final String label;
  final String value;
  final Color color;
  final bool bold;
  final Color valueColor;
  final bool valueBold;
  final TextStyle textStyle;
  final TextStyle valueStyle;
  final int valueFlex;
  final Widget valueWidget;
  final Alignment labelAlignment;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Container(
            alignment: labelAlignment,
            child: Text(
              label,
              maxLines: 1,
              style: textStyle ??
                  context.textSecondary(
                    bold: bold,
                    color: color,
                  ),
            ),
          ),
        ),
        Flexible(
          flex: valueFlex,
          child: valueWidget ??
              Text(
                value,
                maxLines: 1,
                style: valueStyle ??
                    context.textSecondary(
                      bold: valueBold,
                      color: valueColor,
                    ),
              ),
        ),
        if (child != null) child,
      ],
    );
  }
}
