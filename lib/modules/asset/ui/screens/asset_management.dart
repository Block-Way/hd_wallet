part of asset_ui_module;

class AssetManagementPage extends StatelessWidget {
  static const routeName = '/asset/management';

  static void open() {
    AppNavigator.push(routeName);
  }

  static Route<dynamic> route(RouteSettings settings) {
    return DefaultTransition(
      settings,
      AssetManagementPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultStickyHeaderController(
      child: CSScaffold(
        title: tr('asset:management_title'),
        // TODO: [v3] add search tokens
        // actions: [
        //   IconButton(
        //     onPressed: () async {
        //       final selected = await showSearch<AssetSearchResult>(
        //         context: context,
        //         delegate: AssetSearchDelegate(),
        //       );
        //       print(selected);
        //     },
        //   )
        // ],
        child: StoreConnector<AppState, AssetManagementVM>(
          distinct: true,
          converter: AssetManagementVM.fromStore,
          onInitialBuild: (viewModel) {
            viewModel.doSearchCoin('');
          },
          builder: (context, viewModel) => CustomScrollView(
            primary: true,
            slivers: [
              // SliverAppBar(
              //   pinned: true,
              //   automaticallyImplyLeading: false,
              //   toolbarHeight: 60,
              //   title: CSSearchInput(
              //     margin: EdgeInsets.zero,
              //     hintText: tr('asset:management_hint_search'),
              //     onChanged: (term) {
              //       viewModel.doSearchCoin(term);
              //     },
              //   ),
              // ),
              SliverStickyHeader(
                header: viewModel.coinsEnabled.isNotEmpty
                    ? buildAssetHeader(
                        context,
                        tr('asset:management_lbl_enabled'),
                      )
                    : Container(),
                sticky: false,
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => buildAssetItem(
                      context,
                      viewModel.coinsEnabled[index],
                      viewModel,
                    ),
                    childCount: viewModel.coinsEnabled.length,
                  ),
                ),
              ),
              SliverStickyHeader(
                header: viewModel.coinsDisabled.isNotEmpty
                    ? buildAssetHeader(
                        context,
                        tr('asset:management_lbl_disabled'),
                      )
                    : Container(),
                sticky: false,
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => buildAssetItem(
                      context,
                      viewModel.coinsDisabled[index],
                      viewModel,
                    ),
                    childCount: viewModel.coinsDisabled.length,
                  ),
                ),
              ),
              if (viewModel.coinsDisabled.isEmpty &&
                  viewModel.coinsEnabled.isEmpty)
                SliverFillRemaining(
                  child: CSEmpty(
                    label: tr('asset:management_msg_empty'),
                    imageUrl: 'assets/images/notify_empty_search.png',
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildAssetHeader(BuildContext context, String title) => Container(
      padding: context.edgeAll,
      child: Text(
        title,
        style: context.textBody(
          bold: true,
          color: context.labelColor,
        ),
      ),
    );
void updateCoinAddress({
  BuildContext context,
  AssetManagementVM viewModel,
  AssetCoin coin,
  bool isEnabled,
}) {
  showPasswordDialog(
    context,
    (password) => viewModel.doUnlockWallet(password),
    (data, _) {
      LoadingDialog.show(context);
      viewModel.updateCoinAddress(data, coin.chain).then((value) {
        viewModel.doToggleCoin(coin, isEnabled);
      }).catchError((e) {
        Toast.showError(e);
      }).whenComplete(() {
        LoadingDialog.dismiss(context);
      });
    },
  );
}

Widget buildAssetItem(
  BuildContext context,
  AssetCoin item,
  AssetManagementVM viewModel,
) {
  return CSContainer(
    margin: EdgeInsets.only(
      left: context.edgeSize,
      right: context.edgeSize,
      bottom: context.edgeSize,
    ),
    child: ListTile(
      key: Key('${item.chain}${item.symbol}'),
      dense: true,
      leading: CSImage(
        item.iconUrl,
        fallbackUrl: item.iconLocal,
        bordered: true,
        width: 27,
        height: 27,
        radius: 27,
        backgroundColor: context.whiteColor,
      ),
      trailing: !item.isFixed
          ? CSSwitch(
              value: item.isEnabled,
              onChangedBack: (isEnabled) {
                // 关闭币种，可以不管他是不是有地址
                if ((item.address == null || item.address.isEmpty) &&
                    isEnabled) {
                  updateCoinAddress(
                    context: context,
                    viewModel: viewModel,
                    coin: item,
                    isEnabled: isEnabled,
                  );
                  return false;
                } else {
                  viewModel.doToggleCoin(item, isEnabled);
                  return true;
                }
              },
            )
          : null,
      title: Transform.translate(
        offset: Offset(-10, 0),
        child: Text(
          item.symbol,
          style: context.textBody(),
        ),
      ),
      subtitle: Transform.translate(
        offset: Offset(-10, 0),
        child: Text(
          item.name,
          style: context.textSecondary(),
        ),
      ),
    ),
  );
}
