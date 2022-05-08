part of hdkey_ui_module;

class HDKeyMnemonicListPage extends StatelessWidget {
  static const routeName = '/hdkey/mnemonic/list';

  static void open() {
    AppNavigator.push(routeName);
  }

  static Route<dynamic> route(RouteSettings settings) {
    return DefaultTransition(
      settings,
      HDKeyMnemonicListPage(),
    );
  }

  void showImportDialog(BuildContext context) {
    showCSBottomSheet(
      context,
      (_) => HDKeyMnemonicImportDialog(),
      maxHeight: context.mediaHeight * 0.6,
      minHeight: 0,
    );
  }

  void showDeleteConfirmDialog(BuildContext context, dynamic item) {
    showConfirmDialog(
      context,
      content: '您正在删除硬件设备上保存的助记词，是否继续删除？删除后助记词将无法恢复！',
      confirmBtnText: '确认删除',
      confirmBtnStyle: context.textBody(
        bold: true,
        color: context.redColor,
      ),
      onConfirm: () {
        Toast.show('todo delete mnemonic');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CSScaffold(
      title: tr('助记词管理'),
      child: Container(
        margin: context.edgeAll,
        width: double.infinity,
        child: StoreConnector<AppState, HDKeyManagementVM>(
          distinct: true,
          converter: HDKeyManagementVM.fromStore,
          builder: (context, viewModel) => Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: viewModel.wallets
                        .map<Widget>((e) => HDKeyMnemonicItem(
                            item: e,
                            onDelete: () {
                              showDeleteConfirmDialog(context, e);
                            },
                            isRecoverDisable:
                                viewModel.localIds.contains(e.id)))
                        .toList(),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Center(
                      child: CSButton(
                        flat: true,
                        label: '导入',
                        onPressed: () {
                          showImportDialog(context);
                        },
                        cmpLeft: Padding(
                          padding: context.edgeHorizontal,
                          child: Icon(
                            CSIcons.Import,
                            size: 14,
                            color: context.bodyColor,
                          ),
                        ),
                        padding: context.edgeVertical,
                      ),
                    ),
                  ),
                  Container(
                    height: 12,
                    width: 1,
                    color: context.secondaryColor,
                  ),
                  Expanded(
                    child: Center(
                      child: CSButton(
                        flat: true,
                        label: '填写',
                        cmpLeft: Padding(
                          padding: context.edgeHorizontal,
                          child: Icon(
                            CSIcons.Create,
                            size: 14,
                            color: context.bodyColor,
                          ),
                        ),
                        padding: context.edgeVertical,
                        onPressed: () {
                          HDKeyMnemonicImportPage.open();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
