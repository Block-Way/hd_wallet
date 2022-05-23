part of asset_ui_module;

class TransactionListItem extends StatelessWidget {
  const TransactionListItem({
    Key key,
    this.item,
  }) : super(key: key);

  final Transaction item;

  @override
  Widget build(BuildContext context) {
    final isFailed = item.isFailed;
    final isOutput = item.isOutput;
    final isConfirmed = item.isConfirmed;

    final priceColor = item.amount == 0
        ? context.bodyColor
        : isFailed
            ? context.redColor
            : isConfirmed
                ? isOutput
                    ? context.redColor
                    : context.greenColor
                : context.orangeColor;

    Color statusColor() {
      if (isFailed) {
        return context.redColor; // 失败
      }
      if (isConfirmed) {
        return context.secondaryColor; //已完成
      }
      return context.bodyColor; //确认中
    }

    return CSContainer(
      secondary: true,
      margin: context.edgeTop,
      padding: EdgeInsets.symmetric(
        vertical: 16,
        horizontal: context.edgeSize,
      ),
      onTap: () => AssetTransactionPage.open(item),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
//                  标题
                  Text(
                    tr(item.typeTransKey),
                    style: context.textMedium(bold: true),
                  ),
                  SizedBox(height: 10),
                  Text(
                    item.displayTime,
                    style: context.textSmall(),
                  ),
                ],
              ),
              PriceText(
                item.displayAmountWithSign,
                item.symbol,
                TextSize.body,
                color: priceColor,
              ),
            ],
          ),
          SizedBox(height: 15),
          Container(
            padding: EdgeInsets.all(6),
            decoration: context.boxDecoration(
              radius: 4,
              color: Color.fromRGBO(0, 0, 0, 0.02),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CSButton(
                  label: tr('asset:trans_lbl_txid_copy', namedArgs: {
                    'txId': StringUtils.strCut(
                      item.txId,
                      startKeep: 6,
                      endKeep: 5,
                    ),
                  }),
                  flat: true,
                  onPressed: () {
                    copyTextToClipboard(item.txId);
                    Toast.show(tr('global:msg_copy_success'));
                  },
                  textStyle: context.textSmall(color: context.bodyColor),
                  cmpRight: CSButtonIcon(
                    borderRadius: 4,
                    icon: CSIcons.Copy,
                    padding: EdgeInsets.zero,
                    containerSize: 16,
                    margin: EdgeInsets.symmetric(horizontal: 2),
                    disabled: true,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (item.isExpired)
                      Padding(
                        padding: context.edgeRight5,
                        child: Icon(
                          CSIcons.Mark,
                          color: context.redColor,
                          size: 10,
                        ),
                      ),
                    Text(
                      tr(item.confirmingTransKey),
                      style: context.textSmall(color: statusColor()),
                      maxLines: 1,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
