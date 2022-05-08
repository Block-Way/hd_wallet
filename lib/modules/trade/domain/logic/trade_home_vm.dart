part of trade_domain_module;

abstract class TradeHomeVM implements Built<TradeHomeVM, TradeHomeVMBuilder> {
  factory TradeHomeVM([void Function(TradeHomeVMBuilder) b]) = _$TradeHomeVM;
  TradeHomeVM._();

// Fields

  bool get hasWallet;

  TradePair get tradePair;
  TradeSide get tradeSide;
  String get fiatCurrency;
  @nullable
  String get activeWalletId;

  @nullable
  AssetCoin get priceCoinInfo;
  @nullable
  AssetCoin get tradeCoinInfo;
  @nullable
  AssetCoin get sideCoinInfo;
  @nullable
  TradeConfigCoin get sideCoinConfig;

  BuiltList<TradePair> get allTradePairs;
// Methods

  @BuiltValueField(compare: false)
  Future<void> Function(TradePair tradePair) get doUpdateCoinBalance;

  @BuiltValueField(compare: false)
  Future<double> Function(TradePair) get getApproveBalance;

  @nullable
  @BuiltValueField(compare: false)
  Future<void> Function(TradeSide tradeSide) get doChangeTradeSide;

  @BuiltValueField(compare: false)
  Future<void> Function(TradePair tradePair) get doChangeTradePair;

  @BuiltValueField(compare: false)
  Future<void> Function(TradePair tradePair) get doSubscribeMqtt;

  @BuiltValueField(compare: false)
  AssetCoin Function({
    @required String chain,
    @required String symbol,
  }) get getCoinInfo;

  @BuiltValueField(compare: false)
  Future<WalletPrivateData> Function(String password) get doUnlockWallet;

  @BuiltValueField(compare: false)
  Future<void> Function({
    @required TradeSide tradeSide,
    @required TradePair tradePair,
    @required
        Future<bool> Function(
                {@required WalletTemplateData approveData,
                @required double currentBalance,
                @required double approveAmount,
                @required bool needReset})
            onConfirmSubmit,
    @required Future<WalletPrivateData> Function() onUnlockWallet,
    @required void Function(String) onSuccessTransaction,
  }) get doApproveOrder;

  @BuiltValueField(compare: false)
  Future<void> Function({
    @required TradeSide tradeSide,
    @required TradePair tradePair,
    @required String price,
    @required String amount,
    @required String total,
    @required Future<bool> Function(DexCreateOrderParams) onConfirmSubmit,
    @required Future<WalletPrivateData> Function() onUnlockWallet,
    @required void Function(String) onSuccessTransaction,
  }) get doCreateOrder;

  @BuiltValueField(compare: false)
  Future<void> Function({
    @required TradeOrder order,
    @required Future<bool> Function(double) onConfirmCancel,
    @required Future<WalletPrivateData> Function() onUnlockWallet,
    @required void Function(String) onSuccessTransaction,
  }) get doCancelOrder;

  @BuiltValueField(compare: false)
  Future<Transaction> Function({
    @required String chain,
    @required String symbol,
    @required String fromAddress,
    @required int chainPrecision,
    @required String txId,
  }) get getTransactionInfo;

  @BuiltValueField(compare: false)
  bool Function(TradePair) get needShowSlowTradePair;

  @BuiltValueField(compare: false)
  void Function(TradePair) get doHideSlowTradePair;

  @BuiltValueField(compare: false)
  Future<double> Function(TradeOrder order) get getOrderBalance;

  static TradeHomeVM fromStore(Store<AppState> store) {
    final tradeState = store.state.tradeState;
    final activeWalletId = store.state.walletState?.activeWalletId ?? '';
    final fiatCurrency = store.state.commonState.fiatCurrency ?? '';
    final tradePair = tradeState.tradePair ?? tradeState.getDefaultTradePair();

    final tradeCoinInfo = VMWithWalletGetCoinInfoImplement.getCoinInfo(
      store,
      chain: tradePair.tradeChain,
      symbol: tradePair.tradeSymbol,
    );
    final priceCoinInfo = VMWithWalletGetCoinInfoImplement.getCoinInfo(
      store,
      chain: tradePair.priceChain,
      symbol: tradePair.priceSymbol,
    );
    final sideCoinInfo =
        tradeState.tradeSide == TradeSide.buy ? priceCoinInfo : tradeCoinInfo;
    final sideCoinConfig = tradeState.getCoinConfig(
      chain: sideCoinInfo?.chain,
      symbol: sideCoinInfo?.symbol,
    );

    return TradeHomeVM((viewModel) => viewModel
      ..hasWallet = store.state.walletState.hasWallet
      ..tradePair = tradePair.toBuilder()
      ..tradeSide = tradeState.tradeSide
      ..fiatCurrency = fiatCurrency
      ..activeWalletId = activeWalletId
      ..tradeCoinInfo = tradeCoinInfo?.toBuilder()
      ..priceCoinInfo = priceCoinInfo?.toBuilder()
      ..sideCoinInfo = sideCoinInfo?.toBuilder()
      ..sideCoinConfig = sideCoinConfig?.toBuilder()
      ..allTradePairs = ListBuilder(tradeState.config?.allTradePairs ?? [])
      ..getCoinInfo = ({chain, symbol}) {
        return VMWithWalletGetCoinInfoImplement.getCoinInfo(
          store,
          chain: chain,
          symbol: symbol,
        );
      }
      ..getTransactionInfo = ({
        chain,
        symbol,
        fromAddress,
        chainPrecision,
        txId,
      }) {
        final completer = Completer<Transaction>();
        store.dispatch(
          AssetActionGetSingleTransaction(
            txId: txId,
            chain: chain,
            symbol: symbol,
            fromAddress: fromAddress,
            chainPrecision: chainPrecision,
            completer: completer,
          ),
        );
        return completer.future;
      }
      ..doUpdateCoinBalance = (tradePair) {
        final tradeSide = tradeState.tradeSide ?? TradeSide.buy;
        final coinInfo = VMWithWalletGetCoinInfoImplement.getCoinInfo(
          store,
          chain: tradePair.sideChain(tradeSide),
          symbol: tradePair.sideSymbol(tradeSide),
        );
        if (coinInfo == null) {
          return Future.value();
        }
        return store.dispatchFuture(
          AssetActionGetCoinBalance(
            wallet: store.state.walletState.activeWallet,
            chain: coinInfo.chain,
            symbol: coinInfo.symbol,
            address: coinInfo.address,
            ignoreBalanceLock: !kChainsNeedLockBalance.contains(coinInfo.chain),
          ),
        );
      }
      ..getApproveBalance = (tradePair) {
        final tradeSide = tradeState.tradeSide ?? TradeSide.buy;
        final coinInfo = VMWithWalletGetCoinInfoImplement.getCoinInfo(
          store,
          chain: tradePair.sideChain(tradeSide),
          symbol: tradePair.sideSymbol(tradeSide),
        );
        if (coinInfo == null) {
          return Future.value(0.0);
        }
        final completer = Completer<double>();
        store.dispatch(
          TradeActionGetApproveBalance(
            chain: coinInfo.chain,
            symbol: coinInfo.symbol,
            completer: completer,
          ),
        );
        return completer.future;
      }
      ..doUnlockWallet = (password) {
        final completer = Completer<WalletPrivateData>();
        store.dispatch(WalletActionWalletUnlock(password, completer));
        return completer.future;
      }
      ..doApproveOrder = ({
        tradeSide,
        tradePair,
        onUnlockWallet,
        onConfirmSubmit,
        onSuccessTransaction,
      }) {
        return store.dispatchFuture(TradeActionOrderApprove(
          tradePair: tradePair,
          tradeSide: tradeSide,
          onUnlockWallet: onUnlockWallet,
          onConfirmSubmit: onConfirmSubmit,
          onSuccessTransaction: onSuccessTransaction,
        ));
      }
      ..doCreateOrder = ({
        tradeSide,
        tradePair,
        price,
        amount,
        total,
        onUnlockWallet,
        onConfirmSubmit,
        onSuccessTransaction,
      }) {
        return store.dispatchFuture(TradeActionOrderCreate(
          tradeSide: tradeSide,
          tradePair: tradePair,
          price: NumberUtil.getDouble(price),
          amount: NumberUtil.getDouble(amount),
          total: NumberUtil.getDouble(total),
          onUnlockWallet: onUnlockWallet,
          onConfirmSubmit: onConfirmSubmit,
          onSuccessTransaction: onSuccessTransaction,
        ));
      }
      ..doCancelOrder = ({
        order,
        onUnlockWallet,
        onConfirmCancel,
        onSuccessTransaction,
      }) {
        return store.dispatchFuture(TradeActionOrderCancel(
          order: order,
          onUnlockWallet: onUnlockWallet,
          onConfirmCancel: onConfirmCancel,
          onSuccessTransaction: onSuccessTransaction,
        ));
      }
      ..doChangeTradePair = (tradePair) {
        return store.dispatchFuture(
          TradeActionOrderChangePair(tradePair),
        );
      }
      ..doChangeTradeSide = (tradeSide) {
        return store.dispatchFuture(
          TradeActionOrderChangeSide(tradeSide),
        );
      }
      ..doSubscribeMqtt = (tradePair) {
        return store.dispatchFuture(
          TradeActionSubscribeMqttOrder(tradePair),
        );
      }
      ..needShowSlowTradePair = (tradePair) {
        return !store.state.tradeState.hideSlowTradePairTip
                .contains(tradePair.id) &&
            tradePair.isSlow;
      }
      ..getOrderBalance = (order) {
        final completer = Completer<double>();
        store.dispatch(TradeActionGetOrderBalance(
          order: order,
          completer: completer,
        ));
        return completer.future;
      }
      ..doHideSlowTradePair = (tradePair) {
        store.dispatch(TradeActionTipHideSlowTradePair(tradePair));
      });
  }
}
