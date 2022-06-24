part of home_domain_module;

abstract class _BaseAction extends ReduxAction<AppState> {
  //
}

class HomeActionInit extends _BaseAction {
  @override
  Future<AppState> reduce() async {
    await store.dispatchAsync(HomeActionGetBanners());
    await store.dispatchAsync(AdmissionActionGetLatest());
    await store.dispatchAsync(HomeActionGetQuotations());
    if (store.state.communityState.configState != ConfigState.loading.index) {
      await store.dispatchAsync(CommunityActionLoadConfig());
    }
    return state.rebuild((a) => a..homeState.isInitialized = true);
  }
}

class HomeActionGetBanners extends _BaseAction {
  @override
  Future<AppState> reduce() async {
    final json = await HomeRepository().getBanners();
    final list = deserializeListOf<HomeBanner>(json);
    return state.rebuild((a) => a..homeState.homeBanners.replace(list));
  }
}

class HomeActionGetQuotations extends _BaseAction {
  @override
  Future<AppState> reduce() async {
    final json = await HomeRepository().getQuotations(marketId: 'USDT');
    //final json = [{'tradePairId': 'HAH/USDT', 'price': 13.2, 'precision': 8, 'price24h': 11.5}];

    print('这是获取到json $json');
    final list = deserializeListOf<AssetPrice>(json);
    print('这是获取到list $list');
    return state.rebuild((a) => a..homeState.homePrices.replace(list));
  }

  @override
  Object? wrapError(dynamic error) {
    return error;
  }
}
