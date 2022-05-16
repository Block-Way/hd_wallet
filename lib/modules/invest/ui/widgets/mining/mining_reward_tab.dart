part of invest_ui_module;

class MiningRewardTab extends HookWidget {
  const MiningRewardTab({
    @required this.mintInfo,
    @required this.symbol,
    @required this.mintItem,
    @required this.coinInfo,
    @required this.chartList,
    @required this.doRefresh,
    Key key,
  }) : super(key: key);

  final MintInfo mintInfo;
  final String symbol;
  final MintItem mintItem;
  final AssetCoin coinInfo;
  final List<MintChart> chartList;
  final Future<void> Function() doRefresh;

  @override
  Widget build(BuildContext context) {
    final refreshController = useMemoized(() => CSRefresherController());

    final notStart =
        NumberUtil.getDouble(mintInfo.bestBalanceReward ?? '0') <= 0;
    const noBalance = false;
    //coinInfo.balance < NumberUtil.getDouble(mintItem.minBalance ?? '0');
    // no start
    if (notStart || noBalance) {
      return Expanded(
        child: CSContainer(
          decoration: context.boxDecorationOnlyBottom(),
          margin: context.edgeAll.copyWith(top: 0),
          child: CSEmpty(
            label: notStart
                ? '挖矿暂未开启，敬请期待'
                : tr('未达到最低持币额度${mintItem.minBalance} $symbol'),
            showButton: !notStart && noBalance,
            heightFromTop: 30,
            imageUrl: 'assets/images/airdrop_empty_bg.png',
            btnText: tr('asset:lbl_deposit'),
            onPressed: () {
              AssetDepositPage.open(coinInfo);
            },
          ),
        ),
      );
    }

    return Expanded(
      child: CSRefresher(
        controller: refreshController,
        onRefresh: () {
          doRefresh().then((_) {
            refreshController.refreshCompleted();
          }).catchError((_) {
            refreshController.refreshFailed();
          });
        },
        header: ListViewHeader(),
        child: SingleChildScrollView(
          child: Container(
            decoration: context.boxDecorationOnlyBottom(color: context.cardColor),
            margin: context.edgeAll.copyWith(top: 0),
            padding: context.edgeAll,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...buildItem(
                  context,
                  // 'invest:reward_maximum_benefit ($symbol)',
                  tr('invest:reward_maximum_benefit', namedArgs: {
                    'symbol': symbol
                  }),
                  mintInfo.bestBalance ?? '-',
                ),
                ...buildItem(
                  context,
                  tr('invest:reward_minimum_benefit', namedArgs: {
                    'symbol': symbol
                  }),
                  mintInfo.bestBalanceReward ?? '-',
                ),
                Center(
                  child: Text(
                    tr('invest:reward_yield_curve'),
                    style: context.textSmall(),
                  ),
                ),
                Container(
                  height: 230,
                  margin: context.edgeTop8,
                  width: context.mediaWidth - context.edgeSizeDouble,
                  child: MiningRewardChart(chartList),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildItem(BuildContext context, String title, String value) {
    return [
      SizedBox(height: context.edgeSizeHalf),
      Text(title, style: context.textSmall()),
      SizedBox(height: context.edgeSizeHalf),
      Text(value, style: context.textMedium(bold: true, color: context.iconColor)),
      SizedBox(height: context.edgeSize),
      Divider(height: 0.2, color: context.greyColor),
      SizedBox(height: context.edgeSizeHalf),
    ];
  }
}
