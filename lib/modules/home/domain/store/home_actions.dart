part of home_domain_module;

abstract class _BaseAction extends ReduxAction<AppState> {
  //
}

class HomeActionInit extends _BaseAction {
  @override
  Future<AppState> reduce() async {
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
    const marketId = 'USDT';
    final displayCoins = ['BTC', 'ETH'];
    final displayTradePairs = [
      'BBC/USDT-BBC',
      'BBC/USDT-ERC20',
      'BBC/USDT-TRC20',
    ];

    final nowList = await HomeRepository().getQuotations(
      marketId: marketId,
    );

    final beforeList = await HomeRepository().getQuotations(
      marketId: marketId,
      timestamp: SystemDate.getTime() - 24 * 60 * 60,
    );

    nowList.retainWhere((e) => displayCoins.remove(e['currency']));

    final homePrices = <AssetPrice>[];
    for (final item in nowList) {
      final beforeItem = beforeList.firstWhere(
        (e) => e['currency'] == item['currency'],
        orElse: () => {'currency': item['currency']},
      );
      homePrices.add(
        AssetPrice.fromPrice(
          tradePairId: '${item['currency']?.toString()}/$marketId',
          price: NumberUtil.getDouble(item['price']),
          price24h: NumberUtil.getDouble(beforeItem['price']),
          precision: 8,
        ),
      );
    }

    // 第一个版本写死的2个交易对价格  BBC/USDT-TRC20 和 BBC/USDT-ERC20
    final assetPriceCubit = GetIt.I<CoinPriceCubit>();
    for (final id in displayTradePairs) {
      homePrices.add(assetPriceCubit.state.getCoinPrice(tradePairId: id));
    }

    return state.rebuild(
      (a) => a..homeState.homePrices.replace(homePrices),
    );
  }

  @override
  Object wrapError(dynamic error) {
    return error;
  }
}
