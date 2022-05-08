part of community_domain_module;

abstract class CommunityJoinVM
    implements Built<CommunityJoinVM, CommunityJoinVMBuilder> {
  factory CommunityJoinVM([void Function(CommunityJoinVMBuilder) updates]) =
      _$CommunityJoinVM;
  CommunityJoinVM._();

  @nullable
  String get walletId;

  @BuiltValueField(compare: false)
  Future<CommunityMember> Function(String id) get getMyJoin;

// UI Actions、
  @BuiltValueField(compare: false)
  Future<void> Function(TeamJoinParams params) get joinTeam;

// UI Logic
  static CommunityJoinVM fromStore(Store<AppState> store) {
    return CommunityJoinVM(
      (viewModel) => viewModel
        ..walletId = store.state.walletState.activeWalletId ?? ''
        ..getMyJoin = (id) {
          final completer = Completer<CommunityMember>();
          store.dispatch(CommunityActionGetMyJoin(
            id: id,
            completer: completer,
          ));
          return completer.future;
        }
        ..joinTeam = (params) {
          return store.dispatchFuture(CommunityActionJoin(params));
        },
    );
  }
}
