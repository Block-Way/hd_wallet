part of asset_ui_module;

class AssetWalletCard extends HookWidget {
  const AssetWalletCard({
    this.walletCoins,
    required this.wallet,
    required this.walletStatus,
    required this.fiatCurrency,
    required this.onSync,
    required this.onPressed,
  }) : assert(wallet != null);

  final Wallet wallet;
  final walletCoins;
  final WalletStatus walletStatus;
  final String fiatCurrency;
  final void Function(Wallet) onSync;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return CSContainer(
      margin: EdgeInsets.zero,
      padding: context.edgeVertical5,
      // decoration: AssetBackgroundCircle(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CSContainer(
                  margin: context.edgeAll8,
                  padding: context.edgeAll8,
                  decoration: BoxDecoration(color: context.cardColor),
                  //width: null,
                  onTap: onPressed,
                  child: Column(
                    key: Key(wallet.id),
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            wallet.name,
                            style: context.textBody(bold: true),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(width: 4),
                          CSButtonIcon(
                            padding: EdgeInsets.only(
                              right: 1,
                              top: 1,
                            ),
                            containerSize: 14,
                            size: 6,
                            borderRadius: 14,
                            icon: CSIcons.ArrowDown,
                            disabled: true,
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        tr('asset:lbl_bbc_address', namedArgs: {
                          'address': wallet.ethAddress,
                        }),
                        maxLines: 2,
                        overflow: TextOverflow.fade,
                        style: context.textSmall(),
                      ),
                      SizedBox(height: 8),
                      SizedBox(
                        width: 80,
                        height: 32,
                        child: CSButton(
                          bordered: true,
                          borderColor: context.copyColor,
                          borderWidth: 1.0,
                          backgroundColor: Colors.transparent,
                          borderRadius: 40,
                          onPressed: () {
                            copyTextToClipboard(
                                walletCoins[0].address.toString());
                            Toast.show(tr('global:msg_copy_success'));
                          },
                          child: Text(
                            tr('global:btn_copy'),
                            style: TextStyle(
                                fontSize: 12, color: context.copyColor),
                          ),
                          // style: context.textSmall(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              CSButtonIcon(
                padding: context.edgeAll.copyWith(right: 0),
                background: Colors.transparent,
                icon: CSIcons.Settings,
                size: 22,
                onPressed: () {
                  WalletManagementPage.open();
                },
              ),
            ],
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Padding(
              //   padding: context.edgeHorizontal16,
              //   child: Text(
              //     tr('asset:list_lbl_valuation'),
              //     style: context.textBody(
              //       bold: true,
              //       color: context.iconColor,
              //     ),
              //   ),
              // ),
              // AssetWalletStatus(
              //   status: walletStatus,
              //   onPressed: () {
              //     onSync(wallet);
              //   },
              // ),
            ],
          ),
          // Padding(
          //   padding: context.edgeAll16.copyWith(top: 0),
          //   child: AssetPriceListener(
          //     symbol: 'HAH/USDT', // Update total when HAH price changes
          //     builder: (context, price, fiatCurrency, _) => PriceText(
          //       wallet.getTotalValuation(fiatCurrency),
          //       fiatCurrency,
          //       TextSize.huge,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
