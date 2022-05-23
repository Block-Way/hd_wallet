part of home_domain_module;

abstract class _BaseAction extends ReduxAction<AppState> {
  //
}

class HomeActionInit extends _BaseAction {
  @override
  Future<AppState> reduce() async {
    debugPrint("==============> 我看看请求");
    await store.dispatchFuture(HomeActionGetBanners());
    await store.dispatchFuture(AdmissionActionGetLatest());
    await store.dispatchFuture(HomeActionGetQuotations());
    if (store.state.communityState.configState != ConfigState.loading.index) {
      await store.dispatchFuture(CommunityActionLoadConfig());
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
    final json = await HomeRepository().getQuotations(
      marketId: 'USDT',
    );
    final list = deserializeListOf<AssetPrice>(json);
    return state.rebuild(
      (a) => a..homeState.homePrices.replace(list),
    );
  }

  @override
  Object wrapError(dynamic error) {
    return error;
  }
}
