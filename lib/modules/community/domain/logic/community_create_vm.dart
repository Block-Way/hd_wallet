part of community_domain_module;

abstract class CommunityCreateVM
    implements Built<CommunityCreateVM, CommunityCreateVMBuilder> {
  factory CommunityCreateVM([void Function(CommunityCreateVMBuilder) updates]) =
      _$CommunityCreateVM;
  CommunityCreateVM._();

  @nullable
  String get walletId;

  @nullable
  BuiltList<AssetCoin> get coinList;

// UI Actions、
  @BuiltValueField(compare: false)
  Future<void> Function(TeamCreateParams params) get createCommunity;

  @BuiltValueField(compare: false)
  Future<CommunityTeam> Function(int type) get getMyTeam;

// UI Logic
  static CommunityCreateVM fromStore(Store<AppState> store) {
    final ecological = store.state.communityState?.config?.ecological;
    final coins = <AssetCoin>[];
    if (ecological != null && ecological.isNotEmpty) {
      for (final item in ecological) {
        coins.add(store.state.assetState.getCoinInfo(
          chain: item.chain,
          symbol: item.symbol,
        ));
      }
    }

    return CommunityCreateVM(
      (viewModel) => viewModel
        ..coinList = ListBuilder(coins)
        ..walletId = store.state.walletState.activeWalletId
        ..getMyTeam = (type) {
          final completer = Completer<CommunityTeam>();
          store.dispatch(CommunityActionGetMyTeam(
            type: type,
            completer: completer,
          ));
          return completer.future;
        }
        ..createCommunity = (params) {
          return store.dispatchFuture(CommunityActionCreate(params));
        },
    );
  }
}
