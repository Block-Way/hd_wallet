part of trade_ui_module;

class TradeSelectDrawer extends HookWidget {
  const TradeSelectDrawer({
    @required this.onSelected,
    @required this.selected,
    this.showSelectAll = false,
  });

  final void Function(TradePair tradePair) onSelected;
  final TradePair selected;
  final bool showSelectAll;

  @override
  Widget build(BuildContext context) {
    final selectedMarket = useState('');
    final searchKey = useState('');

    return SafeArea(
      child: Container(
        padding: context.edgeBottom,
        color: context.bgSecondaryColor,
        child: StoreConnector<AppState, TradePairVM>(
          distinct: true,
          converter: TradePairVM.fromStore,
          onInitialBuild: (viewModel) {
            viewModel.doLoadTradePair();
            if (viewModel.allTradeMarkets != null &&
                viewModel.allTradeMarkets.isNotEmpty) {
              final item = viewModel.allTradeMarkets.firstWhere(
                (e) => (selected?.priceName ?? '').contains(e.id),
                orElse: () => null,
              );
              selectedMarket.value =
                  item?.id ?? viewModel.allTradeMarkets.first.id;
            }
          },
          builder: (context, viewModel) {
            final markets = viewModel.allTradeMarkets;
            final pairs = viewModel.allTradePairs;
            final selectedId = selected?.id;
            if (markets.isEmpty || pairs.isEmpty) {
              return CSEmpty(
                isLoading: true,
                heightFromTop: context.mediaHeight * 0.3,
              );
            }

            final tradePairs = pairs
                .where((k) => k.marketId == selectedMarket.value)
                .where(
                  (e) => e.tradeSymbol.toLowerCase().contains(
                        searchKey.value.toLowerCase(),
                      ),
                )
                .toList();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: context.edgeAll,
                  child: Text(
                    tr('trade:trade_pair_select_title'),
                    style: context.textHuge(fontWeight: FontWeight.w700),
                  ),
                ),
                CSSearchInput(
                  margin: context.edgeAll,
                  height: 45,
                  hintText: tr('trade:trade_pair_search_hint'),
                  onChanged: (value) {
                    searchKey.value = value;
                  },
                  onClear: () {
                    searchKey.value = '';
                  },
                ),
                CSButtonTabs(
                  margin: context.edgeHorizontal,
                  items: markets
                      .map(
                        (item) => CSButtonTabsItem(
                          id: item.id,
                          label: item.isClosing
                              ? tr('trade:trade_pair_status_closing')
                              : item.nameByLang(tr('global:language_api')),
                        ),
                      )
                      .toList(),
                  selectedId: selectedMarket.value,
                  onSelectedId: (id) {
                    selectedMarket.value = id;
                  },
                ),
                Transform.translate(
                  offset: Offset(0, -10),
                  child: Container(
                    height: 0.5,
                    color: Color(0xFFf0f0f0),
                  ),
                ),
                Padding(
                  padding: context.edgeHorizontal.copyWith(
                    bottom: 8,
                    top: 5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tr('trade:trade_pair_select_lbl_pair'),
                        style: context.textSmall(),
                      ),
                      Text(
                        tr('trade:trade_pair_select_lbl_price'),
                        style: context.textSmall(),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: tradePairs
                        .map((item) => buildItem(
                              context,
                              item,
                              selectedId,
                            ))
                        .toList(),
                  ),
                ),
                if (showSelectAll)
                  Center(
                    child: CSButton(
                      margin: context.edgeAll,
                      width: context.mediaWidth,
                      label: tr('global:btn_all'),
                      onPressed: () {
                        AppNavigator.goBack();
                        onSelected(null);
                      },
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildItem(
    BuildContext context,
    TradePair tradePair,
    String selectedId,
  ) {
    return InkWell(
      onTap: () {
        AnalyticsReport().reportLog('Trade_Select', {
          'tradePair': tradePair.id,
        });
        if (tradePair.isOpening) {
          Toast.show(tr('trade:trade_pair_status_not_online'));
        } else if (tradePair.isClosing) {
          Navigator.pop(context);
          TradeOrderClosingPage.open(tradePair);
        } else {
          Navigator.pop(context);
          onSelected(tradePair);
        }
      },
      child: TradePairItem(
        tradePair,
        isActive: selectedId == tradePair.id,
      ),
    );
  }
}
