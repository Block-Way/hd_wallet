part of wallet_ui_module;

class WalletCreatePage extends HookWidget {
  WalletCreatePage(
    this.importMnemonic,
    this.type,
  );
  final String importMnemonic;
  final WalletType type;

  static const routeName = '/wallet/create';

  static void open([String importMnemonic = '', WalletType type]) {
    AppNavigator.push(
      routeName,
      params: {'importMnemonic': importMnemonic, 'type': type},
    );
  }

  static Route<dynamic> route(RouteSettings settings) {
    final map =
        settings != null ? settings.arguments as Map<String, dynamic> : null;
    final importMnemonic = map['importMnemonic'] as String;
    final type = map['type'] as WalletType;
    return DefaultTransition(
      settings,
      WalletCreatePage(
        importMnemonic ?? '',
        type ?? WalletType.mnemonicBip44,
      ),
    );
  }

  final formKey = GlobalKey<FormState>();

  void doCreateWallet({
    @required BuildContext context,
    @required WalletManagementVM viewModel,
    @required ValueNotifier<bool> autovalidate,
    @required TextEditingController fieldName,
    @required TextEditingController fieldPwd1,
  }) {
    final isValid = formKey.currentState.validate();

    if (!autovalidate.value) {
      autovalidate.value = true;
    }

    if (!isValid) {
      return;
    }

    formKey.currentState.save();
    LoadingDialog.show(context);
    viewModel
        .createWallet(
      fieldName.text,
      fieldPwd1.text,
      importMnemonic,
      type,
    )
        .then((mnemonic) {
      LoadingDialog.dismiss(context);
      if (importMnemonic.isEmpty) {
        WalletBackupPage.open(mnemonic);
      } else {
        AppNavigator.gotoTabBar();
      }
      Toast.show(
        importMnemonic.isEmpty
            ? tr('wallet:create_msg_success')
            : tr('wallet:import_msg_success'),
      );
      AnalyticsReport().reportLog('Wallet_Create', {
        'name': fieldName.text,
        'type': type.toString(),
        'isImport': importMnemonic.isNotEmpty,
      });
    }).catchError((error) {
      LoadingDialog.dismiss(context);
      Toast.showError(error, defaultMessage: tr('wallet:create_msg_error'));
    });
  }

  @override
  Widget build(BuildContext context) {
    final autovalidate = useState(false);
    final fieldName = useTextEditingController(text: '');
    final fieldPwd1 = useTextEditingController(text: '');
    final fieldPwd2 = useTextEditingController(text: '');

    return CSScaffold(
      title: importMnemonic.isEmpty
          ? tr('wallet:create_title')
          : tr('wallet:import_title'),
      scrollable: true,
      child: Form(
        key: formKey,
        autovalidateMode: autovalidate.value
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        child: StoreConnector<AppState, WalletManagementVM>(
          converter: WalletManagementVM.fromStore,
          builder: (context, viewModel) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormBox(
                showCounterText: true,
                maxLengthChineseDouble: true,
                maxLength: kWalletNameMaxLength,
                type: FormBoxType.inputText,
                title: tr('wallet:create_input_name_lbl'),
                validator: RequiredValidator(
                  errorText: tr('wallet:create_input_name_error'),
                ),
                controller: fieldName,
                hintText: tr('wallet:create_input_name_hint'),
              ),
              FormBoxPassword(
                title: tr('wallet:create_pwd_input1_lbl'),
                controller: fieldPwd1,
                hintText: tr('wallet:pwd_input1_hint'),
                validator: MultiValidator(
                  [
                    RequiredValidator(
                      errorText: tr('wallet:create_msg_error_pwd_empty'),
                    ),
                    WalletPasswordValidator(
                      errorText: tr('wallet:create_msg_error_pwd_rule'),
                    ),
                  ],
                ),
              ),
              FormBoxPassword(
                title: tr('wallet:create_pwd_input2_lbl'),
                controller: fieldPwd2,
                hintText: tr('wallet:create_pwd_input2_hint'),
                validator: MultiValidator(
                  [
                    RequiredValidator(
                      errorText: tr('wallet:create_msg_error_pwd_empty'),
                    ),
                    WalletPasswordValidator(
                      errorText: tr('wallet:create_msg_error_pwd_rule'),
                    ),
                    AccountPasswordAgainValidator(
                      errorText: tr('wallet:create_msg_error_pwd_diff'),
                      fieldPwd: fieldPwd1,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              Align(
                child: ButtonDisableListener(
                  listenValues: [fieldName, fieldPwd1, fieldPwd2],
                  builder: (disabled) {
                    return CSButton(
                      disabled: disabled,
                      label: importMnemonic.isEmpty
                          ? tr('wallet:create_btn_submit')
                          : tr('wallet:import_btn_submit'),
                      onPressed: () {
                        doCreateWallet(
                          context: context,
                          viewModel: viewModel,
                          autovalidate: autovalidate,
                          fieldName: fieldName,
                          fieldPwd1: fieldPwd1,
                        );
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
