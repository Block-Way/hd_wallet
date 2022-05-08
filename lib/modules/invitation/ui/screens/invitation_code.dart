part of invitation_ui_module;

class InvitationCodePage extends HookWidget {
  InvitationCodePage(this.inviteCode);
  final InvitationCode inviteCode;

  static const routeName = '/invitation/code';

  static void open(InvitationCode inviteCode) {
    AppNavigator.push(routeName, params: inviteCode);
  }

  static Route<dynamic> route(RouteSettings settings) {
    return DefaultTransition(
      settings,
      InvitationCodePage(settings.arguments as InvitationCode),
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
    final address = inviteCode.address;
    final subSign = inviteCode.subSign;
    final sharePrvKey = inviteCode.sharePrvKey;
    final coinName = useState('');

    final qrCodeStr = InvitationCodeUtils.encodeQRCodeData(
      chain: inviteCode.chain,
      symbol: inviteCode.symbol,
      address: address,
      subSign: subSign,
      sharePrvKey: sharePrvKey,
    );

    final copyLblAddress = tr(
      'invitation:code_copy_lbl_address',
      namedArgs: {'symbol': coinName.value, 'address': address},
    );

    final copyLblCode = tr(
      'invitation:code_copy_lbl_code',
      namedArgs: {'symbol': coinName.value, 'code': subSign},
    );

    final copyLblPrvkey = tr(
      'invitation:code_copy_lbl_prvkey',
      namedArgs: {'symbol': coinName.value, 'prvkey': sharePrvKey},
    );

    void copyAll() {
      final buff = StringBuffer();
      buff.write(copyLblAddress);
      buff.write('\n');
      buff.write(copyLblCode);
      buff.write('\n');
      buff.write(copyLblPrvkey);
      copyTextToClipboard(buff.toString());
      Toast.show(tr('global:msg_copy_success'));
    }

    final tipText = [
      tr('invitation:code_detail_tip1'),
      tr('invitation:code_detail_tip2'),
      tr('invitation:code_detail_tip3'),
    ];
    final tipTextColor = [context.redColor, context.redColor, context.redColor];

    //
    return CSScaffold(
      title: tr('invitation:code_detail_title'),
      scrollable: true,
      backgroundColor: context.bgSecondaryColor,
      child: StoreConnector<AppState, InvitationCreateVM>(
        converter: InvitationCreateVM.fromStore,
        onInitialBuild: (viewModel) {
          final coinInfo = viewModel.getCoinInfo(
            chain: inviteCode.chain,
            symbol: inviteCode.symbol,
          );
          coinName.value = coinInfo.name;
        },
        builder: (context, viewModel) {
          return Stack(
            alignment: AlignmentDirectional.center,
            children: [
              buildSaveWidget(context, qrCodeStr, coinName.value),
              CSContainer(
                padding: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CSContainer(
                      secondary: true,
                      child: Column(
                        children: [
                          Center(
                            child: CSContainer(
                              width: null,
                              child: QrCodeView(
                                qrCodeStr,
                                size: context.mediaWidth * 0.437,
                                padding: EdgeInsets.all(5),
                              ),
                            ),
                          ),
                          renderItem(
                            context,
                            title: tr('invitation:code_detail_address',
                                namedArgs: {'symbol': coinName.value}),
                            value: address,
                            copyLbl: copyLblAddress,
                          ),
                          Divider(height: 1, color: context.borderColor),
                          renderItem(
                            context,
                            title: tr('invitation:code_detail_invitation',
                                namedArgs: {'symbol': coinName.value}),
                            value: subSign,
                            copyLbl: copyLblCode,
                          ),
                          Divider(height: 1, color: context.borderColor),
                          renderItem(
                            context,
                            title: tr('invitation:defi_create_lbl_prvkey'),
                            value: sharePrvKey,
                            copyLbl: copyLblPrvkey,
                          ),
                        ],
                      ),
                    ),
                    ...tipText.asMap().keys.map<Widget>(
                      (index) {
                        return Padding(
                          padding: context.edgeAll.copyWith(top: 0),
                          child: Text(
                            tipText[index],
                            style: context.textSecondary(
                                color: tipTextColor[index]),
                          ),
                        );
                      },
                    ).toList(),
                    Padding(
                      padding: context.edgeAll.copyWith(top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Flexible(
                            child: CSButton(
                              label: tr('invitation:code_copy_btn_all'),
                              onPressed: () {
                                copyAll();
                              },
                              bordered: true,
                              backgroundColor: context.bgPrimaryColor,
                            ),
                          ),
                          SizedBox(width: context.edgeSize),
                          Flexible(
                            child: CSButton(
                              label: tr('invitation:code_detail_save_qrcode'),
                              onPressed: () {
                                saveQRCodeView(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget renderItem(
    BuildContext context, {
    String title,
    String value,
    String copyLbl,
  }) {
    return FormBox(
      margin: context.edgeVertical,
      title: title,
      titleStyle: context.textSecondary(bold: true),
      titleAction: CSButtonIcon(
        borderRadius: 4,
        icon: CSIcons.Copy,
        padding: EdgeInsets.all(0),
        containerSize: 20,
        size: 18,
        margin: EdgeInsets.symmetric(horizontal: 2),
        onPressed: () {
          copyTextToClipboard(copyLbl);
          Toast.show(tr('global:msg_copy_success'));
        },
      ),
      child: Text(
        value,
        style: context.textSecondary(
          bold: true,
          color: context.bodyColor,
        ),
      ),
    );
  }

  Widget buildSaveWidget(
    BuildContext context,
    String value,
    String coinName,
  ) {
    return ShareView(
      key: saveImageState,
      child: Container(
        padding: context.edgeAll20,
        color: context.whiteColor,
        width: context.mediaWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              tr('invitation:code_detail_invitation', namedArgs: {
                'symbol': coinName,
              }),
              style: context.textMedium(bold: true),
            ),
            SizedBox(height: context.edgeSize),
            QrCodeView(
              value,
              size: context.mediaWidth * 0.8,
              padding: context.edgeAll5,
              backgroundColor: context.bgSecondaryColor,
              embeddedImage: AssetImage('assets/images/logo.png'),
              embeddedSize: context.mediaWidth * 0.05,
              errorCorrectionLevel: QrErrorCorrectLevel.H, //纠错等级
            ),
            SizedBox(height: context.edgeSize),
          ],
        ),
      ),
    );
  }
}
