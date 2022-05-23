part of swap_domain_module;

abstract class _BaseAction extends ReduxAction<AppState> {
  String get walletId => store.state.walletState.activeWalletId;
  SwapConfig get swapConfig => store.state.swapState.config;
}

class SwapActionGetApproveBalance extends _BaseAction {
  SwapActionGetApproveBalance({
    @required this.chain,
    @required this.symbol,
    @required this.completer,
  });
  final String chain;
  final String symbol;
  final Completer<double> completer;

  @override
  Future<AppState> reduce() async {
    final coinInfo = store.state.assetState.getCoinInfo(
      chain: chain,
      symbol: symbol,
    );
    final approveBalance = await SwapRepository().getApproveBalance(
      chain: coinInfo.chain,
      symbol: coinInfo.symbol,
      address: coinInfo.address,
      contract: coinInfo.contract,
      chainPrecision: coinInfo.chainPrecision,
    );
    completer.complete(approveBalance);
    return null;
  }

  @override
  Object wrapError(dynamic error) {
    completer.completeError(error);
    return error;
  }
}
