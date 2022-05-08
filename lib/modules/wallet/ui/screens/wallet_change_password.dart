part of wallet_ui_module;

class WalletChangePasswordPage extends HookWidget {
  WalletChangePasswordPage(this.oldPassword);
  final String oldPassword;

  static const routeName = '/wallet/change/password';

  static void open(String oldPassword) {
    AppNavigator.push(routeName, params: oldPassword);
  }

  static Route<dynamic> route(RouteSettings settings) {
    final oldPassword = settings.arguments as String;
    return DefaultTransition(settings, WalletChangePasswordPage(oldPassword));
  }

  final formKey = GlobalKey<FormState>();

  void handleSubmit(
    WalletManagementVM viewModel,
    ValueNotifier<bool> autovalidate,
    TextEditingController newPassword1,
  ) {
    final isValid = formKey.currentState.validate();

    if (!autovalidate.value) {
      autovalidate.value = true;
    }

    if (!isValid) {
      return;
    }

    formKey.currentState.save();
    viewModel.changePassword(oldPassword, newPassword1.text).then((_) {
      AppNavigator.goBack();
      Toast.show(tr('wallet:change_pwd_msg_success'));
    }).catchError((_) {
      Toast.show(tr('wallet:change_pwd_msg_error'));
    });
  }

  @override
  Widget build(BuildContext context) {
    final autovalidate = useState(false);
    final newPassword1 = useTextEditingController(text: '');
    final newPassword2 = useTextEditingController(text: '');

    return CSScaffold(
      title: tr('wallet:change_pwd_title'),
      scrollable: true,
      child: Form(
        key: formKey,
        child: StoreConnector<AppState, WalletManagementVM>(
          converter: WalletManagementVM.fromStore,
          builder: (context, viewModel) => Column(
            children: [
              FormBoxPassword(
                title: tr('wallet:change_pwd_input1_lbl'),
                controller: newPassword1,
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
                title: tr('wallet:change_pwd_input2_lbl'),
                controller: newPassword2,
                hintText: tr('wallet:pwd_input2_hint'),
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
                      fieldPwd: newPassword1,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              ButtonDisableListener(
                listenValues: [newPassword1, newPassword2],
                builder: (disabled) {
                  return CSButton(
                    disabled: disabled,
                    label: tr('wallet:change_pwd_btn_confirm'),
                    onPressed: () {
                      handleSubmit(viewModel, autovalidate, newPassword1);
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
