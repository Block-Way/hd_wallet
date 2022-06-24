part of wallet_domain_module;

abstract class WalletBackupVM
    implements Built<WalletBackupVM, WalletBackupVMBuilder> {
  factory WalletBackupVM([void Function(WalletBackupVMBuilder) updates]) =
      _$WalletBackupVM;
  WalletBackupVM._();

// Fields

// Methods
  @BuiltValueField(compare: false)
  Future Function() get backupSuccess;

  static WalletBackupVM fromStore(Store<AppState> store) {
    return WalletBackupVM(
      (viewModel) => viewModel
        ..backupSuccess = () {
          return store.dispatchAsync(WalletActionWalletDidBackup());
        },
    );
  }
}
