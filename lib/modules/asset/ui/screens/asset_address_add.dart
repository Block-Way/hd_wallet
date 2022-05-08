part of asset_ui_module;

class AssetAddressAddPage extends HookWidget {
  AssetAddressAddPage({
    this.item,
    this.coinInfo,
  });

  final AssetAddress item;
  final AssetCoin coinInfo;
  final formKey = GlobalKey<FormState>();

  static const routeName = '/asset/address/add';

  static void open(AssetCoin coinInfo, [AssetAddress item]) {
    AppNavigator.push(routeName, params: {
      'item': item,
      'coinInfo': coinInfo,
    });
  }

  static Route<dynamic> route(RouteSettings settings) {
    final params = settings.arguments as Map<String, dynamic>;
    final item = params['item'];
    final coinInfo = params['coinInfo'] as AssetCoin;

    return DefaultTransition(
      settings,
      AssetAddressAddPage(
        item: item == null ? null : item as AssetAddress,
        coinInfo: coinInfo,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = item != null && item.id != null;

    final address = useTextEditingController(text: item?.address ?? '');
    final name = useTextEditingController(text: item?.comments ?? '');
    final autovalidate = useState(false);

    Future<void> handleSubmit(AssetAddressVM viewModel) async {
      final isValid = formKey.currentState.validate();
      if (!autovalidate.value) {
        autovalidate.value = true;
      }
      if (!isValid) {
        return;
      }

      final addressValid = await viewModel.validateAddress(
        chain: coinInfo.chain,
        address: address.text,
      );
      if (addressValid == null || addressValid == false) {
        return Toast.show(tr('wallet:wallet_error_invalid_address'));
      }

      LoadingDialog.show(context);
      viewModel
          .submitAddressAdd(
              coinInfo,
              AssetAddress.fromAdd(
                id: item?.id,
                address: address.text,
                comments: name.text,
              ))
          .then((_) {
        Toast.show(tr(isEdit
            ? 'asset:address_msg_edit_success'
            : 'asset:address_msg_add_success'));
        LoadingDialog.dismiss(context);
        AppNavigator.goBack();
      }).catchError((e) {
        LoadingDialog.dismiss(context);
        Toast.showError(e);
      });
    }

    return CSScaffold(
      scrollable: true,
      title:
          tr(isEdit ? 'asset:address_edit_title' : 'asset:address_add_title'),
      child: StoreConnector<AppState, AssetAddressVM>(
        distinct: true,
        converter: AssetAddressVM.fromStore,
        builder: (context, viewModel) {
          return Form(
            key: formKey,
            autovalidateMode: autovalidate.value
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
            child: Column(
              children: [
                AssetCoinBox(
                  title: tr('asset:withdraw_lbl_coin'),
                  coinInfo: coinInfo,
                ),
                FormBox(
                  type: FormBoxType.inputText,
                  title: tr('asset:address_add_address_lbl'),
                  iconName: CSIcons.Scan,
                  iconColor: context.bodyColor,
                  validator: RequiredValidator(
                    errorText: tr('asset:address_add_address_req'),
                  ),
                  onPressIcon: () {
                    QRScannerPage.open().then((toAddress) {
                      if (toAddress != null && toAddress.isNotEmpty) {
                        address.text = toAddress;
                      }
                    });
                  },
                  controller: address,
                  hintText: tr('asset:address_add_address_hint'),
                  maxLines: null,
                  maxLength: 512,
                ),
                FormBox(
                  showCounterText: true,
                  maxLengthChineseDouble: true,
                  maxLength: 30,
                  type: FormBoxType.inputText,
                  title: tr('asset:address_add_name_lbl'),
                  validator: RequiredValidator(
                    errorText: tr('asset:address_add_name_req'),
                  ),
                  controller: name,
                  hintText: tr('asset:address_add_name_hint'),
                ),
                CSButton(
                  label: tr('global:btn_confirm'),
                  margin: context.edgeVertical,
                  onPressed: () {
                    handleSubmit(viewModel);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
