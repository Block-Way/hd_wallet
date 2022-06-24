part of trade_ui_module;

class TradePairItem extends StatelessWidget {
  const TradePairItem(
    this.tradePair, {
    this.isActive = false,
    this.showChange = false,
    this.showFaitPrice = false,
  });
  final TradePair tradePair;
  final bool isActive;
  final bool showChange;
  final bool showFaitPrice;

  @override
  Widget build(BuildContext context) {
    final isClosing = tradePair.isClosing;
    final isNotOnline = tradePair.isOpening;

    final showStatusKey = isClosing || isNotOnline;

    return AssetPriceListener(
      tradePairId: tradePair.id,
      builder: (
        context,
        fiatPrice,
        fiatCurrency,
        data,
      ) {
        final price = isClosing ? '-' : data.displayPrice;
        final change = data.change;

        final textColor = change == 0
            ? context.bodyColor
            : change > 0
                ? context.greenColor
                : context.redColor;

        final fiatPriceValid =
            !isClosing && NumberUtil.getDouble(fiatPrice) > 0;

        return Container(
          constraints: BoxConstraints(minHeight: 55),
          padding: EdgeInsets.symmetric(
            horizontal: context.edgeSize,
            vertical: 8,
          ),
          color: isActive ? context.greyColor : null,
          child: Row(
            children: [
              Expanded(
                  flex: 5,
                  child: Row(
                    children: [
                      TextTradePair(
                        tradePair.tradeName,
                        tradePair.priceName,
                        TextSize.medium,
                        color: isClosing ? context.secondaryColor : null,
                        toColor: isClosing ? context.secondaryColor : null,
                      ),
                      if (tradePair.isFast == true)
                        Padding(
                          padding: context.edgeLeft5,
                          child: CSImage(
                            'assets/images/trade_speed.png',
                            width: 25,
                            height: 10,
                            fit: BoxFit.contain,
                          ),
                        ),
                    ],
                  )),
              if (!showChange && showStatusKey)
                Text(
                  tr(tradePair.statusTransKey),
                  style: context.textSmall(
                    bold: true,
                    fontWeight: FontWeight.normal,
                  ),
                )
              else
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (showFaitPrice) SizedBox(height: 2),
                      PriceText(
                        price,
                        '',
                        TextSize.body,
                        color: isClosing ? context.secondaryColor : textColor,
                      ),
                      if (showFaitPrice)
                        PriceText(
                          fiatPriceValid ? fiatPrice : '-',
                          fiatPriceValid ? fiatCurrency : '-',
                          TextSize.tiny,
                          color: context.placeholderColor,
                          approximate: true,
                          bold: false,
                          sameStyle: true,
                        ),
                    ],
                  ),
                ),
              if (showChange)
                Expanded(
                  flex: 2,
                  child: showStatusKey
                      ? Center(
                          child: Text(
                            tr(tradePair.statusTransKey),
                            style: context.textSmall(
                              bold: true,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        )
                      : TextChange(
                          change,
                          TextSize.secondary,
                        ),
                )
            ],
          ),
        );
      },
    );
  }
}
