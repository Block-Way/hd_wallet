part of wallet_ui_module;

enum _WalletMenu {
  backup,
  export,
  delete,
  changeName,
  changePassword,
}

enum _InvitationMenu {
  invitationCode,
  invitationCreate,
  invitationRecord,
}

class WalletManagementPage extends HookWidget {
  static const routeName = '/wallet/management';

  static void open() {
    AppNavigator.push(routeName);
  }

  static Route<dynamic> route(RouteSettings settings) {
    return DefaultTransition(settings, WalletManagementPage());
  }

  void handleInvitationMenuPress(
    WalletManagementVM viewModel,
    _InvitationMenu type,
  ) {
    AnalyticsReport().reportLog('Wallet_Management_Action', {
      'type': type.toString(),
      'walletId': viewModel.activeWallet.id,
    });
    switch (type) {
      case _InvitationMenu.invitationCode:
        InvitationCoinSelectPage.open(showInvitationCode: true);
        break;
      case _InvitationMenu.invitationCreate:
        InvitationCreatePage.open();
        break;
      case _InvitationMenu.invitationRecord:
        InvitationListPage.open();
        break;
      default:
    }
  }

  void handleWalletMenuPress(
    BuildContext context,
    WalletManagementVM viewModel,
    _WalletMenu type,
  ) {
    showPasswordDialog(
      context,
      (password) => viewModel.doUnlockWallet(password),
      (data, password) {
        AnalyticsReport().reportLog('Wallet_Management_Action', {
          'type': type.toString(),
          'walletId': viewModel.activeWallet.id,
        });
        switch (type) {
          case _WalletMenu.changeName:
            WalletChangeNamePage.open(viewModel.activeWallet.name);
            break;
          case _WalletMenu.changePassword:
            WalletChangePasswordPage.open(password);
            break;
          case _WalletMenu.backup:
            WalletBackupPage.open(data.mnemonic);
            break;
          case _WalletMenu.export:
            WalletExportPage.open(data);
            break;
          case _WalletMenu.delete:
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
                  LoadingDialog.dismiss(context);
                  AppNavigator.goBack();
                }).catchError((error) {
                  LoadingDialog.dismiss(context);
                  Toast.showError(error);
                });
              },
            );
            break;
          default:
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CSScaffold(
      title: tr('wallet:management_title'),
      scrollable: true,
      child: StoreConnector<AppState, WalletManagementVM>(
        distinct: true,
        converter: WalletManagementVM.fromStore,
        builder: (context, viewModel) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: context.edgeAll.copyWith(bottom: 0),
              child: Text(
                tr('wallet:management_title'),
                style: context.textBody(
                  color: context.labelColor,
                  bold: true,
                ),
              ),
            ),
            CSContainer(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  FormCell(
                    label: tr('wallet:management_btn_name'),
                    onPress: () {
                      handleWalletMenuPress(
                        context,
                        viewModel,
                        _WalletMenu.changeName,
                      );
                    },
                  ),
                  FormCell(
                    label: tr('wallet:management_btn_password'),
                    showBorderTop: true,
                    onPress: () {
                      handleWalletMenuPress(
                        context,
                        viewModel,
                        _WalletMenu.changePassword,
                      );
                    },
                  ),
                  FormCell(
                    label: tr('wallet:management_btn_backup'),
                    showBorderTop: true,
                    cmpRight: viewModel.activeWallet.hasBackup == false
                        ? CSBadge(size: 8)
                        : null,
                    onPress: () {
                      handleWalletMenuPress(
                        context,
                        viewModel,
                        _WalletMenu.backup,
                      );
                    },
                  ),
                  //  if (kDebugMode)
                  //   FormCell(
                  //     label: tr('wallet:management_btn_export'),
                  //     onPress: () {
                  //       handleWalletMenuPress(
                  //         context,
                  //         viewModel,
                  //         _WalletMenu.export,
                  //       );
                  //     },
                  //   ),
                ],
              ),
            ),
            Padding(
              padding: context.edgeAll.copyWith(bottom: 0),
              child: Text(
                tr('wallet:management_btn_invitation_create'),
                style: context.textBody(
                  color: context.labelColor,
                  bold: true,
                ),
              ),
            ),
            CSContainer(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  FormCell(
                    label: tr('wallet:management_btn_invitation_code'),
                    onPress: () {
                      handleInvitationMenuPress(
                        viewModel,
                        _InvitationMenu.invitationCode,
                      );
                    },
                  ),
                  FormCell(
                    label: tr('wallet:management_btn_invitation_create'),
                    showBorderTop: true,
                    onPress: () {
                      handleInvitationMenuPress(
                        viewModel,
                        _InvitationMenu.invitationCreate,
                      );
                    },
                  ),
                  FormCell(
                    label: tr('wallet:management_btn_invitation_list'),
                    showBorderTop: true,
                    onPress: () {
                      handleInvitationMenuPress(
                        viewModel,
                        _InvitationMenu.invitationRecord,
                      );
                    },
                  ),
                ],
              ),
            ),
            CSContainer(
              padding: EdgeInsets.zero,
              child: FormCell(
                label: tr('wallet:management_btn_delete'),
                labelStyle: context.textBody(
                  bold: true,
                  color: context.redColor,
                ),
                hideAccess: true,
                cmpLeft: Spacer(),
                onPress: () {
                  handleWalletMenuPress(
                    context,
                    viewModel,
                    _WalletMenu.delete,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
