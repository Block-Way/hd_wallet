part of hdkey_ui_module;

class HDKeyMnemonicImportPage extends HookWidget {
  static const routeName = '/hdkey/mnemonic/import';

  static void open() {
    AppNavigator.push(routeName);
  }

  static Route<dynamic> route(RouteSettings settings) {
    return DefaultTransition(
      settings,
      HDKeyMnemonicImportPage(),
    );
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final autovalidate = useState(false);
    // final walletType = useState(WalletType.mnemonicBip44);
    final mnemonic = useTextEditingController(text: '');

    void createWallet(HDKeyManagementVM viewModel) {
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
        // WalletCreatePage.open(mnemonic.text, walletType.value);
      }).catchError((_) {
        LoadingDialog.dismiss(context);
        Toast.show(tr('wallet:import_msg_error_mnemonic'));
      });
    }

    return CSScaffold(
      title: tr('填写助记词'),
      scrollable: true,
      child: Form(
        key: formKey,
        child: StoreConnector<AppState, HDKeyManagementVM>(
          converter: HDKeyManagementVM.fromStore,
          builder: (context, viewModel) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormBox(
                title: tr('wallet:设置备份名称'),
                type: FormBoxType.inputText,
                hintText: '请输入备份名称，限10字符',
              ),
              FormBox(
                title: tr('wallet:输入助记词'),
                controller: mnemonic,
                maxLines: 5,
                hintText: tr('wallet:请您将备份的助记词按原顺序输入或粘贴到此处，单词之间以空格分隔！'),
                validator: RequiredValidator(
                  errorText: tr('wallet:import_msg_mnemonic_empty'),
                ),
              ),
              SizedBox(height: context.edgeSizeDouble),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CSButton(
                    label: tr('wallet:提交'),
                    onPressed: () {
                      createWallet(viewModel);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
