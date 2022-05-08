part of asset_ui_module;

class AssetListItem extends HookWidget {
  const AssetListItem({
    @required this.item,
    @required this.onPressed,
  }) : assert(item != null);

  final AssetCoin item;
  final void Function() onPressed;

  // @override
  // void getWalletBalance() async {
  //   // var res = await AssetRepository().getCoinBalance(address: address.toString(), symbol: 'HAH');
  //   print('item $item');
  // }
  Widget build(BuildContext context) {
    return CSContainer(
      key: Key(item.id),
      secondary: true,
      margin: context.edgeAll.copyWith(bottom: 0),
      padding: context.edgeAll20,
      onTap: onPressed,
      child: Row(
        children: [
          CSImage(
            'assets/images/logo_hah.png', //item.iconUrl,
            fallbackUrl: item.iconLocal,
            height: 36,
            width: 36,
            radius: 36,
            bordered: true,
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.displayName,
                style: context.textBody(bold: true),
              ),
              SizedBox(height: 4),
              Text(
                item.displayFullName,
                style: context.textSecondary(),
              ),
            ],
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  if (item.balanceUpdateFailed == true)
                    Icon(
                      CSIcons.Mark,
                      color: context.redColor,
                      size: 13,
                      semanticLabel: tr('asset:lbl_balance_not_updated'),
                    ),
                  if (item.balanceUpdateFailed == true) SizedBox(width: 5),
                  AssetBalanceListener(
                    item: item,
                    builder: (context, {balance, unconfirmed, data}) =>
                        PriceText(
                      item.balance.toString(),
                      '',
                      TextSize.body,
                    ),
                  )
                ],
              ),
              SizedBox(height: 4),
              AssetBalanceListener(
                item: item,
                builder: (context, {balance, unconfirmed, data}) =>
                    AssetPriceListener(
                  symbol: item.symbol,
                  amount: NumberUtil.getDouble(balance),
                  builder: (context, price, fiatCurrency, _) => PriceText(
                    price,
                    fiatCurrency,
                    TextSize.small,
                    sameStyle: true,
                    approximate: true,
                    color: context.secondaryColor,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
