part of wallet_ui_module;

enum _ExportStep { tip, show }

class WalletExportPage extends HookWidget {
  const WalletExportPage(this.privateKey);
  final String privateKey;

  static const routeName = '/wallet/export';

  static void open(dynamic privateKey) {
    AppNavigator.push(routeName, params: privateKey);
  }

  static Route<dynamic> route(RouteSettings settings) {
    final data = settings.arguments as String;
    return DefaultTransition(settings, WalletExportPage(data));
  }

  void goBack() {
    AppNavigator.goBack();
  }

  @override
  Widget build(BuildContext context) {
    final step = useState<_ExportStep>(_ExportStep.tip);
    final viewBuild = step.value == _ExportStep.tip ? tipView : mnemonicView;

    return WillPopScope(
      onWillPop: () {
        if (step.value == _ExportStep.tip) {
          goBack();
        } else if (step.value == _ExportStep.show) {
          step.value = _ExportStep.tip;
        }
        return Future.value(false);
      },
      child: CSScaffold(
        title: tr('wallet:export_privatekey_title'),
        child: SizedBox(
          width: double.infinity,
          child: viewBuild(context, step),
        ),
      ),
    );
  }

  Widget tipView(BuildContext context, ValueNotifier<_ExportStep> step) {
    final tips = [
      tr('wallet:export_privatekey_tip1'),
      tr('wallet:export_privatekey_tip2'),
      tr('wallet:export_privatekey_tip3'),
    ];

    return Column(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            padding: context.edgeHorizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tr('wallet:export_privatekey_tip_lbl'),
                  style: context.textBody(bold: true),
                ),
                SizedBox(height: context.edgeSize),
                ...tips
                    .map<Widget>(
                      (e) => Padding(
                        padding: context.edgeBottom10,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: context.edgeTop10,
                              child: Container(
                                width: 4,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: context.blackColor,
                                  borderRadius: context.radiusAll5,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(e, style: context.textBody()),
                            )
                          ],
                        ),
                      ),
                    )
                    .toList()
              ],
            ),
          ),
        ),
        CSButton(
          label: tr('wallet:export_privatekey_bt_export'),
          textColor: context.whiteColor,
          onPressed: () {
            step.value = _ExportStep.show;
          },
          margin: context.edgeVertical,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CSButton(
              label: tr('wallet:export_privatekey_bt_cancel'),
              flat: true,
              onPressed: goBack,
              margin: EdgeInsets.only(bottom: 40),
            )
          ],
        )
      ],
    );
  }

  Widget mnemonicView(BuildContext context, ValueNotifier<_ExportStep> step) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: context.edgeHorizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr('wallet:export_privatekey_tip4'),
                    style: context.textBody(bold: true),
                  ),
                  SizedBox(height: 10),
                  Text(
                    tr('wallet:export_privatekey_tip5'),
                    style: context.textSecondary(),
                  ),
                  SizedBox(height: context.edgeSize),
                  // ...data.getChains().map((e) => CSButton(
                  //       label: e,
                  //     )),
                  Container(
                    margin: context.edgeVertical,
                    decoration: BoxDecoration(
                      borderRadius: context.radiusAll,
                      color: context.bgSecondaryColor,
                    ),
                    child: Padding(
                      padding: context.edgeAll,
                      child: Text(
                        '' ?? '',
                        style: context.textBody(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: context.edgeVertical,
                    child: Text(
                      tr('wallet:global:lbl_attention'),
                      style: context.textBody(bold: true),
                    ),
                  ),
                  Padding(
                    padding: context.edgeHorizontal,
                    child: MnemonicBackupImgTip(
                      width: context.mediaWidth - context.edgeSizeDouble * 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        CSButton(
          label: tr('global:btn_finish'),
          textColor: context.whiteColor,
          onPressed: goBack,
          margin: context.edgeVertical,
        )
      ],
    );
  }
}
