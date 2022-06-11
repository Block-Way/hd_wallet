part of invest_ui_module;

class MiningRewardItem extends StatelessWidget {
  const MiningRewardItem({
    required this.item,
    required this.mintItem,
    Key? key,
  }) : super(key: key);
  final ProfitRecordItem item;
  final MintItem mintItem;

  @override
  Widget build(BuildContext context) {
    final symbol = mintItem.symbol;
    return CSContainer(
      margin: context.edgeAll.copyWith(top: 0),
      decoration: BoxDecoration(color: context.cardColor),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr(
                      'invest:mining_record_lbl_reward',
                      namedArgs: {
                        'symbol': symbol,
                      },
                    ),
                    style: context.textBody(),
                  ),
                  SizedBox(height: context.edgeSizeHalf),
                  Text(
                    tr('invest:mining_record_lbl_block_height', namedArgs: {
                      'height': item.height.toString(),
                    }),
                    style: context.textSmall(),
                  )
                ],
              ),
              Spacer(),
              Text(
                item.totalReward,
                style: context.textMedium(
                  color: context.greenColor,
                  bold: true,
                ),
              ),
            ],
          ),
          CSContainer(
            margin: context.edgeTop,
            decoration: BoxDecoration(color: context.cardColor),
            secondary: true,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      tr('invest:mining_record_lbl_holding'),
                      style:
                          context.textSecondary(color: context.cardSecondColor),
                    ),
                    SizedBox(height: context.edgeSizeHalf),
                    Text(
                      item.stakeReward,
                      style: context.textSmall(color: context.cardSecondColor),
                    ),
                  ],
                ),
                Container(height: 20, width: 1, color: Color(0xFFedebe8)),
                Column(
                  children: [
                    Text(
                      tr('invest:mining_record_lbl_invitation'),
                      style:
                          context.textSecondary(color: context.cardSecondColor),
                    ),
                    SizedBox(height: context.edgeSizeHalf),
                    Text(
                      item.promotionReward,
                      style: context.textSmall(color: context.cardSecondColor),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
