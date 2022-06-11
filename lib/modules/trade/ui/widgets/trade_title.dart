part of trade_ui_module;

class TradeTitle extends HookWidget {
  const TradeTitle({
    required this.onPressed,
    this.child,
    this.color,
    this.hideChange = false,
    this.isFullScreen = false,
    this.tradePair,
  });

  final Color? color;
  final Widget? child;
  final bool hideChange;
  final bool isFullScreen;
  final TradePair? tradePair;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return CSContainer(
      //width: null,
      margin: EdgeInsets.zero,
      padding: context.edgeVertical10,
      decoration: context.boxDecoration(color: Colors.transparent),
      onTap: onPressed,
      child: Row(
        children: [
          if (isFullScreen != true) SizedBox(width: context.edgeSize),
          if (isFullScreen != true)
            Icon(
              CSIcons.Hamburger,
              size: 20,
              color: color ?? context.bodyColor,
            ),
          if (isFullScreen != true) SizedBox(width: 10),
          if (tradePair != null)
            TextTradePair(
              tradePair?.tradeName ?? '',
              tradePair?.priceName ?? '',
              isFullScreen == true ? TextSize.body : TextSize.big,
              sameStyle: true,
              color: color ?? context.bodyColor,
            ),
          if (tradePair != null && hideChange == false)
            AssetPriceListener(
              tradePairId: tradePair?.id,
              builder: (
                context,
                fiatPrice,
                fiatCurrency,
                data,
              ) =>
                  Padding(
                padding: context.edgeLeft5,
                child: TextChange(
                  data.change,
                  TextSize.small,
                  hideBackground: true,
                  // height: null,
                  autoWidth: true,
                ),
              ),
            ),
          if (isFullScreen != true) SizedBox(width: context.edgeSize),
        ],
      ),
    );
  }
}
