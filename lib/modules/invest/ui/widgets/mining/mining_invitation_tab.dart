part of invest_ui_module;

class MiningInvitationTab extends HookWidget {
  const MiningInvitationTab({
    required this.listData,
    required this.doLoadData,
    required this.coinInfo,
    Key? key,
  }) : super(key: key);

  final AssetCoin coinInfo;
  final List<ProfitInvitationItem> listData;
  final Future<int> Function({
    required bool isRefresh,
    required int skip,
    required int take,
  }) doLoadData;

  @override
  Widget build(BuildContext context) {
    final request = useBehaviorStreamController<CSListViewParams>();

    useEffect(() {
      request.add(CSListViewParams());
      return null;
    }, []);

    return Expanded(
      child: CSListViewStream(
        requestStream: request,
        decoration: context.boxDecorationOnlyBottom(),
        margin: context.edgeAll.copyWith(top: 0),
        padding: context.edgeAll,
        onLoadData: (params) {
          return doLoadData(
            isRefresh: params.isRefresh,
            skip: params.skip,
            take: 10,
          );
        },
        itemCount: listData.length,
        itemBuilder: (context, index) {
          return buildItem(context, listData[index], index);
        },
        emptyWidget: CSEmpty(
            //label: tr('invitation:list_empty_tips'),
            //showButton: true,
            //heightFromTop: 30,
            //imageUrl: 'assets/images/empty_record.png',
            //btnText: tr('invitation:defi_create_title'),
            //onPressed: () {
            //  InvitationCreatePage.open(coinInfo);
            //},
            ),
      ),
    );
  }

  Widget buildItem(BuildContext context, ProfitInvitationItem item, int index) {
    return SizedBox(
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (index != 0) Divider(color: context.greyColor),
          SizedBox(height: context.edgeSize),
          // Text('金额 : ${item.amount} HAH', style: context.textBody()),
          Text(
              tr(
                'invest:reward_amount',
                namedArgs: {
                  'amount': item.amount,
                },
              ),
              style: context.textBody()),
          // SizedBox(height: context.edgeSizeHalf),
          // Text(
          //   '高度 : ${item.height} . 时间 : ${item.time}',
          //   style: context.textSmall(),
          // ),
          Text(tr('invest:reward_height', namedArgs: {
            'height': item.height!,
          })),
          Text(tr('invest:reward_time', namedArgs: {
            'time': item.time!,
          })),
        ],
      ),
    );
  }
}
