part of wallet_ui_module;

class WalletImportPage extends HookWidget {
  static const routeName = '/wallet/import';

  static void open() {
    AppNavigator.push(routeName);
  }

  static Route<dynamic> route(RouteSettings settings) {
    return DefaultTransition(settings, WalletImportPage());
  }

  final formKey = GlobalKey<FormState>();

  void doImportWallet(
    BuildContext context,
    WalletManagementVM viewModel,
    ValueNotifier<bool> autovalidate,
    WalletType walletType,
    TextEditingController mnemonic,
  ) {
    final isValid = formKey.currentState.validate();

    if (!autovalidate.value) {
      autovalidate.value = true;
    }

    if (!isValid) {
      return;
    }

    formKey.currentState.save();
    LoadingDialog.show(context);
    viewModel.validateMnemonic(mnemonic.text).then((_) {
      LoadingDialog.dismiss(context);
      WalletCreatePage.open(mnemonic.text, walletType);
    }).catchError((_) {
      LoadingDialog.dismiss(context);
      Toast.show(tr('wallet:import_msg_error_mnemonic'));
    });
  }

  @override
  Widget build(BuildContext context) {
    final autovalidate = useState(false);
    final walletType = useState(WalletPathUtils.pathConfigs.first);
    final mnemonic = useTextEditingController(text: '');

    return CSScaffold(
      title: tr('wallet:import_title'),
      scrollable: true,
      child: Form(
        key: formKey,
        child: StoreConnector<AppState, WalletManagementVM>(
          converter: WalletManagementVM.fromStore,
          builder: (context, viewModel) => Column(
            children: [
              FormBox(
                type: FormBoxType.child,
                title: tr('wallet:import_lbl_path'),
                child: CSContainer(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  child: FormCell(
                    label: walletType.value.transKey != null
                        ? tr(walletType.value.transKey)
                        : walletType.value.name,
                    cmpLeft: Padding(
                      padding: context.edgeRight8,
                      child: CSImage(
                        walletType.value.logo,
                        width: 30,
                        height: 30,
                        radius: 30,
                        fit: BoxFit.contain,
                      ),
                    ),
                    padding: context.edgeHorizontal,
                    onPress: () {
                      WalletPathSelectPage.open().then((item) {
                        if (item != null) {
                          AnalyticsReport().reportLog('Wallet_Import_Path', {
                            'name': item.name,
                          });
                          walletType.value = item;
                        }
                      });
                    },
                  ),
                ),
              ),
              FormBox(
                title: tr('wallet:import_lbl_mnemonic'),
                type: FormBoxType.inputText,
                maxLines: 5,
                controller: mnemonic,
                hintText: tr('wallet:import_hint_mnemonic'),
                validator: RequiredValidator(
                  errorText: tr('wallet:import_msg_mnemonic_empty'),
                ),
                inputTextStyle: context.textBody(lineHeight: 1.6),
              ),
              SizedBox(height: 50),
              ButtonDisableListener(
                listenValues: [mnemonic],
                builder: (disabled) {
                  return CSButton(
                    disabled: disabled,
                    label: tr('wallet:backup_btn_next'),
                    onPressed: () {
                      doImportWallet(
                        context,
                        viewModel,
                        autovalidate,
                        walletType.value.path,
                        mnemonic,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
