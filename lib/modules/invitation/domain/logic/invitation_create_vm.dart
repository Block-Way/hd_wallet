part of invitation_domain_module;

abstract class InvitationCreateVM
    with VMWithWalletWithdraw
    implements Built<InvitationCreateVM, InvitationCreateVMBuilder> {
  factory InvitationCreateVM(
          [void Function(InvitationCreateVMBuilder) updates]) =
      _$InvitationCreateVM;
  InvitationCreateVM._();

// Fields
  @nullable
  String get walletId;

// Withdraw Methods
  @override
  @BuiltValueField(compare: false)
  Future<WalletWithdrawData> Function(
    WithdrawBeforeParams params,
    WalletWithdrawData previousData,
  ) get onWithdrawBefore;

  @override
  @BuiltValueField(compare: false)
  Future<String> Function(
    WithdrawSubmitParams params,
    WalletPrivateData walletData, [
    Future<bool> Function() onConfirmSubmit,
  ]) get submit;

  @BuiltValueField(compare: false)
  Future<void> Function({
    AssetCoin coinInfo,
    String toAddress,
    String signCode,
    String sharePrvKey,
    String amount,
    Future<WalletPrivateData> Function() onUnlockWallet,
    void Function(String txId) onSuccessTransaction,
    Future<bool> Function(WalletWithdrawData withdrawData) onConfirmParams,
    Future<bool> Function() onConfirmSubmit,
  }) get doSubmitInvitation;

  @override
  @BuiltValueField(compare: false)
  double Function({
    @required String chain,
    @required String symbol,
  }) get getCoinBalance;

  @override
  @BuiltValueField(compare: false)
  AssetCoin Function({
    @required String chain,
    @required String symbol,
  }) get getCoinInfo;

  @override
  @BuiltValueField(compare: false)
  Future<WalletPrivateData> Function(String password) get doUnlockWallet;

//  Methods
  @BuiltValueField(compare: false)
  Future<bool> Function(String fork, String toAddress) get checkDefiRelation;

  @BuiltValueField(compare: false)
  List<AssetCoin> Function() get getInvitationCoins;

  static InvitationCreateVM fromStore(Store<AppState> store) {
    return InvitationCreateVM((viewModel) => viewModel
      ..walletId = store.state.walletState.activeWalletId
      ..getInvitationCoins = () {
        return VMWithInvitation.getInvitationCoins(store);
      }
      ..onWithdrawBefore = (params, previousData) {
        final completer = Completer<WalletWithdrawData>();
        store.dispatch(WalletActionWithdrawBefore(
          params: params,
          completer: completer,
          previousData: previousData,
        ));
        return completer.future;
      }
      ..submit = (_, __, [___]) {
        return Future.value('');
      }
      ..doUnlockWallet = (password) {
        final completer = Completer<WalletPrivateData>();
        store.dispatch(WalletActionWalletUnlock(password, completer));
        return completer.future;
      }
      ..doSubmitInvitation = ({
        coinInfo,
        toAddress,
        signCode,
        sharePrvKey,
        amount,
        onUnlockWallet,
        onSuccessTransaction,
        onConfirmParams,
        onConfirmSubmit,
      }) {
        return store.dispatchFuture(InvitationActionCreateSubmit(
          coinInfo: coinInfo,
          toAddress: toAddress,
          signCode: signCode,
          sharePrvKey: sharePrvKey,
          amount: amount,
          onUnlockWallet: onUnlockWallet,
          onSuccessTransaction: onSuccessTransaction,
          onConfirmParams: onConfirmParams,
          onConfirmSubmit: onConfirmSubmit,
        ));
      }
      ..getCoinInfo = ({chain, symbol}) {
        return VMWithWalletGetCoinInfoImplement.getCoinInfo(
          store,
          chain: chain,
          symbol: symbol,
        );
      }
      ..getCoinBalance = ({chain, symbol}) {
        return VMWithAssetGetCoinBalanceImplement.getCoinBalance(
          store,
          chain: chain,
          symbol: symbol,
        );
      }
      ..checkDefiRelation = (fork, toAddress) {
        final completer = Completer<bool>();
        store.dispatch(InvitationActionCheckRelationParent(
          fork: fork,
          toAddress: toAddress,
          completer: completer,
        ));
        return completer.future;
      });
  }
}
