part of asset_ui_module;

class AssetDposList extends StatefulWidget {
  const AssetDposList(
    this.coinInfo, {
    Key key,
  }) : super(key: key);

  final AssetCoin coinInfo;

  static const routeName = '/asset/dpos/list';

  static void open(AssetCoin item) {
    AppNavigator.push(routeName, params: item);
  }

  static Route<dynamic> route(RouteSettings settings, [AssetCoin item]) {
    return DefaultTransition(
      settings,
      AssetDposList(item ?? settings.arguments as AssetCoin),
    );
  }

  @override
  State<StatefulWidget> createState() {
    return _AssetDposList();
  }
}

class _AssetDposList extends State<AssetDposList> {
  var voteNodeList = []; // node list
  void checkIfWalletHasBackup(BuildContext context, AssetDetailVM viewModel) {
    if (!viewModel.activeWallet.hasBackup && !kDebugMode) {
      showConfirmDialog(
        context,
        content: tr('asset:detail_msg_backup'),
        title: tr('global:dialog_alert_title'),
        cancelBtnText: tr('global:btn_next_time'),
        confirmBtnText: tr('asset:detail_btn_backup'),
        onConfirm: () {
          // showPasswordDialog(
          //   context,
          //       (password) => viewModel.doUnlockWallet(password),
          //       (data, _) {
          //     WalletBackupPage.open(data.mnemonic);
          //   },
          // );
        },
      );
    }
  }

  Widget buildHeader(BuildContext context) {
    return CSContainer(
      child: CSContainer(
        secondary: true,
        margin: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text(
              tr('asset:detail_lbl_total', namedArgs: {
                'name': widget.coinInfo.name,
                'fullName': widget.coinInfo.fullName,
              }),
              style: context.textSecondary(),
            ),
            SizedBox(height: 10),
            AssetBalanceListener(
              item: widget.coinInfo,
              builder: (context, {balance, unconfirmed, data}) => PriceText(
                balance,
                '',
                TextSize.big,
              ),
            ),
            SizedBox(height: 15),
            Row(
              children: [
                AssetBalanceListener(
                  item: widget.coinInfo,
                  builder: (
                    context, {
                    balance,
                    unconfirmed,
                    data,
                  }) =>
                      AssetPriceListener(
                    symbol: widget.coinInfo.symbol,
                    amount: double.tryParse(balance) ?? 0,
                    builder: (context, price, fiatCurrency, _) => Expanded(
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        // children: [
                        //   Text(
                        //     tr(
                        //       'asset:detail_lbl_valuation',
                        //       namedArgs: {'symbol': fiatCurrency},
                        //     ),
                        //     style: context.textSecondary(),
                        //   ),
                        //   SizedBox(height: 10),
                        //   PriceText(
                        //     price,
                        //     '',
                        //     TextSize.medium,
                        //   ),
                        // ],
                      ),
                    ),
                  ),
                ),
                if (kChainsHasUnconfirmedBalance
                    .contains(widget.coinInfo.chain))
                  AssetBalanceListener(
                    item: widget.coinInfo,
                    builder: (
                      context, {
                      balance,
                      unconfirmed,
                      data,
                    }) =>
                        data.unconfirmed > 0
                            ? Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CSButton(
                                      flat: true,
                                      label: tr('asset:detail_lbl_unconfirmed'),
                                      textStyle: context.textSecondary(),
                                      alignment: MainAxisAlignment.start,
                                      cmpRight: Padding(
                                        padding: context.edgeLeft5,
                                        child: Icon(
                                          CSIcons.Help,
                                          size: 15,
                                          color: context.bodyColor,
                                        ),
                                      ),
                                      onPressed: () {
                                        showAlertDialog(
                                          context,
                                          content: tr(
                                            'asset:detail_msg_unconfirmed',
                                          ),
                                        );
                                      },
                                    ),
                                    SizedBox(height: 10),
                                    PriceText(
                                      unconfirmed,
                                      '',
                                      TextSize.medium,
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox(),
                  ),
              ],
            ),
            SizedBox(height: 4),
          ],
        ),
      ),
    );
  }

  Widget buildTransactionTitle(BuildContext context) {
    return Padding(
      padding: context.edgeBottom5.copyWith(left: 4),
      child: Text(
        tr('asset:dpos_node_infor'),
        style: context.textMedium(bold: true, color: context.placeholderColor),
      ),
    );
  }

  @override
  void initState() {
    AssetRepository().getVoteNode().then((res) => {
          setState(() {
            voteNodeList = res;
          }),
        });
  }

  @override
  void onChanged() {
    initState();
  }

  @override
  Widget build(BuildContext context) {
    return CSScaffold(
      headerBgColor: context.mainColor,
      backgroundColor: context.mainColor,
      addBottomInset: false,
      title: tr('asset:node_vote_infor'),
      child: StoreConnector<AppState, AssetDetailVM>(
        distinct: true,
        converter: AssetDetailVM.fromStore,
        onInitialBuild: (viewModel) {
          checkIfWalletHasBackup(context, viewModel);
//          request.add(CSListViewParams.withParams(_GetAssetListParams()));
        },
        builder: (context, viewModel) => Column(children: [
          Expanded(
              child: CSListViewStream<_GetAssetListParams>(
            margin: context.edgeHorizontal,
            padding: context.edgeAll,
            // decoration: context.boxDecorationOnlyTop(),
                decoration: new BoxDecoration(
                  color: context.cardColor,
                  borderRadius: BorderRadius.all(Radius.circular(context.edgeSize)),
                ),
            slivers: [
              SliverToBoxAdapter(child: buildHeader(context)),
            ],
            itemHeader: buildTransactionTitle(context),
            itemCount: voteNodeList.length,
            itemBuilder: (context, index) => TransDropItem(
                item: voteNodeList[index],
                coinInfo: widget.coinInfo,
                onChanged: onChanged),
            emptyLabel: tr('asset:detail_msg_empty'),
            emptyImageUrl: 'assets/images/empty_record.png',
          ))
        ]),
      ),
    );
  }
}
