part of wallet_ui_module;

class WalletChangeNamePage extends HookWidget {
  WalletChangeNamePage(this.oldName);
  final String oldName;

  static const routeName = '/wallet/change/name';

  static void open(String oldName) {
    AppNavigator.push(routeName, params: oldName);
  }

  static Route<dynamic> route(RouteSettings settings) {
    final oldName = settings.arguments as String;
    return DefaultTransition(settings, WalletChangeNamePage(oldName));
  }

  final formKey = GlobalKey<FormState>();

  void handleSubmit(
    WalletManagementVM viewModel,
    ValueNotifier<bool> autovalidate,
    TextEditingController newName,
  ) {
    final isValid = formKey.currentState.validate();

    if (!autovalidate.value) {
      autovalidate.value = true;
    }

    if (!isValid) {
      return;
    }

    formKey.currentState.save();
    viewModel.changeName(newName.text).then((_) {
      AppNavigator.goBack();
      Toast.show(tr('wallet:change_name_msg_success'));
    }).catchError((_) {
      Toast.show(tr('wallet:change_name_msg_error'));
    });
  }

  @override
  Widget build(BuildContext context) {
    final autovalidate = useState(false);
    final newName = useTextEditingController(text: oldName ?? '');

    return CSScaffold(
      title: tr('wallet:change_name_title'),
      scrollable: true,
      child: Form(
        key: formKey,
        child: StoreConnector<AppState, WalletManagementVM>(
          converter: WalletManagementVM.fromStore,
          builder: (context, viewModel) => Column(
            children: [
              FormBox(
                showCounterText: true,
                maxLengthChineseDouble: true,
                maxLength: kWalletNameMaxLength,
                title: tr('wallet:create_input_name_lbl'),
                controller: newName,
                hintText: tr('wallet:create_input_name_hint'),
                validator: RequiredValidator(
                  errorText: tr('wallet:create_input_name_error'),
                ),
              ),
              SizedBox(height: 10),
              ButtonDisableListener(
                listenValues: [newName],
                builder: (disabled) {
                  return CSButton(
                    disabled: disabled,
                    label: tr('wallet:change_name_btn_confirm'),
                    onPressed: () {
                      handleSubmit(viewModel, autovalidate, newName);
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
