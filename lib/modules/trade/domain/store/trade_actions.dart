part of trade_domain_module;

abstract class _BaseAction extends ReduxAction<AppState> {
  String get walletId => store.state.walletState.activeWalletId;
  TradeConfig get tradeConfig => store.state.tradeState.config;

  /// We need to fix the symbol for ERC20, TRC20 and BBC, use only USDT
  /// The chain can only have one USDT
  String fixUSDTSymbol(String symbol) => symbol
      .replaceAll('-ERC20', '')
      .replaceAll('-TRC20', '')
      .replaceAll('-BBC', '');
}

class TradeActionOrderChangePair extends _BaseAction {
  TradeActionOrderChangePair(this.tradePair);
  final TradePair tradePair;

  @override
  AppState reduce() {
    return store.state.rebuild(
      (a) => a.tradeState.tradePair = tradePair.toBuilder(),
    );
  }
}

class TradeActionOrderChangeSide extends _BaseAction {
  TradeActionOrderChangeSide(this.tradeSide);
  final TradeSide tradeSide;

  @override
  AppState reduce() {
    return store.state.rebuild(
      (a) => a.tradeState.tradeSide = tradeSide,
    );
  }
}

class TradeActionTipHideSlowTradePair extends _BaseAction {
  TradeActionTipHideSlowTradePair(this.tradePair);
  final TradePair tradePair;

  @override
  AppState reduce() {
    return state.rebuild(
      (a) => a..tradeState.hideSlowTradePairTip.add(tradePair.id),
    );
  }
}
