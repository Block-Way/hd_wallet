part of community_domain_module;

abstract class CommunityBlacklistVM
    implements Built<CommunityBlacklistVM, CommunityBlacklistVMBuilder> {
  factory CommunityBlacklistVM(
          [void Function(CommunityBlacklistVMBuilder) updates]) =
      _$CommunityBlacklistVM;
  CommunityBlacklistVM._();
// UI Fields
  @nullable
  BuiltList<CommunityTeam> get communityBlacklist;

  bool get hasWallet;

  @BuiltValueField(compare: false)
  Future<int> Function({
    bool isRefresh,
    int skip,
    String searchName,
    String type,
  }) get loadData;

  @BuiltValueField(compare: false)
  Future<void> Function() get clearCommunityBlacklist;

  // UI Actions
  static Future<int> _loadData({
    Store<AppState> store,
    bool isRefresh,
    int skip,
    String searchName,
    String type,
  }) async {
    await store.dispatchFuture(CommunityActionGetBlacklist(
      isRefresh: isRefresh,
      skip: skip,
      searchName: searchName,
      type: type,
    ));
    return Future.value(
        store.state.communityState.communityBlacklist?.length ?? 0);
  }

  // UI Logic
  static CommunityBlacklistVM fromStore(Store<AppState> store) {
    return CommunityBlacklistVM((viewModel) => viewModel
      ..communityBlacklist =
          store.state.communityState.communityBlacklist?.toBuilder()
      ..hasWallet = store.state.walletState.hasWallet
      ..loadData = ({
        isRefresh,
        skip,
        searchName,
        type,
      }) async {
        return _loadData(
          store: store,
          isRefresh: isRefresh,
          skip: skip,
          searchName: searchName,
          type: type,
        );
      }
      ..clearCommunityBlacklist = () {
        return store.dispatchFuture(CommunityActionClearBlacklist());
      });
  }
}
