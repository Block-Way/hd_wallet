part of invitation_domain_module;

abstract class InvitationListVM
    implements Built<InvitationListVM, InvitationListVMBuilder> {
  factory InvitationListVM([Function(InvitationListVMBuilder) b]) =
      _$InvitationListVM;
  InvitationListVM._();

// UI Fields
  BuiltList<Invitation> get invitations;

// UI Actions
  @BuiltValueField(compare: false)
  Future<int> Function(bool isRefresh, int skip, AssetCoin coin)
      get loadInvitationList;

  @BuiltValueField(compare: false)
  Future<void> Function() get clearInvitationList;

  @BuiltValueField(compare: false)
  List<AssetCoin> Function() get getInvitationCoins;

// UI Logic
  static InvitationListVM fromStore(Store<AppState> store) {
    return InvitationListVM((viewModel) => viewModel
      ..invitations = ListBuilder(store.state.invitationState.invitations)
      ..getInvitationCoins = () {
        return VMWithInvitation.getInvitationCoins(store);
      }
      ..loadInvitationList = (isRefresh, skip, coin) async {
        await store.dispatchFuture(InvitationActionGetList(
          isRefresh: isRefresh,
          skip: skip,
          coin: coin,
        ));
        return Future.value(store.state.invitationState.invitations.length);
      }
      ..clearInvitationList = () {
        return store.dispatchFuture(InvitationActionClear());
      });
  }
}
