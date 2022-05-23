part of home_domain_module;

abstract class HomePageVM implements Built<HomePageVM, HomePageVMBuilder> {
  factory HomePageVM([void Function(HomePageVMBuilder) updates]) = _$HomePageVM;
  HomePageVM._();

// Fields

  @nullable
  BuiltList<AssetPrice> get homePrices;
  @nullable
  BuiltList<HomeBanner> get homeBanners;
  @nullable
  BuiltList<NoticeInfo> get homeNotices;

  @nullable
  BuiltList<AdmissionInfo> get admissionList;

  @nullable
  bool get hasNewVersion;
  @nullable
  ConfigUpdateData get newVersionData;

  BuiltList<TradePair> get allTradePairs;
  BuiltList<TradeMarket> get allTradeMarkets;

  bool get hasWallet;

  @nullable
  CommunityConfig get communityConfig;

  @nullable
  int get communityConfigState;

// Methods

  @BuiltValueField(compare: false)
  void Function() get doLoadHomeData;

  @BuiltValueField(compare: false)
  Future<ConfigUpdateData> Function() get doCheckForBetaUpdates;

  @BuiltValueField(compare: false)
  Future<AppLanguage> Function() get doCheckLanguage;

  @BuiltValueField(compare: false)
  Future<void> Function(String language) get doChangeLanguage;

  @BuiltValueField(compare: false)
  Future<void> Function(TradePair tradePair) get doChangeTradePair;

  @BuiltValueField(compare: false)
  Future<void> Function() get doRefreshHomeData;

  @BuiltValueField(compare: false)
  Future<void> Function() get doRefreshCommunity;

// UI Logic
  static HomePageVM fromStore(Store<AppState> store) {
    final tradeState = store.state.tradeState;

    return HomePageVM(
      (viewModel) => viewModel
        ..hasWallet = store.state.walletState.hasWallet
        ..homePrices =
            store.state.homeState.homePrices?.toBuilder() ?? ListBuilder()
        ..homeBanners = ListBuilder(store.state.homeState.homeBanners)
        ..homeNotices = ListBuilder(store.state.noticeState.noticeLatest)
        ..allTradePairs = ListBuilder(tradeState.config?.allTradePairs ?? [])
        ..admissionList =
            store.state.admissionState.admissionList?.toBuilder() ??
                ListBuilder()
        ..allTradeMarkets =
            ListBuilder(tradeState.config?.allTradeMarkets ?? [])
        ..hasNewVersion =
            store.state.commonState.newVersion?.hasNewVersion ?? false
        ..newVersionData = store.state.commonState.newVersion?.data?.toBuilder()
        ..communityConfig = store.state.communityState.config?.toBuilder()
        ..communityConfigState = store.state.communityState.configState
        ..doLoadHomeData = () {
          // 进入首页应该就要刷新进度
          if (store.state.homeState.isInitialized == false) {
            store.dispatch(HomeActionInit());
          } else {
            store.dispatch(AdmissionActionGetLatest());
          }
        }
        ..doRefreshHomeData = () async {
          return store.dispatchFuture(HomeActionInit());
        }
        ..doRefreshCommunity = () async {
          return store.dispatchFuture(CommunityActionLoadConfig());
        }
        ..doCheckForBetaUpdates = () {
          final completer = Completer<ConfigUpdateData>();
          store.dispatch(CommonActionCheckVersion(
            completer,
            checkBeta: true,
          ));
          return completer.future;
        }
        ..doCheckLanguage = () {
          final completer = Completer<AppLanguage>();
          store.dispatch(CommonActionCheckDefaultLanguage(completer));
          return completer.future;
        }
        ..doChangeLanguage = (language) async {
          await store.dispatchFuture(CommonActionChangeLanguage(language));
          await store.dispatchFuture(CommonActionChangeFiatCurrency(
            AppLanguages.getCurrencyByLanguage(language),
          ));
        }
        ..doChangeTradePair = (tradePair) {
          return store.dispatchFuture(
            TradeActionOrderChangePair(tradePair),
          );
        },
    );
  }
}
