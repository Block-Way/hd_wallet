part of asset_ui_module;

// var _ignoreIndexChange = false;

class AssetListPage extends StatelessWidget {
  final refreshController = CSRefresherController();
  final scrollController = ScrollController();
  final swiperController = SwiperController();

  Widget buildUpdatePrices(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: 40,
      child: Center(
        child: Container(
          decoration: context.boxDecoration(
            color: context.blackColor.withOpacity(0.8),
            radius: 20,
          ),
          height: 40,
          width: 170,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CSProgressIndicator(
                size: 14,
                color: context.whiteColor,
              ),
              SizedBox(width: context.edgeSize),
              Text(
                tr('asset:list_lbl_updating'),
                style: context.textSecondary(
                  color: context.whiteColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildWalletCardEmpty(
    BuildContext context,
    AssetListVM viewModel,
  ) {
    return Container(
      height: 200,
      width: double.infinity,
      margin: context.edgeAll.copyWith(top: 8),
      decoration: context.boxCardShadow(),
      child: ClipRect(
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            padding: context.edgeAll20,
            decoration: AssetBackgroundCircle(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  tr('asset:list_lbl_valuation'),
                  style: context.textBody(bold: true),
                ),
                SizedBox(height: context.edgeSize),
                PriceText(
                  '0',
                  viewModel.fiatCurrency,
                  TextSize.huge,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildWalletCardInfo(
    BuildContext context,
    AssetListVM viewModel,
  ) {
    // return Swiper(
    //   controller: swiperController,
    //   itemBuilder: (context, index) {
    return CSContainer(
      decoration: context.boxCardShadow(),
      margin: context.edgeAll.copyWith(bottom: 20, top: 8),
      padding: EdgeInsets.zero,
      child: AssetWalletCard(
        fiatCurrency: viewModel.fiatCurrency,
        wallet: viewModel.activeWallet,
        walletStatus: viewModel.activeWalletStatus,
        onSync: (wallet) {
          LoadingDialog.show(context);
          viewModel.doSyncWallet(wallet).catchError((error) {
            Toast.showError(error);
          }).whenComplete(() {
            LoadingDialog.dismiss(context);
          });
        },
        onPressed: () {
          AssetWalletSelectPage.open().then((wallet) {
            if (wallet != null) {
              viewModel.doSwitchWallet(wallet);
              // _ignoreIndexChange = true;
              // final index = viewModel.wallets.indexOf(wallet);
              // swiperController.move(index, animation: false).
              // whenComplete(() {
              //   _ignoreIndexChange = false;
              // });
            }
          });
        },
      ),
    );
    // },
    // loop: false,
    // itemCount: viewModel.wallets.length,
    // itemWidth: context.mediaWidth,
    // // itemHeight: 220.0,
    // // layout: SwiperLayout.TINDER,
    // onIndexChanged: (index) {
    //   if (_ignoreIndexChange == true) {
    //     return;
    //   }
    //   viewModel.doSwitchWallet(viewModel.wallets[index]);
    // },
    // );
  }

  Widget buildContentEmpty(
    BuildContext context,
    AssetListVM viewModel,
  ) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Container(
        decoration: context.boxDecorationOnlyTop(radius: 30),
        padding: context.edgeAll,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CSEmpty(
              heightFromTop: 0,
              width: 250,
              height: 127,
              imageUrl: 'assets/images/empty_wallet.png',
            ),
            WalletCreateButtons(
              isEmptyPage: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildContentList(
    BuildContext context,
    AssetListVM viewModel,
  ) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Container(
            decoration: context.boxDecorationOnlyTop(radius: 30),
            padding: context.edgeBottom,
            constraints: BoxConstraints(
              minHeight: context.mediaHeight - 200,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: Center(
                    child: Container(
                      width: 36,
                      height: 5,
                      margin: EdgeInsets.only(top: 7),
                      decoration: BoxDecoration(
                        color: context.borderColor,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
                ...viewModel.coins
                    .map(
                      (coin) => AssetListItem(
                        item: coin,
                        onPressed: () {
                          if (viewModel.hasWallet) {
                            AssetDetailPage.open(coin);
                          } else {
                            Toast.show(tr('wallet:msg_create_wallet_tips'));
                          }
                        },
                      ),
                    )
                    .toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CSScaffold(
      hideLeading: true,
      titleCenter: false,
      title: tr('asset:list_title'),
      titleStyle: context.textHuge(fontWeight: FontWeight.w700),
      child: StoreConnector<AppState, AssetListVM>(
        distinct: true,
        converter: AssetListVM.fromStore,
        onInitialBuild: (viewModel) {
          // _ignoreIndexChange = true;
          // swiperController
          //     .move(viewModel.wallets.indexOf(viewModel.activeWallet),
          //         animation: false)
          //     .whenComplete(() {
          //   _ignoreIndexChange = false;
          // });
        },
        builder: (context, viewModel) => Stack(
          children: [
            CSRefresher(
              scrollController: scrollController,
              onRefresh: () {
                viewModel.doRefreshList().then((_) {
                  refreshController.refreshCompleted();
                }).catchError((_) {
                  refreshController.refreshFailed();
                });
              },
              header: ListViewHeader(
                background: context.bgSecondaryColor,
                useProgressLoading: true,
              ),
              controller: refreshController,
              child: CustomScrollView(
                controller: scrollController,
                physics: viewModel.hasWallet == false
                    ? NeverScrollableScrollPhysics()
                    : null,
                slivers: [
                  SliverAppBar(
                    leading: SizedBox(),
                    title: SizedBox(),
                    elevation: 0,
                    backgroundColor: context.bgSecondaryColor,
                    expandedHeight: 220,
                    collapsedHeight: 1,
                    toolbarHeight: 0,
                    flexibleSpace: FlexibleSpaceBar(
                      background: viewModel.hasWallet == false
                          ? buildWalletCardEmpty(context, viewModel)
                          : buildWalletCardInfo(context, viewModel),
                    ),
                  ),
                  if (viewModel.hasWallet == false)
                    buildContentEmpty(context, viewModel)
                  else
                    buildContentList(context, viewModel),
                ],
              ),
            ),
            if (viewModel.isBalanceUpdating == true) buildUpdatePrices(context),
          ],
        ),
      ),
    );
  }
}
