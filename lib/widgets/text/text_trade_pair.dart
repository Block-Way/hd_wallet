part of widgets;

class TextTradePair extends StatelessWidget {
  const TextTradePair(
    this.from,
    this.to,
    this.size, {
    this.color,
    this.toColor,
    this.bold = true,
    this.direction = false,
    this.isBuy = false,
    this.sameStyle = false,
    this.mainAxisAlignment = MainAxisAlignment.start,
    Key key,
  }) : super(key: key);

  final String from;
  final String to;
  final TextSize size;
  final Color color;
  final Color toColor;
  final bool bold;
  final bool direction;
  final bool isBuy;
  final bool sameStyle;
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final textColor = color ?? context.bodyColor;
    TextStyle fromStyle;
    switch (size) {
      case TextSize.big:
        fromStyle = context.textBig(
          bold: bold,
          color: textColor,
        );
        break;
      case TextSize.medium:
        fromStyle = context.textMedium(
          bold: bold,
          color: textColor,
        );
        break;
      case TextSize.body:
        fromStyle = context.textBody(
          bold: bold,
          color: textColor,
        );
        break;
      case TextSize.secondary:
        fromStyle = context.textSecondary(
          bold: bold,
          color: textColor,
        );
        break;
      case TextSize.small:
        fromStyle = context.textSmall(
          bold: bold,
          color: textColor,
        );
        break;
      default:
        break;
    }

    final toStyle = fromStyle.copyWith(
      fontSize: fromStyle.fontSize * 0.7,
      color: toColor ?? context.labelColor,
    );

    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (direction)
          Text(
            isBuy ? tr('trade:btn_buy') : tr('trade:btn_sell'),
            style: fromStyle.copyWith(
              color: isBuy ? context.greenColor : context.redColor,
            ),
          ),
        if (direction) Text(' '),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          children: [
            Text(from, style: fromStyle),
            Text('/$to', style: sameStyle ? fromStyle : toStyle),
          ],
        ),
      ],
    );
  }
}
