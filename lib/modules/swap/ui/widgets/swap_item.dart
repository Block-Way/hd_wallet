part of swap_ui_module;

class SwapItem extends StatelessWidget {
  const SwapItem({
    this.item,
    this.onPress,
  });

  final Swap item;
  final void Function(Swap) onPress;

  Widget buildCoinItem(
    BuildContext context,
    String coin,
    String amount,
    Color color,
  ) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            coin,
            style: context.textSmall(),
          ),
          Padding(
            padding: context.edgeTop10,
            child: Text(
              amount,
              style: context.textSecondary(
                color: color,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: Key('${item.txId}${item.createdAt}'),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        decoration: ThemeBorders.borderBottom,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  tr('swap:list_lbl_asset_mapping'),
                  style: context.textBody(
                    bold: true,
                  ),
                ),
                Text(
                  tr(item.statusTransKey),
                  style: context.textSecondary(
                    color: item.isFailed
                        ? context.redColor
                        : item.status == SwapStatus.pending
                            ? context.primaryColor
                            : item.status == SwapStatus.confirming
                                ? context.greenColor
                                : context.secondaryColor,
                  ),
                ),
              ],
            ),
            Padding(
              padding: context.edgeTop10,
              child: Text(
                item.displayTime,
                style: context.textSecondary(
                  color: context.placeholderColor,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildCoinItem(
                  context,
                  '${item.outSymbol}(${item.outChain})',
                  '- ${item.displayOutAmount}',
                  context.redColor,
                ),
                buildCoinItem(
                  context,
                  '${item.inSymbol}(${item.inChain})',
                  '+ ${item.displayInAmount}',
                  context.greenColor,
                ),
                buildCoinItem(
                  context,
                  tr('swap:list_actual_amount'),
                  '+ ${item.displayActualAmount}',
                  context.greenColor,
                ),
              ],
            ),
            if (item.status == SwapStatus.noTxid)
              SizedBox(height: context.edgeSize),
            if (item.status == SwapStatus.noTxid)
              CSButton(
                onPressed: () {
                  onPress(item);
                },
                label: tr('swap:swap_btn_resubmit'),
                borderRadius: context.edgeSize,
                width: context.mediaWidth - context.edgeSizeDouble,
                height: 40,
                margin: EdgeInsets.zero,
                textColor: context.primaryColor,
                backgroundColor: context.primaryColor.withOpacity(0.05),
              )
          ],
        ),
      ),
    );
  }
}
