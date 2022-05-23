part of home_ui_module;

class HomePricesCard extends StatelessWidget {
  const HomePricesCard({
    @required this.prices,
    @required this.doChangeTradePair,
    @required this.allTradePairs,
  }) : assert(prices != null);

  final List<AssetPrice> prices;
  final List<TradePair> allTradePairs;
  final Future<void> Function(TradePair tradePair) doChangeTradePair;
  @override
  Widget build(BuildContext context) {
    if (prices.isEmpty) {
      return SizedBox();
    }

    return CSContainer(
      margin: context.edgeAll.copyWith(top: 0),
      padding: context.edgeAll.copyWith(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr('home:price_title'),
            style: context.textMedium(bold: true),
          ),
          Padding(
            padding: context.edgeTop,
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text(
                    tr('home:price_lbl_pair'),
                    maxLines: 1,
                    style: context.textSmall(),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    tr('home:price_lbl_price'),
                    maxLines: 1,
                    style: context.textSmall(),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      tr('home:price_lbl_change'),
                      maxLines: 1,
                      style: context.textSmall(),
                    ),
                  ),
                )
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: prices.length,
            itemBuilder: (context, index) {
              final item = prices[index];
              final tradePair = allTradePairs.firstWhere(
                  (e) => e.id == item.tradePairId,
                  orElse: () => null);

              return CSContainer(
                radius: 0,
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                onTap: tradePair != null
                    ? () {
                        doChangeTradePair(tradePair).then((_) {
                          AppNavigator.gotoTabBarPage(AppTabBarPages.trade);
                        });
                      }
                    : null,
                key: Key(item.tradePairId),
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: TextTradePair(
                        item.tradeSymbol,
                        item.priceSymbol,
                        TextSize.body,
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: AssetPriceListener(
                        tradePairId: item.tradePairId,
                        builder: (
                          context,
                          fiatPrice,
                          fiatCurrency,
                          price,
                        ) =>
                            Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 2),
                            PriceText(
                              item.displayPrice,
                              '',
                              TextSize.body,
                            ),
                            SizedBox(height: 2),
                            PriceText(
                              fiatPrice,
                              fiatCurrency,
                              TextSize.tiny,
                              color: context.placeholderColor,
                              approximate: true,
                              sameStyle: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: AssetPriceListener(
                        tradePairId: item.tradePairId,
                        builder: (
                          context,
                          fiatPrice,
                          fiatCurrency,
                          data,
                        ) =>
                            TextChange(
                          data.change == 0 ? item.change : data.change,
                          TextSize.small,
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
