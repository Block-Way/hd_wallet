part of asset_ui_module;

class AssetDepositPage extends HookWidget {
  AssetDepositPage(
    this.coinInfo, {
    Key key,
  }) : super(key: key);

  final AssetCoin coinInfo;

  static const routeName = '/asset/deposit';

  static void open(AssetCoin item) {
    AppNavigator.push(routeName, params: item);
  }

  static Route<dynamic> route(RouteSettings settings, [AssetCoin item]) {
    return DefaultTransition(
      settings,
      AssetDepositPage(item ?? settings.arguments as AssetCoin),
    );
  }

  final saveImageState = GlobalKey<ShareViewState>();

  void saveQRCodeView(BuildContext context) {
    LoadingDialog.show(context);
    saveImageState.currentState
        .capture()
        .whenComplete(() => LoadingDialog.dismiss(context));
  }

  @override
  Widget build(BuildContext context) {
    return CSScaffold(
      scrollable: true,
      title: tr('asset:deposit_title'),
      child: Stack(
        children: [
          buildSaveWidget(context),
          Container(
            width: context.mediaWidth,
            height: context.mediaHeight * 0.75,
            color: context.bgSecondaryColor,
          ),
          CSContainer(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CSContainer(
                  margin: EdgeInsets.zero,
                  secondary: true,
                  child: Column(
                    children: [
                      SizedBox(height: context.edgeSize),
                      Text(
                        tr('asset:lbl_coin_name', namedArgs: {
                          'name': coinInfo.name,
                          'fullName': coinInfo.fullName,
                        }),
                        style: context.textBody(bold: true),
                      ),
                      SizedBox(height: context.edgeSize),
                      Center(
                        child: CSContainer(
                          width: null,
                          child: QrCodeView(
                            coinInfo.address,
                            size: context.mediaWidth * 0.437,
                            padding: EdgeInsets.all(5),
                          ),
                        ),
                      ),
                      SizedBox(height: context.edgeSize),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            tr('asset:deposit_lbl_address'),
                            style: context.textSecondary(bold: true),
                          ),
                          CSButtonIcon(
                            size: 18,
                            borderRadius: 4,
                            padding: EdgeInsets.zero,
                            icon: CSIcons.Copy,
                            containerSize: 20,
                            margin: EdgeInsets.symmetric(horizontal: 2),
                            onPressed: () {
                              copyTextToClipboard(coinInfo.address);
                              Toast.show(tr('global:msg_copy_success'));
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: context.edgeSize),
                      Text(
                        coinInfo.address,
                        style: context.textSecondary(
                          bold: true,
                          color: context.bodyColor,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                CSButton(
                  label: tr('asset:deposit_btn_address_save'),
                  width: context.mediaWidth - 48,
                  onPressed: () {
                    saveQRCodeView(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSaveWidget(BuildContext context) {
    return ShareView(
      key: saveImageState,
      child: Container(
        padding: context.edgeAll20,
        color: context.whiteColor,
        width: context.mediaWidth * 0.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: context.edgeSize),
            Text(
              tr('asset:lbl_coin_name', namedArgs: {
                'name': coinInfo.name,
                'fullName': coinInfo.fullName,
              }),
              style: context.textMedium(bold: true),
            ),
            SizedBox(height: context.edgeSize),
            QrCodeView(
              coinInfo.address,
              size: context.mediaWidth * 0.5,
              padding: context.edgeAll5,
              backgroundColor: context.bgSecondaryColor,
              embeddedImage: AssetImage('assets/images/logo.png'),
              embeddedSize: context.mediaWidth * 0.5 * 0.1,
            ),
            SizedBox(height: context.edgeSize),
          ],
        ),
      ),
    );
  }
}
