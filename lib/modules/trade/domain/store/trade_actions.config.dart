part of trade_domain_module;

class TradeActionLoadConfig extends _BaseAction {
  @override
  Future<AppState> reduce() async {
    final config = await TradeRepository().getConfig();
    GetIt.I<CoinConfig>().updateFromDex(
      config.coins.fold(<String, int>{}, (all, coin) {
        all[coin.symbol] = coin.dealPrecision;
        return all;
      }),
    );
    return store.state.rebuild(
      (a) => a.tradeState.config.replace(config),
    );
  }

  @override
  void after() {
    super.after();
    dispatch(TradeActionLoadConfigAfter());
    dispatch(TradeActionLoadMqtt());
  }

  @override
  Object wrapError(dynamic error) {
    return error;
  }
}

class TradeActionLoadConfigAfter extends _BaseAction {
  @override
  AppState reduce() {
    final isError = tradeConfig == null;

    return store.state.rebuild(
      (a) => a.tradeState.configState =
          isError ? ConfigState.error.index : ConfigState.success.index,
    );
  }
}
