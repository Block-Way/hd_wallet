part of community_domain_module;

abstract class CommunityDetailVM
    implements Built<CommunityDetailVM, CommunityDetailVMBuilder> {
  factory CommunityDetailVM([void Function(CommunityDetailVMBuilder) updates]) =
      _$CommunityDetailVM;
  CommunityDetailVM._();
// UI Fields
  //@nullable
  BuiltList<CommunityTeam>? get communityTeamList;

  //@nullable
  BuiltList<CommunityMember>? get communityMemberList;

  bool get hasWallet;

  CommunityConfig get communityConfig;

  // Methods

  @BuiltValueField(compare: false)
  Future<int> Function({
    required bool isRefresh,
    required int skip,
    required String searchName,
    required String type,
    required bool isTeamList,
  }) get loadData;

  @BuiltValueField(compare: false)
  Future<void> Function({required bool isTeamList}) get clearCommunityList;

  @BuiltValueField(compare: false)
  Future<CommunityTeam> Function(String teamId) get getCommunityTeam;

  @BuiltValueField(compare: false)
  Future<bool> Function({
    required bool isTeam,
    required String type,
  }) get getHasHistory;

  @BuiltValueField(compare: false)
  Future<bool> Function({
    required String fork,
    required String fromAddress,
  }) get checkOnChainData;

  // UI Logic
  static CommunityDetailVM fromStore(Store<AppState> store) {
    return CommunityDetailVM(
      (viewModel) => viewModel
        ..communityTeamList =
            store.state.communityState.communityTeamList?.toBuilder()
        ..communityMemberList =
            store.state.communityState.communityMemberList?.toBuilder()
        ..communityConfig = store.state.communityState.config?.toBuilder()
        ..hasWallet = store.state.walletState.hasWallet
        ..loadData = ({
          required isRefresh,
          required skip,
          required searchName,
          required type,
          required isTeamList,
        }) async {
          await store.dispatchAsync(CommunityActionGetList(
            isRefresh: isRefresh,
            skip: skip,
            searchName: searchName,
            type: type,
            isTeamList: isTeamList,
          ));
          final length = isTeamList
              ? store.state.communityState.communityTeamList?.length
              : store.state.communityState.communityMemberList?.length;
          return Future.value(length ?? 0);
        }
        //..clearCommunityList = ({required isTeamList}) {
        //return store.dispatchAsync(
        //  CommunityActionClearList(isTeamList: isTeamList),
        //);
        // }
        ..getHasHistory = ({required isTeam, required type}) async {
          if (isTeam) {
            final completer = Completer<CommunityTeam>();
            store.dispatch(CommunityActionGetMyTeam(
                //type: int.tryParse(type) ?? 0,
                //completer: completer,
                ));
            final data = await completer.future;
            return data.id != null;
          } else {
            final completer = Completer<CommunityMember>();
            store.dispatch(
              CommunityActionGetMyJoin(
                  //id: type,
                  //completer: completer,
                  ),
            );
            final data = await completer.future;
            return data.id != null;
          }
        }
        ..getCommunityTeam = (teamId) {
          final completer = Completer<CommunityTeam>();
          store.dispatch(
            CommunityActionGetTeamInfo(
                //completer: completer,
                //teamId: teamId,
                ),
          );
          return completer.future;
        }
        ..checkOnChainData = ({required fork, required fromAddress}) {
          final completer = Completer<bool>();
          store.dispatch(
            InvitationActionCheckRelationChild(
              fork: fork,
              fromAddress: fromAddress,
              completer: completer,
            ),
          );
          return completer.future;
        },
    );
  }
}
