part of invest_domain_module;

abstract class InvestProfitVM
    implements Built<InvestProfitVM, InvestProfitVMBuilder> {
  factory InvestProfitVM([void Function(InvestProfitVMBuilder) updates]) =
      _$InvestProfitVM;

  InvestProfitVM._();

  // Fields

  bool get hasWallet;

  //@nullable
  MintItem? get activeMint;

  BuiltList<ProfitRecordItem> get profitRecordList;

  @BuiltValueField(compare: false)
  AssetCoin Function({required String chain, required String symbol})
      get getCoinInfo;

  @BuiltValueField(compare: false)
  Future<int> Function({
    required bool isRefresh,
    required int skip,
    required int take,
  }) get getProfitRecordList;

  static InvestProfitVM fromStore(Store<AppState> store) {
    return InvestProfitVM(
      (viewModel) => viewModel
        ..hasWallet = store.state.walletState.hasWallet
        ..activeMint = store.state.investState.activeMint?.toBuilder()
        ..profitRecordList =
            store.state.investState.profitRecordList.toBuilder()
        ..getCoinInfo = ({required chain, required symbol}) {
          return VMWithWalletGetCoinInfoImplement.getCoinInfo(
            store,
            chain: chain,
            symbol: symbol,
          );
        }
        ..getProfitRecordList =
            ({required isRefresh, required skip, required take}) async {
          await store.dispatch(
            InvestActionGetProfitRecordList(
              isRefresh: isRefresh,
              skip: skip,
              take: take,
            ),
          );
          return Future.value(store.state.investState.profitRecordList.length);
        },
    );
  }
}
