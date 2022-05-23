part of asset_ui_module;

class AssetTransactionPage extends HookWidget {
  const AssetTransactionPage(this.transactionInfo);

  final Transaction transactionInfo;

  static const routeName = '/asset/transaction/detail';

  static void open(Transaction item) {
    AppNavigator.push(routeName, params: item);
  }

  static Route<dynamic> route(RouteSettings settings) {
    return DefaultTransition(
      settings,
      AssetTransactionPage(settings.arguments as Transaction),
    );
  }

  @override
  Widget build(BuildContext context) {
    final copied = useState('');
    final infoState = useState(transactionInfo);
    final feeCoinName = useState(transactionInfo.feeSymbol);
    final amountCoinName = useState(transactionInfo.symbol);

    final info = infoState.value;
    final isFailed = info.isFailed;
    final isOutput = info.isOutput;
    final isConfirmed = info.isConfirmed;

    final color = info.amount == 0
        ? context.bodyColor
        : isFailed
            ? context.redColor
            : isConfirmed
                ? isOutput
                    ? context.redColor
                    : context.greenColor
                : context.orangeColor;

    final statusColor = isFailed
        ? context.redColor
        : isConfirmed
            ? context.secondaryColor
            : context.bodyColor;

    final statusIcon = isFailed
        ? CSIcons.Mark
        : isConfirmed
            ? CSIcons.Done
            : CSIcons.Time;

    final list = [
      {
        'canCopy': 'true',
        'title': tr('asset:trans_lbl_to_address'),
        'value': info.toAddress ?? '',
      },
      {
        'canCopy': 'true',
        'title': tr('asset:trans_lbl_from_address'),
        'value': info.fromAddress ?? '',
      },
      {
        'canCopy': 'true',
        'title': tr('asset:trans_lbl_txid'),
        'value': info.txId ?? '',
      },
      {
        'title': tr('asset:trans_lbl_confirmations'),
        'value': tr(info.confirmingTransKey),
      },
      {
        'title': tr('asset:trans_lbl_time'),
        'value': info.displayTime,
      },
      {
        'title': tr('asset:trans_lbl_fee'),
        'value': '${info.fee} ${feeCoinName.value}',
      },
    ];

    Widget buildTransactionHeader() {
      return Column(
        children: [
          SizedBox(height: 20),
          PriceText(
            info.displayAmountWithSign,
            amountCoinName.value,
            TextSize.huge,
            color: color,
          ),
          CSContainer(
            width: null,
            radius: 24.5,
            secondary: true,
            margin: context.edgeVertical,
            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 14),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: context.edgeRight5,
                  child: Icon(
                    statusIcon,
                    size: 12,
                    color: statusColor,
                  ),
                ),
                Text(
                  tr(info.statusTransKey),
                  style: context.textSmall(
                    color: statusColor,
                    bold: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    Widget buildTransactionDetailItem(Map<String, String> item) {
      return CSContainer(
        margin: context.edgeTop,
        secondary: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  item['title'] ?? '',
                  style: context.textSecondary(bold: true),
                ),
                Spacer(),
                if (item['canCopy'] == 'true')
                  CSButtonIcon(
                    size: 18,
                    borderRadius: 4,
                    icon: CSIcons.Copy,
                    padding: EdgeInsets.all(0),
                    containerSize: 20,
                    margin: EdgeInsets.symmetric(horizontal: 2),
                    onPressed: () {
                      copied.value = item['value'];
                      copyTextToClipboard(item['value']);
                      Toast.show(tr('global:msg_copy_success'));
                    },
                  ),
              ],
            ),
            SizedBox(height: context.edgeSize),
            Text(
              item['value'] ?? '',
              style: context.textSecondary(
                bold: true,
                color: context.bodyColor,
              ),
            ),
          ],
        ),
      );
    }

    return CSScaffold(
      title: tr('asset:trans_title'),
      scrollable: true,
      backgroundColor: context.bgSecondaryColor,
      headerBgColor: context.bgSecondaryColor,
      child: StoreConnector<AppState, AssetTransactionVM>(
        distinct: true,
        converter: AssetTransactionVM.fromStore,
        onInitialBuild: (viewModel) {
          amountCoinName.value = viewModel.getCoinName(info.chain, info.symbol);
          feeCoinName.value = viewModel.getCoinName(info.chain, info.feeSymbol);
          if (info.isConfirming || info.isExpired) {
            LoadingDialog.show(context);
            viewModel.getSingleTransaction(info).then((result) {
              LoadingDialog.dismiss(context);
              infoState.value = result ?? transactionInfo;
            }).catchError((error) {
              LoadingDialog.dismiss(context);
              Toast.showError(error);
            });
          }
        },
        builder: (context, viewModel) => CSContainer(
          child: Column(
            children: [
              buildTransactionHeader(),
              ...list.map((e) => buildTransactionDetailItem(e)).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
