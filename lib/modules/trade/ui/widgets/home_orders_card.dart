part of trade_ui_module;

class HomeOrdersCard extends StatelessWidget {
  const HomeOrdersCard({
    required this.hasWallet,
    required this.tradePair,
    required this.tradeSide,
    required this.onCancelOrder,
    Key? key,
  }) : super(key: key);

  final bool hasWallet;
  final TradePair tradePair;
  final TradeSide tradeSide;
  final Function(TradeOrder) onCancelOrder;

  @override
  Widget build(BuildContext context) {
    return CSContainer(
      margin: context.edgeAll.copyWith(top: 0),
      padding: context.edgeVertical.copyWith(top: 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: context.edgeAll,
                child: Text(
                  tr('trade:order_lbl_orders'),
                  style: context.textMedium(
                    bold: true,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Spacer(),
              if (hasWallet)
                CSButton(
                  label: tr('trade:order_btn_orders_all'),
                  flat: true,
                  padding: context.edgeAll,
                  textStyle: context.textSecondary(
                    color: context.labelColor,
                    bold: true,
                    fontWeight: FontWeight.normal,
                  ),
                  cmpRight: Padding(
                    padding: context.edgeLeft5,
                    child: Icon(
                      CSIcons.More,
                      size: 10,
                      color: context.bodyColor,
                    ),
                  ),
                  onPressed: () {
                    TradeOrderListPage.open();
                  },
                ),
            ],
          ),
          Divider(height: 0.5, color: context.greyColor),
          StreamBuilder<List<TradeOrder>>(
            //stream: GetIt.I<TradeOrdersPendingCubit>(),
            builder: (context, snapshot) {
              final data = snapshot.data;
              if (data == null) {
                return Center(
                  child: CSEmpty(isLoading: true),
                );
              }
              if (data.isEmpty) {
                return Center(
                  child: CSEmpty(
                    label: tr('trade:order_msg_order_list_empty'),
                    imageUrl: 'assets/images/empty_record.png',
                  ),
                );
              }
              return ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: data.length,
                separatorBuilder: (context, index) => Divider(
                  height: 0.5,
                  indent: context.edgeSize,
                  endIndent: context.edgeSize,
                  color: context.greyColor,
                ),
                itemBuilder: (context, index) => TradeOrderItem(
                  key: ValueKey(data[index].txId),
                  order: data[index],
                  margin: EdgeInsets.zero,
                  onPress: () {
                    TradeOrderDetailPage.open(data[index]);
                  },
                  onCancelOrder: (item) {
                    onCancelOrder(item);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
