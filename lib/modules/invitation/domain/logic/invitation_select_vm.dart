part of invitation_domain_module;

abstract class InvitationSelectVM
    implements Built<InvitationSelectVM, InvitationSelectVMBuilder> {
  factory InvitationSelectVM(
          [void Function(InvitationSelectVMBuilder) updates]) =
      _$InvitationSelectVM;
  InvitationSelectVM._();

// Fields
  @nullable
  String get walletId;

  BuiltList<InvitationCode> get invitationCodes;

  @BuiltValueField(compare: false)
  Future<WalletPrivateData> Function(String password) get doUnlockWallet;

  @BuiltValueField(compare: false)
  List<AssetCoin> Function() get getInvitationCoins;

  @BuiltValueField(compare: false)
  void Function() get loadInvitationCode;

  @BuiltValueField(compare: false)
  Future<InvitationCode> Function({
    String mnemonic,
    AssetCoin coinInfo,
  }) get createInvitationCode;

  static InvitationSelectVM fromStore(Store<AppState> store) {
    return InvitationSelectVM((viewModel) => viewModel
      ..walletId = store.state.walletState.activeWalletId
      ..invitationCodes =
          store.state.invitationState.invitationCodes.toBuilder()
      ..getInvitationCoins = () {
        return VMWithInvitation.getInvitationCoins(store);
      }
      ..loadInvitationCode = () {
        store.dispatch(InvitationActionLoadCode());
      }
      ..createInvitationCode = ({mnemonic, coinInfo}) {
        final completer = Completer<InvitationCode>();
        store.dispatch(InvitationActionCreateCode(
          mnemonic: mnemonic,
          coinInfo: coinInfo,
          completer: completer,
        ));
        return completer.future;
      }
      ..doUnlockWallet = (password) {
        final completer = Completer<WalletPrivateData>();
        store.dispatch(WalletActionWalletUnlock(password, completer));
        return completer.future;
      });
  }
}
