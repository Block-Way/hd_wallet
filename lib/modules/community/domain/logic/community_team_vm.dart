part of community_domain_module;

abstract class CommunityTeamVM
    implements Built<CommunityTeamVM, CommunityTeamVMBuilder> {
  factory CommunityTeamVM([void Function(CommunityTeamVMBuilder) updates]) =
      _$CommunityTeamVM;
  CommunityTeamVM._();

  CommunityConfig get communityConfig;

  // Methods
  @BuiltValueField(compare: false)
  Future<CommunityTeam> Function(String teamId) get getCommunityTeam;

  @BuiltValueField(compare: false)
  Future<bool> Function({
    String fork,
    String fromAddress,
  }) get checkOnChainData;

  // UI Logic
  static CommunityTeamVM fromStore(Store<AppState> store) {
    return CommunityTeamVM((viewModel) => viewModel
      ..communityConfig = store.state.communityState.config?.toBuilder()
      ..getCommunityTeam = (teamId) {
        final completer = Completer<CommunityTeam>();
        store.dispatch(CommunityActionGetTeamInfo(
          completer: completer,
          teamId: teamId,
        ));
        return completer.future;
      }
      ..checkOnChainData = ({fork, fromAddress}) {
        final completer = Completer<bool>();
        store.dispatch(InvitationActionCheckRelationChild(
          fork: fork,
          fromAddress: fromAddress,
          completer: completer,
        ));
        return completer.future;
      });
  }
}
