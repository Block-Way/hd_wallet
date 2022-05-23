part of invest_ui_module;

class MiningHeader extends StatelessWidget {
  const MiningHeader({
    @required this.mintInfo,
    @required this.symbol,
    Key key,
  }) : super(key: key);

  final MintInfo mintInfo;
  final String symbol;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.edgeAll,
      height: 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            tr('invest:mining_lbl_header'),
            style: context.textSmall(color: context.bodyColor),
          ),
          SizedBox(height: 6),
          PriceText(
            mintInfo?.totalProfit?.toString() ?? '-',
            symbol,
            TextSize.big,
            color: context.redColor,
          ),
        ],
      ),
    );
  }
}
