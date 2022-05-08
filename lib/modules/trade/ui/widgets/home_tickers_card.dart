part of trade_ui_module;

class HomeTickersCard extends HookWidget {
  const HomeTickersCard({
    @required this.tradePair,
    @required this.onPressed,
    @required this.onChangeSpan,
    Key key,
  }) : super(key: key);

  final TradePair tradePair;
  final Function(String) onPressed;
  final Function(String) onChangeSpan;

  @override
  Widget build(BuildContext context) {
    final currentSpan = context.select<TradeTickersCubit, String>(
      (cubit) => cubit.state.span,
    );

    // 0 = default (both)
    // 1 = ask/sell
    // 2 = bid/buys
    final tickerSide = useState(0);

    final isDefault = tickerSide.value == 0;
    final tickerCount = isDefault ? 5 : 10;

    final tickerImages = [
      'assets/images/ticker_btn_default.png',
      'assets/images/ticker_btn_sell.png',
      'assets/images/ticker_btn_buy.png'
    ];

    return CSContainer(
      margin: context.edgeAll.copyWith(right: 6, top: 6, bottom: 6),
      padding: context.edgeVertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: context.edgeHorizontal8,
            child: RowItemBar(
              tr('trade:order_book_lbl_price'),
              tr('trade:order_book_lbl_amount'),
              textStyle: context.textSmall(),
              valueStyle: context.textSmall(),
            ),
          ),
          SizedBox(height: 9),
          if (tickerSide.value == 1 || isDefault)
            TickerList(
              limit: tickerCount,
              tradeSide: TradeSide.sell,
              tradePair: tradePair,
              showBackground: true,
              onPressed: onPressed,
              rowReverse: true,
            ),
          Padding(
            padding: context.edgeAll8,
            child: AssetPriceListener(
              key: ValueKey(tradePair.id),
              tradePairId: tradePair.id,
              builder: (context, fiatPrice, fiatCurrency, data) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PriceText(
                    data.displayPrice,
                    '',
                    TextSize.body,
                    color: context.greenColor, // TODO: change color?
                  ),
                  SizedBox(height: 2),
                  PriceText(
                    fiatPrice,
                    fiatCurrency,
                    TextSize.tiny,
                    color: context.labelColor,
                    sameStyle: true,
                    approximate: true,
                  ),
                ],
              ),
            ),
          ),
          if (tickerSide.value == 2 || isDefault)
            TickerList(
              limit: tickerCount,
              tradeSide: TradeSide.buy,
              tradePair: tradePair,
              showBackground: true,
              onPressed: onPressed,
            ),
          Spacer(),
          Row(
            children: [
              CSButton(
                width: 70,
                height: 21,
                borderRadius: 5,
                margin: context.edgeLeft8,
                padding: context.edgeHorizontal5,
                backgroundColor: context.greyDarkColor,
                cmpRight: Padding(
                  padding: context.edgeHorizontal5,
                  child: Icon(
                    CSIcons.ArrowDownBold,
                    size: 5,
                    color: context.secondaryColor,
                  ),
                ),
                onPressed: () {
                  showTickerSpanMenuDialog(
                    context,
                    currentSpan,
                    tradePair,
                    (value) {
                      onChangeSpan(value);
                    },
                  );
                },
                child: Expanded(
                  child: Text(
                    currentSpan == '0'
                        ? tr('trade:order_ticker_lbl_default')
                        : currentSpan,
                    style: context.textTinyPrice(),
                  ),
                ),
              ),
              Spacer(),
              CSButton(
                width: 29,
                height: 21,
                borderRadius: 3,
                margin: context.edgeRight5,
                padding: context.edgeHorizontal5,
                backgroundColor: context.greyDarkColor,
                customBorder: CircleBorder(),
                cmpLeft: CSImage(
                  tickerImages[tickerSide.value],
                  width: 15,
                  height: 15,
                  fit: BoxFit.contain,
                  backgroundColor: Colors.transparent,
                ),
                onPressed: () {
                  showTickerSideMenuDialog(
                    context,
                    tickerSide.value,
                    (value) {
                      tickerSide.value = value;
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void showTickerSideMenuDialog(
  BuildContext context,
  int selected,
  Function(int value) onSelected,
) {
  final options = [
    CSOptionsItem(
      label: tr('trade:order_book_btn_all'),
      value: 0,
      color: selected == 0 ? context.primaryColor : null,
    ),
    CSOptionsItem(
      label: tr('trade:order_book_btn_ask'),
      value: 1,
      color: selected == 1 ? context.primaryColor : null,
    ),
    CSOptionsItem(
      label: tr('trade:order_book_btn_bid'),
      value: 2,
      color: selected == 2 ? context.primaryColor : null,
    ),
  ];
  showOptionsDialog<int>(
    context,
    options: options,
    onSelected: onSelected,
  );
}

void showTickerSpanMenuDialog(
  BuildContext context,
  String selected,
  TradePair tradePair,
  Function(String value) onSelected,
) {
  final options = tradePair.spans
      .map(
        (value) => CSOptionsItem(
          label: value == '0' ? tr('trade:order_ticker_lbl_default') : value,
          value: value,
          color: selected == value ? context.primaryColor : null,
        ),
      )
      .toList();

  showOptionsDialog<String>(
    context,
    options: options,
    onSelected: onSelected,
  );
}
