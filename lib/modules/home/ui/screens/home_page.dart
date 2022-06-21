part of home_ui_module;

var _hasShownNewVersionDialog = kDebugMode;

class HomePage extends StatelessWidget {
  final refreshController = CSRefresherController();

  void handleOpenBannerPage(HomeBanner bannerItem) {
    switch (bannerItem.type) {
      case 'URL':
        WebViewPage.open(bannerItem.content ?? '', bannerItem.title);
        break;
      case 'SYSTEM_NOTICE':
        //NoticeDetailPage.open(
        //  null,
        //  NumberUtil.getInt(bannerItem.content, -1),
        //);
        break;
      default:
    }
  }

  void handleShowNewVersion(BuildContext context, ConfigUpdateData data) {
    if (data != null) {
      showUpdateAppDialog(
        context,
        downloadUrl: data.downloadUrl ?? '',
        description: data.description ?? '',
        version: data.version ?? '',
      );
      _hasShownNewVersionDialog = true;
    }
  }

  Future<void> handleOpenTrade(HomePageVM viewModel, TradePair tradePair) {
    return viewModel.doChangeTradePair(tradePair).then((value) {
      AppNavigator.gotoTabBarPage(AppTabBarPages.trade);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CSScaffold(
      hideLeading: true,
      titleCenter: false,
      headerBgColor: context.mainColor,
      backgroundColor: context.mainColor,
      // Color(0xFF17191C)
      // titleWidget: StoreConnector<AppState, HomePageVM>(
      //   distinct: true,
      //   converter: HomePageVM.fromStore,
      //   builder: (context, viewModel) => Text(
      //     tr('home:title'),
      //     style: context.textHuge(fontWeight: FontWeight.w700, color: context.bgPrimaryColor),
      //
      //   ),
      // ),
      outerChild: Container(
        width: double.infinity,
        height: 112,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: const [
              Color(0xFF32383E),
              Color(0xFF17191C),
            ],
          ),
        ),
      ),
      child: StoreConnector<AppState, HomePageVM>(
        distinct: true,
        converter: HomePageVM.fromStore,
        onInitialBuild: (_, __, viewModel) {
          viewModel.doLoadHomeData();
          if (AppConstants.isBeta && !kDebugMode) {
            // Only on Beta force check for new version
            // every time enter home page
            viewModel.doCheckForBetaUpdates().then((value) {
              handleShowNewVersion(context, value);
            });
          }
          if ((viewModel.hasNewVersion ?? false) &&
              !_hasShownNewVersionDialog) {
            handleShowNewVersion(context, viewModel.newVersionData!);
          } else {
            viewModel.doCheckLanguage().then(
              (lang) async {
                if (lang != null) {
                  final newLangTr =
                      await AppLocalizations.getTranslationsByLocale(
                    lang.locale,
                  );

                  showConfirmDialog(
                    context,
                    title: newLangTr.get('global:dialog_alert_title'),
                    content: newLangTr
                        .get(
                          'global:msg_change_language',
                        )!
                        .replaceAll(RegExp('{name}'), lang.name),
                    cancelBtnText: newLangTr.get('global:btn_not_ask'),
                    confirmBtnText: newLangTr.get('global:btn_confirm'),
                    onConfirm: () {
                      context.locale = lang.locale;
                      viewModel.doChangeLanguage(lang.languageCode);
                    },
                    onCancel: () {
                      viewModel.doChangeLanguage(context.locale.languageCode);
                    },
                  );
                }
              },
            );
          }
        },
        onDidChange: (_, __, viewModel) {
          if (viewModel.hasNewVersion! && !_hasShownNewVersionDialog) {
            handleShowNewVersion(context, viewModel.newVersionData!);
          }
        },
        builder: (context, viewModel) => ListView(
          children: [
            Padding(
              padding: context.edgeAll.copyWith(top: 8),
              child: Row(
                children: [
                  CSButton(
                    flat: true,
                    onPressed: () {
                      AppMainPage.openDrawer();
                    },
                    customBorder: CircleBorder(),
                    child: CSImage(
                      'assets/images/hamburger_tab.png',
                      height: 25,
                      backgroundColor: context.mainColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            HomePricesCard(
              prices: viewModel.homePrices?.toList() ?? [],
                doChangeTradePair: (tradePair) {
                return handleOpenTrade(viewModel, tradePair);
              },
              allTradePairs: viewModel.allTradePairs.toList(),
            ),
          ],
        ),
        // builder: (context, viewModel) => CSRefresher(
        //   refreshDelay: Duration(seconds: 5),
        //   onRefresh: () {
        //     viewModel.doRefreshHomeData().then((_) {
        //       refreshController.refreshCompleted();
        //     }).catchError((_) {
        //       refreshController.refreshFailed();
        //     });
        //   },
        //   header: ListViewHeader(background: Colors.transparent),
        //   controller: refreshController,
        //   child: ListView(
        //     children: [
        //       Padding(
        //         padding: context.edgeAll.copyWith(top: 8),
        //         child: Row(
        //           children: [
        //             CSButton(
        //               flat: true,
        //               onPressed: () {
        //                 AppMainPage.openDrawer();
        //               },
        //               customBorder: CircleBorder(),
        //               child: CSImage(
        //                 'assets/images/hamburger_tab.png',
        //                 height: 25,
        //                 backgroundColor: context.mainColor,
        //               ),
        //             ),
        //
        //           ],
        //         ),
        //       ),
        //
        //       SizedBox(height: 8),
        //       HomePricesCard(
        //         prices: viewModel.homePrices?.toList() ?? [],
        //         doChangeTradePair: (tradePair) {
        //           return handleOpenTrade(viewModel, tradePair);
        //         },
        //         allTradePairs: viewModel.allTradePairs.toList(),
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
