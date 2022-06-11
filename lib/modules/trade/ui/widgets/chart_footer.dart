part of trade_ui_module;

class ChartFooter extends HookWidget {
  const ChartFooter({
    required this.tradePair,
    Key? key,
  }) : super(key: key);

  final TradePair tradePair;

  @override
  Widget build(BuildContext context) {
    final selectedTab = useState('tickers');
    const textColor = Color(0xFF676f83);

    return CSContainer(
      decoration: context.boxDecoration(color: Color(0xFF1b1e26)),
      padding: context.edgeBottom,
      child: Column(
        children: [
          CSButtonMenu<String>(
            items: [
              CSButtonMenuItem(
                id: 'tickers',
                label: tr('trade:chart_tab_tickers'),
              ),
              CSButtonMenuItem(
                id: 'deals',
                label: tr('trade:chart_tab_deals'),
              ),
            ],
            textColor: textColor,
            selectedColor: context.whiteLightColor,
            selectedId: selectedTab.value,
            onSelectedId: (id) {
              selectedTab.value = id;
            },
          ),
          Divider(height: 0.5, color: const Color(0xFF15171d)),
          SizedBox(height: 4),
          if (selectedTab.value == 'tickers')
            ChartOrderTickers(
              tradePair: tradePair,
            ),
          if (selectedTab.value == 'deals')
            ChartOrderDeals(
              tradePair: tradePair,
            ),
        ],
      ),
    );
  }
}
