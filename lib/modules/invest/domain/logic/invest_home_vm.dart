part of invest_domain_module;

abstract class InvestHomeVM
    implements
        Built<InvestHomeVM, InvestHomeVMBuilder>,
        VMWithWalletGetCoinInfoImplement {
  factory InvestHomeVM([void Function(InvestHomeVMBuilder) updates]) =
      _$InvestHomeVM;

  InvestHomeVM._();

  // Fields

  bool get hasWallet;

  String get fiatCurrency;

  //@nullable
  MintItem? get activeMint;

  BuiltList<MintItem> get mints;

  //@nullable
  MintInfo? get mintInfo;

  BuiltList<MintChart> get chartList;

  BuiltList<ProfitInvitationItem> get profitInvitationList;

  @BuiltValueField(compare: false)
  AssetCoin Function({
    required String chain,
    required String symbol,
  }) get getCoinInfo;

  @BuiltValueField(compare: false)
  Future<void> Function(MintItem mint) get doSwitchMint;

  @BuiltValueField(compare: false)
  Future<void> Function() get refreshMintReward;

  @BuiltValueField(compare: false)
  Future<int> Function({
    required bool isRefresh,
    required int skip,
    required int take,
  }) get getProfitInvitationList;

  @BuiltValueField(compare: false)
  MintItem? Function() get getDefaultMint;

  static InvestHomeVM fromStore(Store<AppState> store) {
    return InvestHomeVM(
      (viewModel) => viewModel
        ..hasWallet = store.state.walletState.hasWallet
        ..mintInfo = store.state.investState.mintInfo?.toBuilder()
        ..chartList = store.state.investState.chartList.toBuilder()
        ..profitInvitationList =
            store.state.investState.profitInvitationList.toBuilder()
        ..fiatCurrency = store.state.commonState.fiatCurrency ?? ''
        ..mints = ListBuilder(store.state.investState.mints ?? [])
        ..activeMint = store.state.investState.activeMint?.toBuilder()
        ..getDefaultMint = () {
          if (store.state.investState.mints?.isNotEmpty ?? false) {
            return store.state.investState.mints!.first;
          }
          return null;
        }
        ..getCoinInfo = ({required chain, required symbol}) {
          return VMWithWalletGetCoinInfoImplement.getCoinInfo(
            store,
            chain: chain,
            symbol: symbol,
          );
        }
        ..refreshMintReward = () async {
          await store.dispatch(InvestActionLoadMintInfo());
          store.dispatch(InvestActionLoadChart());
        }
        ..doSwitchMint = (mint) async {
          store.dispatch(InvestActionLoadMint(mint));
        }
        ..getProfitInvitationList =
            ({required isRefresh, required skip, required take}) async {
          await store.dispatch(
            InvestActionGetInvitationList(
              isRefresh: isRefresh,
              skip: skip,
              take: take,
            ),
          );
          return Future.value(
            store.state.investState.profitInvitationList.length,
          );
        },
    );
  }
}
