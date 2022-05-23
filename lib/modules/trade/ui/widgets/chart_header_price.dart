part of trade_ui_module;

class ChartHeaderPrice extends StatelessWidget {
  const ChartHeaderPrice(
    this.value,
    this.fiatPrice,
    this.fiatCurrency, {
    Key key,
    this.isBuy = true,
    this.change,
    this.isVertical = true,
    this.color,
    this.isFullScreen = false,
  }) : super(key: key);

  final String value;
  final String fiatPrice;
  final String fiatCurrency;
  final double change;
  final bool isBuy;
  final bool isVertical;
  final Color color;
  final bool isFullScreen;

  @override
  Widget build(BuildContext context) {
    return Flex(
      crossAxisAlignment: isFullScreen == true
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      direction: isVertical ? Axis.vertical : Axis.horizontal,
      children: [
        PriceText(
          value,
          '',
          isFullScreen == true ? TextSize.body : TextSize.big,
          color: isBuy ? context.greenColor : context.redColor,
        ),
        SizedBox(
          height: isVertical ? 10 : 0,
          width: isVertical ? 0 : 8,
        ),
        Row(
          children: [
            TextChange(
              change,
              isFullScreen == true ? TextSize.body : TextSize.small,
              height: null,
              hideBackground: isFullScreen,
              isKLine: true,
              padding:
                  EdgeInsets.symmetric(vertical: isFullScreen == true ? 0 : 3),
            ),
            SizedBox(width: isFullScreen ? 8 : 10),
            Padding(
              padding: EdgeInsets.only(bottom: isFullScreen == true ? 4 : 0),
              child: PriceText(
                fiatPrice,
                fiatCurrency,
                isFullScreen ? TextSize.tiny : TextSize.small,
                color: color,
                sameStyle: true,
                approximate: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
