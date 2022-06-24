part of trade_domain_module;

abstract class TradeOrderListVM
    implements Built<TradeOrderListVM, TradeOrderListVMBuilder> {
  factory TradeOrderListVM([void Function(TradeOrderListVMBuilder) b]) =
      _$TradeOrderListVM;
  TradeOrderListVM._();

  // Fields
  String get walletId;

  // Methods
  @BuiltValueField(compare: false)
  AssetCoin Function({required String chain, required String symbol})
      get getCoinInfo;

  static TradeOrderListVM fromStore(Store<AppState> store) {
    return TradeOrderListVM(
      (viewModel) => viewModel
        ..walletId = store.state.walletState.activeWalletId
        ..getCoinInfo = ({required chain, required symbol}) {
          return VMWithWalletGetCoinInfoImplement.getCoinInfo(
            store,
            chain: chain,
            symbol: symbol,
          );
        },
    );
  }
}
