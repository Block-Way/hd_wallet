part of wallet_domain_module;

class WalletActionChangePassword extends _BaseAction {
  WalletActionChangePassword(
    this.pwdOld,
    this.pwdNew,
  );
  final String pwdOld;
  final String pwdNew;

  @override
  Future<AppState?> reduce() async {
    final activeWallet = state.walletState.activeWallet;

    if (activeWallet == null) {
      return null;
    }

    final data = await getWalletPrivateData(
      walletId: activeWallet.id,
      walletType: activeWallet.type,
      password: pwdOld,
    );

    // 保存助记词
    await saveWalletPrivateData(
      walletId: data.walletId!,
      password: pwdNew,
      mnemonic: data.mnemonic!,
      privateKey: data.privateKey!,
    );
    return null;
  }
}

// Future<WalletPrivateData> getWalletPrivateData1(
//     {@required String walletId}) async {
//   final activeWallet = store.state.walletState.activeWallet;

//   final encryptMnemonic = await WalletRepository().getWalletMnemonic(
//     walletId,
//   );

//   return WalletPrivateData(
//     walletId: walletId,
//     walletType: walletType,
//     mnemonic: mnemonic,
//     privateKey: privateKey,
//   );
// }

class WalletActionChangeName extends _BaseAction {
  WalletActionChangeName(this.name);
  final String name;

  @override
  Future<AppState?> reduce() async {
    final activeWallet = state.walletState.activeWallet;

    if (activeWallet == null) {
      return null;
    }

    activeWallet.name = name;

    final allWallets = await WalletRepository().saveWallet(
      activeWallet.id,
      activeWallet,
    );

    return state.rebuild(
      (b) => b.walletState
        ..activeWallet = activeWallet
        ..wallets = allWallets,
    );
  }
}

/// Delete current active wallet and select a previous one
class WalletActionDeleteWallet extends _BaseAction {
  WalletActionDeleteWallet();

  @override
  Future<AppState?> reduce() async {
    final activeWallet = state.walletState.activeWallet;

    if (activeWallet == null) {
      return null;
    }

    await activeWallet.delete();

    final allWallets = await WalletRepository().getAllWallets();

    final nextWallet = allWallets.isEmpty ? null : allWallets[0];

    dispatch(AppActionLoadWallet(nextWallet));

    return state.rebuild(
      (b) => b.walletState
        ..activeWalletId = nextWallet?.id
        ..activeWallet = nextWallet
        ..wallets = allWallets,
    );
  }
}
