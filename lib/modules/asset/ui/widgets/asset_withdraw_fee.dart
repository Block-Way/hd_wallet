part of asset_ui_module;

class AssetWithdrawFee extends StatelessWidget {
  const AssetWithdrawFee({
    required this.isRefreshing,
    this.withdrawInfo,
    this.onPress,
    Key? key,
    this.padding,
    this.onGetFee,
  }) : super(key: key);

  final WalletWithdrawData? withdrawInfo;
  final bool isRefreshing;
  final EdgeInsetsGeometry? padding;
  final Function(String type)? onPress;
  final Function()? onGetFee;

  void handleShowFeeDialog(
    BuildContext context, {
    ConfigCoinFee? configCoinFee,
    Function(String level)? onSelected,
  }) {
    DeviceUtils.hideKeyboard(context);
    final list = WalletFeeUtils.getFeeOptions(
      chain: withdrawInfo?.chain ?? '',
      defaultFee: withdrawInfo!.feeDefault,
      configCoinFee: configCoinFee!,
    );
    final feeChain = withdrawInfo?.chain.toLowerCase();
    final List<CSOptionsItem> options = list
        .map(
          (item) => CSOptionsItem(
            label: tr(
              'asset:withdraw_lbl_fee_${feeChain}_${item.key}',
              namedArgs: {
                'fuel': item.value.toString(),
                'unit': withdrawInfo?.fee.feeUnit ?? ''
              },
            ),
            value: item.key,
            color: withdrawInfo?.fee.feeLevel == item.key
                ? context.primaryColor
                : null,
          ),
        )
        .toList();

    showOptionsDialog(
      context,
      //options: options,
      onSelected: (level) {
        onSelected?.call(level.toString());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final configCoinFee = GetIt.I<CoinConfig>().getFeeLevel(
      chain: withdrawInfo?.chain ?? '',
      symbol: withdrawInfo?.symbol ?? '',
    );
    final showGasBtn = configCoinFee != null &&
        configCoinFee.enable != null &&
        configCoinFee.enable == true;

    final feeChain = withdrawInfo?.chain.toLowerCase();
    final feeLevel = withdrawInfo?.fee.feeLevel;
    final feeUnit = withdrawInfo?.fee.feeUnit;
    final feeSymbol = withdrawInfo?.fee.feeSymbol;
    final feeRate = withdrawInfo?.fee.feeRate;

    final gasLevel = tr(
      'asset:withdraw_lbl_fee_${feeChain}_$feeLevel',
      namedArgs: {
        'fuel': feeRate ?? '',
        'unit': feeUnit ?? '',
      },
    );

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: context.edgeAll.copyWith(bottom: 0),
              child: Text(
                tr('asset:trans_lbl_fee'),
                style: context.textBody(
                  bold: true,
                  color: Color(0xFFB9CEBD),
                ),
              ),
            ),
            if (withdrawInfo == null)
              CSButton(
                label: tr('asset:withdraw_btn_get_fee'),
                flat: true,
                margin: context.edgeHorizontal,
                textStyle: context.textSecondary().copyWith(
                      color: context.placeholderColor,
                      decoration: TextDecoration.underline,
                    ),
                onPressed: () {
                  onGetFee?.call();
                },
              ),
          ],
        ),
        CSContainer(
          padding: context.edgeAll.copyWith(top: 18, bottom: 18),
          height: 66,
          onTap: showGasBtn
              ? () {
                  handleShowFeeDialog(
                    context,
                    configCoinFee: configCoinFee,
                    onSelected: (level) {
                      onPress?.call(level);
                    },
                  );
                }
              : null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (isRefreshing == false)
                    Text(
                      withdrawInfo == null
                          ? '-'
                          : '${withdrawInfo?.displayFee}$feeSymbol',
                      style: context.textBody(),
                    ),
                  if (isRefreshing == true)
                    CSProgressIndicator(
                      size: context.edgeSize,
                      strokeWidth: 1.0,
                      backgroundColor: Colors.transparent,
                      color: context.blackColor,
                    ),
                ],
              ),
              Row(
                children: [
                  if (showGasBtn)
                    Text(
                      gasLevel,
                      style: context.textSecondary(),
                    ),
                  if (feeRate != '-' &&
                      feeUnit != '' &&
                      isRefreshing != true &&
                      !showGasBtn)
                    Text(
                      tr('asset:withdraw_lbl_fee_rate', namedArgs: {
                        'value': feeRate ?? '',
                        'symbol': feeUnit ?? '',
                      }),
                      style: context.textSecondary(),
                    ),
                  if (showGasBtn)
                    Padding(
                      padding: context.edgeLeft8,
                      child: Icon(
                        CSIcons.More,
                        size: 12,
                        color: context.bodyColor,
                      ),
                    ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
