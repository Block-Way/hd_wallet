part of widgets;

class PriceText extends StatelessWidget {
  const PriceText(
    this.value,
    this.symbol,
    this.size, {
    this.color,
    this.bold = true,
    this.approximate = false,
    this.sameStyle = false,
    Key? key,
  }) : super(key: key);

  final String value;
  final String symbol;
  final TextSize size;
  final Color? color;
  final bool bold;
  final bool approximate;
  final bool sameStyle;

  @override
  Widget build(BuildContext context) {
    final textColor = color ?? context.bodyColor;
    late TextStyle valueStyle;
    switch (size) {
      case TextSize.huge:
        valueStyle = context.textHugePrice(
          bold: bold,
          fontWeight: FontWeight.normal,
          color: textColor,
        );
        break;
      case TextSize.big:
        valueStyle = context.textBigPrice(
          bold: bold,
          fontWeight: FontWeight.normal,
          color: textColor,
        );
        break;
      case TextSize.medium:
        valueStyle = context.textMediumPrice(
          bold: bold,
          fontWeight: FontWeight.normal,
          color: textColor,
        );
        break;
      case TextSize.body:
        valueStyle = context.textBodyPrice(
          bold: bold,
          fontWeight: FontWeight.normal,
          color: textColor,
        );
        break;
      case TextSize.secondary:
        valueStyle = context.textSecondaryPrice(
          bold: bold,
          fontWeight: FontWeight.normal,
          color: textColor,
        );
        break;
      case TextSize.small:
        valueStyle = context.textSmallPrice(
          bold: bold,
          fontWeight: FontWeight.normal,
          color: textColor,
        );
        break;
      case TextSize.tiny:
        valueStyle = context.textTinyPrice(
          bold: bold,
          fontWeight: FontWeight.normal,
          color: textColor,
        );
        break;
      default:
        break;
    }

    final showSymbol = symbol != null && symbol.isNotEmpty && value != '-';

    final symbolStyle = context
        .textBody(
          color: textColor,
          fontWeight: FontWeight.normal,
          bold: bold,
        )
        .copyWith(
          fontSize:
              sameStyle ? valueStyle.fontSize : valueStyle.fontSize! * 0.6,
        );

    return RichText(
      text: TextSpan(
        children: [
          if (approximate && value != '-')
            TextSpan(
              text: '≈ ',
              style: valueStyle,
            ),
          TextSpan(
            text: value,
            style: valueStyle,
          ),
          if (showSymbol)
            TextSpan(
              text: ' ',
            ),
          if (showSymbol)
            TextSpan(
              text: symbol,
              style: symbolStyle,
            ),
        ],
      ),
    );
  }
}
