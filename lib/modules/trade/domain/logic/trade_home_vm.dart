part of trade_domain_module;

abstract class TradeHomeVM implements Built<TradeHomeVM, TradeHomeVMBuilder> {
  factory TradeHomeVM([void Function(TradeHomeVMBuilder) b]) = _$TradeHomeVM;
  TradeHomeVM._();

// Fields

  bool get hasWallet;
  String get ethAddress;

  //TradePair get tradePair;
  //TradeSide get tradeSide;
  //String get fiatCurrency;
  //@nullable
  String? get activeWalletId;

  //@nullable
  //AssetCoin? get priceCoinInfo;
  //@nullable
  //AssetCoin? get tradeCoinInfo;
  //@nullable
  //AssetCoin? get sideCoinInfo;
  //@nullable
  //TradeConfigCoin? get sideCoinConfig;

  //BuiltList<TradePair> get allTradePairs;

  @BuiltValueField(compare: false)
  Future<WalletPrivateData> Function(String password) get doUnlockWallet;

  @BuiltValueField(compare: false)
  Future<void> Function({
    required WithdrawSubmitParams param,
    required String txId,
  }) get transferResult;

  static TradeHomeVM fromStore(Store<AppState> store) {
    //final tradeState = store.state.tradeState;
    final activeWalletId = store.state.walletState.activeWalletId;
    //final fiatCurrency = store.state.commonState.fiatCurrency ?? '';

    return TradeHomeVM(
      (viewModel) => viewModel
        ..hasWallet = store.state.walletState.hasWallet
        //..tradePair = tradePair!.toBuilder()
        //..tradeSide = tradeState.tradeSide
        //..fiatCurrency = fiatCurrency
        ..activeWalletId = activeWalletId
        ..doUnlockWallet = (password) {
          final completer = Completer<WalletPrivateData>();
          store.dispatch(WalletActionWalletUnlock(password, completer));
          return completer.future;
        },
    );
  }
}
