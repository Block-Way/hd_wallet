part of hdkey_ui_module;

class HDKeyManagementPage extends StatelessWidget {
  static const routeName = '/hdkey/management';

  static void open() {
    AppNavigator.push(routeName);
  }

  static Route<dynamic> route(RouteSettings settings) {
    return DefaultTransition(settings, HDKeyManagementPage());
  }

  void showResetHDKeyDialog(BuildContext context, {Function onPress}) {
    showConfirmDialog(
      context,
      title: tr('重置硬件钱包确认'),
      content: tr('您正在重置硬件钱包！重置后硬件上的所有数据都将被清除且无法恢复！'),
      cancelBtnText: tr('放弃'),
      confirmBtnText: tr('确认重置'),
      confirmTimeout: 3,
      onConfirm: () {
        onPress();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final hdDevice = GetIt.I<HDKeyDevice>();

    void resetHDKey() {
      hdDevice.resetPinCode().then((value) {
        Toast.show('重置硬件钱包成功');
        AppNavigator.goBack();
      });
    }

    return CSScaffold(
      title: tr('wallet:钱包管理'),
      scrollable: true,
      child: StoreConnector<AppState, HDKeyManagementVM>(
        distinct: true,
        converter: HDKeyManagementVM.fromStore,
        builder: (context, viewModel) => Column(
          children: [
            FormCell(
              label: tr('wallet:management_btn_name'),
              onPress: () {
                //
              },
            ),
            FormCell(
              height: 60,
              label: tr('修改PIN码'),
              onPress: () {},
            ),
            FormCell(
              height: 60,
              label: tr('助记词管理'),
              onPress: () {
                HDKeyMnemonicListPage.open();
              },
            ),
            FormCell(
              height: 60,
              label: tr('重置硬件钱包'),
              onPress: () {
                showResetHDKeyDialog(
                  context,
                  onPress: () {
                    resetHDKey();
                  },
                );
              },
            ),
            FormCell(
              label: tr('wallet:management_btn_delete'),
              onPress: () {
                showConfirmDialog(
                  context,
                  title: tr('wallet:management_delete_title'),
                  content: tr('wallet:management_delete_msg'),
                  cancelBtnText: tr('global:btn_cancel'),
                  confirmBtnText: tr('global:btn_confirm'),
                  cancelBtnStyle: context.textBody(
                    color: context.redColor,
                    bold: true,
                  ),
                  onConfirm: () {
                    LoadingDialog.show(context);
                    viewModel.deleteWallet().then((value) {
                      Toast.show(tr('wallet:management_delete_tips'));
                      AppNavigator.goBack();
                    }).catchError((error) {
                      Toast.showError(error);
                    }).whenComplete(() {
                      LoadingDialog.dismiss(context);
                    });
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
