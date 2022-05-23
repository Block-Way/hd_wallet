part of wallet_domain_module;

abstract class WalletManagementVM
    implements Built<WalletManagementVM, WalletManagementVMBuilder> {
  factory WalletManagementVM([void Function(WalletManagementVMBuilder) b]) =
      _$WalletManagementVM;
  WalletManagementVM._();

// UI Fields
  @nullable
  Wallet get activeWallet;

// Actions
  @BuiltValueField(compare: false)
  Future<WalletPrivateData> Function(String password) get doUnlockWallet;

  @BuiltValueField(compare: false)
  Future<String> Function(String name, String password,
      [String importMnemonic, WalletType type]) get createWallet;

  @BuiltValueField(compare: false)
  Future<void> Function(String pwdOld, String pwdNew) get changePassword;

  @BuiltValueField(compare: false)
  Future<void> Function(String name) get changeName;

  @BuiltValueField(compare: false)
  Future<void> Function() get deleteWallet;

  @BuiltValueField(compare: false)
  Future<void> Function(String mnemonic) get validateMnemonic;

// UI Logic
  static WalletManagementVM fromStore(Store<AppState> store) {
    return WalletManagementVM(
      (viewModel) => viewModel
        ..doUnlockWallet = (password) {
          final completer = Completer<WalletPrivateData>();
          store.dispatch(WalletActionWalletUnlock(password, completer));
          return completer.future;
        }
        ..createWallet = (name, password, [importMnemonic, type]) async {
          final completer = Completer<String>();
          store.dispatch(
            WalletActionCreateFromMnemonic(
              name,
              password,
              importMnemonic,
              type,
              completer,
            ),
          );
          return completer.future;
        }
        ..validateMnemonic = (mnemonic) {
          return store.dispatchFuture(WalletActionValidateMnemonic(mnemonic));
        }
        ..changeName = (name) {
          return store.dispatchFuture(WalletActionChangeName(name));
        }
        ..changePassword = (pwdOld, pwdNew) {
          return store.dispatchFuture(WalletActionChangePassword(
            pwdOld,
            pwdNew,
          ));
        }
        ..deleteWallet = () {
          return store.dispatchFuture(WalletActionDeleteWallet());
        }
        ..activeWallet = store.state.walletState.activeWallet,
    );
  }
}
