part of widgets;

class TextChange extends StatelessWidget {
  const TextChange(
    this.change,
    this.size, {
    this.height = 32,
    this.precision = 2,
    this.hideBackground = false,
    this.alignment,
    this.autoWidth = false,
    this.isKLine = false,
    this.padding,
    Key? key,
  }) : super(key: key);

  final double change;
  final int precision;
  final double height;
  final TextSize size;
  final bool hideBackground;
  final AlignmentGeometry? alignment;
  final bool autoWidth;
  final bool isKLine;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final subChange = NumberUtil.truncateDecimal<double>(change, precision);

    final changeText =
        '${subChange > 0 ? '+' : ''}${subChange.toStringAsFixed(precision)}%';

    final bgColor = subChange == 0
        ? isKLine == true
            ? Color(0xFF676F83)
            : context.whiteColor
        : subChange > 0
            ? context.greenColor
            : context.redColor;

    final textColor = subChange == 0
        ? isKLine == true
            ? context.whiteColor
            : context.secondaryColor
        : hideBackground == false
            ? context.whiteColor
            : subChange > 0
                ? context.greenColor
                : context.redColor;

    late double? _width;
    late TextStyle textStyle;
    switch (size) {
      case TextSize.body:
        textStyle =
            context.textBodyPrice(bold: true, fontWeight: FontWeight.normal);
        _width = 65;
        break;
      case TextSize.secondary:
        textStyle = context.textSecondaryPrice(
            bold: true, fontWeight: FontWeight.normal);
        _width = 65;
        break;
      case TextSize.small:
        textStyle =
            context.textSmallPrice(bold: true, fontWeight: FontWeight.normal);
        _width = 56;
        break;
      case TextSize.tiny:
        textStyle =
            context.textTinyPrice(bold: true, fontWeight: FontWeight.normal);
        _width = 55;
        break;
      default:
        break;
    }

    return Container(
      width: _width,
      height: height,
      padding: padding,
      decoration: hideBackground
          ? null
          : context.boxDecorationWithBorder(
              color: bgColor,
              radius: 2,
              borderColor: isKLine == true ? bgColor : Color(0xFFe5e5e5),
              borderWidth: subChange == 0 ? 1 : 0,
            ),
      alignment: alignment ?? Alignment.center,
      child: Text(
        changeText,
        style: textStyle.copyWith(color: textColor),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
