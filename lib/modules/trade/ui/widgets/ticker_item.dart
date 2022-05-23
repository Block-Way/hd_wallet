part of trade_ui_module;

class TickerItem extends StatelessWidget {
  const TickerItem(
    this.price,
    this.amount, {
    Key key,
    this.isBuy = true,
    this.reverse = false,
    this.showBackground = false,
    this.backgroundIsDark = false,
    this.backgroundOnPrice = false,
    this.scale = 0,
    this.onPressed,
  }) : super(key: key);

  final bool isBuy;
  final String price;
  final String amount;
  final bool reverse;
  final bool showBackground;
  final bool backgroundIsDark;
  final bool backgroundOnPrice;
  final double scale;
  final Function(String) onPressed;

  @override
  Widget build(BuildContext context) {
    final colorBg = isBuy
        ? backgroundIsDark
            ? const Color(0xFF1c2d2f)
            : const Color(0xFFe9f8f2)
        : backgroundIsDark
            ? const Color(0xFF32242a)
            : const Color(0xFFffefed);
    final colorPrice = isBuy ? context.greenColor : context.redColor;
    final colorAmount =
        backgroundIsDark ? context.whiteLightColor : context.bodyColor;

    return CSContainer(
      height: 26,
      radius: 0,
      padding: context.edgeHorizontal8,
      margin: EdgeInsets.zero,
      onTap: onPressed != null && price != '-'
          ? () {
              onPressed(price);
            }
          : null,
      decoration: showBackground
          ? BoxDecoration(
              gradient: LinearGradient(
                begin: backgroundOnPrice == true
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                end: backgroundOnPrice == true
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                colors: reverse
                    ? [
                        Colors.transparent,
                        Colors.transparent,
                        colorBg,
                        colorBg,
                      ]
                    : [
                        colorBg,
                        colorBg,
                        Colors.transparent,
                        Colors.transparent,
                      ],
                stops: [
                  0,
                  if (reverse) 1 - scale else scale,
                  if (reverse) 1 - scale else scale,
                  1,
                ],
              ),
            )
          : BoxDecoration(
              color: Colors.transparent,
            ),
      child: RowItemBar(
        reverse ? amount : price,
        reverse ? price : amount,
        textStyle: context.textSmallPrice(
          color: reverse ? colorAmount : colorPrice,
        ),
        valueStyle: context.textSmallPrice(
          color: reverse ? colorPrice : colorAmount,
        ),
      ),
    );
  }
}
