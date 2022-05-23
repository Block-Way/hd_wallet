part of invitation_ui_module;

class InvitationCoinSelectPage extends HookWidget {
  const InvitationCoinSelectPage({this.showInvitationCode});

  /// 是否为显示 邀请码 二维码
  final bool showInvitationCode;

  static const routeName = '/invitation/coin/select';

  static Future<AssetCoin> open({bool showInvitationCode = false}) {
    return AppNavigator.push<AssetCoin>(routeName, params: showInvitationCode);
  }

  static Route<AssetCoin> route(RouteSettings settings) {
    return DefaultTransition<AssetCoin>(
      settings,
      InvitationCoinSelectPage(showInvitationCode: settings.arguments as bool),
    );
  }

  @override
  Widget build(BuildContext context) {
    final invitationCoins = useState<List<AssetCoin>>([]);

    return CSScaffold(
      title: tr('invitation:coin_select_title'),
      child: StoreConnector<AppState, InvitationSelectVM>(
        distinct: true,
        converter: InvitationSelectVM.fromStore,
        onInitialBuild: (viewModel) {
          invitationCoins.value = viewModel.getInvitationCoins();
          if (showInvitationCode) {
            viewModel.loadInvitationCode();
          }
        },
        builder: (context, viewModel) => ModelPermissionView(
          moduleName: ModuleName.invitation,
          onRefreshSuccess: () {
            invitationCoins.value = viewModel.getInvitationCoins();
          },
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: invitationCoins.value.length,
            itemBuilder: (context, index) {
              final item = invitationCoins.value[index];
              final codeItem = viewModel.invitationCodes.firstWhere(
                (e) => e.chain == item.chain && e.symbol == item.symbol,
                orElse: () => null,
              );
              return _buildItem(
                context: context,
                viewModel: viewModel,
                coin: item,
                codeItem: codeItem,
              );
            },
          ),
        ),
      ),
    );
  }

  void handlePress(
    BuildContext context,
    InvitationSelectVM viewModel,
    AssetCoin coin,
    InvitationCode codeItem,
  ) {
    if (showInvitationCode) {
      if (codeItem != null) {
        InvitationCodePage.open(codeItem);
        return;
      }
      showPasswordDialog(
        context,
        (password) => viewModel.doUnlockWallet(password),
        (walletData, _) {
          LoadingDialog.show(context);
          viewModel
              .createInvitationCode(
            mnemonic: walletData.mnemonic,
            coinInfo: coin,
          )
              .then((newCode) {
            LoadingDialog.dismiss(context);
            Toast.show(tr('invitation:code_create_msg_success'));
            InvitationCodePage.open(newCode);
          }).catchError((e) {
            Toast.showError(e);
            LoadingDialog.dismiss(context);
          });
        },
      );
    } else {
      AppNavigator.popWithResult(coin);
    }
  }

  Widget _buildItem({
    BuildContext context,
    InvitationSelectVM viewModel,
    AssetCoin coin,
    InvitationCode codeItem,
  }) {
    final hasCode = codeItem != null;
    if (coin == null) {
      return Container();
    }

    return CSContainer(
      margin: context.edgeAll.copyWith(bottom: 0),
      padding: EdgeInsets.zero,
      child: FormCell(
        label: coin.name,
        cmpLeft: Padding(
          padding: context.edgeRight8,
          child: CSImage(
            coin.iconUrl,
            fallbackUrl: coin.iconLocal,
            width: 30,
            height: 30,
            radius: 30,
            fit: BoxFit.contain,
            bordered: true,
          ),
        ),
        cmpRight: showInvitationCode
            ? Text(
                hasCode
                    ? tr('invitation:code_state_created')
                    : tr('invitation:code_state_not_create'),
                style: context.textTiny(
                  color: hasCode ? context.secondaryColor : context.redColor,
                ),
              )
            : null,
        padding: context.edgeHorizontal,
        onPress: () {
          handlePress(context, viewModel, coin, codeItem);
        },
      ),
    );
  }
}
