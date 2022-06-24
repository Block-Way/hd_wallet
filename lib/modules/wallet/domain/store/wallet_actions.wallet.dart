part of wallet_domain_module;

//** HD Wallet Load/Unlock **//

class WalletActionWalletLoadAll extends _BaseAction {
  @override
  Future<AppState?> reduce() async {
    final settings = CommonRepository().getSettings();
    final activeWalletId = settings?.activeWalletId;
    if (activeWalletId == null) {
      return null;
    }
    final allWallets = await WalletRepository().getAllWallets();
    final activeWallet = await WalletRepository().getWalletById(
      activeWalletId,
    );
    return state.rebuild(
      (b) => b.walletState
        ..wallets = allWallets
        ..activeWallet = activeWallet
        ..activeWalletId = activeWalletId,
    );
  }

  @override
  Object? wrapError(dynamic error) {
    CrashesReport().reportEvent(
      'WalletLog_01_LoadAllWallets',
      error,
      StackTrace.current,
    );
    return error;
  }
}

class WalletActionWalletSetActive extends _BaseAction {
  WalletActionWalletSetActive(this.wallet);
  final Wallet wallet;

  @override
  Future<AppState?> reduce() async {
    final settings = CommonRepository().getSettings();
    if (settings?.activeWalletId == wallet.id) {
      return null;
    }
    settings?.activeWalletId = wallet.id;
    await settings?.save();

    return state.rebuild(
      (a) => a
        ..walletState.activeWallet = wallet
        ..walletState.activeWalletId = wallet.id,
    );
  }
}

class WalletActionWalletRemoveAll extends _BaseAction {
  @override
  Future<AppState> reduce() async {
    final wallets = state.walletState.wallets;
    if (wallets != null && wallets.isNotEmpty) {
      for (final _ in wallets) {
        await store.dispatchAsync(WalletActionDeleteWallet());
        await Future.delayed(Duration(milliseconds: 200));
      }
    }
    return state.rebuild(
      (b) => b.walletState
        ..activeWalletId = null
        ..activeWallet = null
        ..wallets = [],
    );
  }
}

class WalletActionWalletUnlock extends _BaseAction {
  WalletActionWalletUnlock(
    this.password,
    this.completer,
  );
  final String password;
  final Completer<WalletPrivateData> completer;

  @override
  Future<AppState?> reduce() async {
    final activeWallet = state.walletState.activeWallet;

    WalletPrivateData data;
    if (activeWallet!.isDevice) {
      data = await getWalletDevicePrivateData(
        walletId: activeWallet.id,
      );
    } else {
      data = await getWalletPrivateData(
        walletId: activeWallet.id,
        walletType: activeWallet.type,
        password: password,
      );
    }

    completer.complete(data);
    return null;
  }

  @override
  Object? wrapError(dynamic error) {
    completer.completeError(error as Object);
    return error;
  }
}

class WalletActionWalletRegister extends _BaseAction {
  WalletActionWalletRegister(
    this.wallet, {
    this.withOptions = true,
  });
  final Wallet wallet;
  final bool withOptions;

  @override
  Future<AppState?> reduce() async {
    if (wallet != null) {
      // Status is not update in AllWallet list
      // if (wallet.status == WalletStatus.synced &&
      //     DateTime.now().difference(wallet.updatedAt).inMinutes < 5) {
      //   return null;
      // }

      final options =
          withOptions == true ? await CrashesReport().getAppContexts() : null;
      await WalletRepository().postWalletRegister(
        wallet,
        state.commonState.deviceId!,
        withOptions == true ? options?.toJson() : [],
      );
    }
    return null;
  }

  @override
  void after() {
    dispatch(WalletActionWalletCheckStatus(
      wallet: wallet,
      forceCheck: true,
    ));
  }
}

class WalletActionWalletCheckStatus extends _BaseAction {
  WalletActionWalletCheckStatus({
    required this.wallet,
    required this.forceCheck,
    this.completer,
  });
  final Wallet wallet;
  final bool forceCheck;
  final Completer<WalletStatus>? completer;

  @override
  void before() {
    dispatch(WalletActionWalletUpdateStatus(wallet, WalletStatus.loading));
  }

  @override
  Future<AppState?> reduce() async {
    if (wallet.status != WalletStatus.synced || forceCheck == true) {
      /* 不用向服务器查询状态，一切都是OK的
      final isSynced = await WalletRepository().getWalletStatus(
        wallet: wallet,
        deviceId: state.commonState.deviceId,
      );
      var status = isSynced ? WalletStatus.synced : WalletStatus.notSynced;
      dispatch(WalletActionWalletUpdateStatus(wallet, status));
      completer?.complete(status);
      */
      dispatch(WalletActionWalletUpdateStatus(wallet, WalletStatus.synced));
      completer?.complete(WalletStatus.synced);
    }
    return null;
  }

  @override
  Object? wrapError(dynamic error) {
    dispatch(WalletActionWalletUpdateStatus(wallet, WalletStatus.unknown));
    completer?.complete(WalletStatus.unknown);
    return error;
  }
}

class WalletActionWalletUpdateStatus extends _BaseAction {
  WalletActionWalletUpdateStatus(
    this.wallet,
    this.walletStatus,
  );
  final Wallet wallet;
  final WalletStatus walletStatus;

  @override
  AppState? reduce() {
    wallet.updateStatus(status: WalletStatus.unknown);

    if (wallet.id == state.walletState.activeWalletId) {
      return state.rebuild(
        (a) => a..walletState.activeWalletStatus = walletStatus,
      );
    }

    return null;
  }
}

class WalletActionWalletDidBackup extends _BaseAction {
  @override
  Future<AppState> reduce() async {
    final activeWallet = state.walletState.activeWallet;

    activeWallet?.hasBackup = true;

    final allWallets = await WalletRepository().saveWallet(
      activeWallet!.id,
      activeWallet,
    );

    return state.rebuild((a) => a..walletState.wallets = allWallets);
  }
}

class WalletActionWalletFromEnv extends _BaseAction {
  WalletActionWalletFromEnv([this.count]);

  final int? count; // 新建钱包的数量

  @override
  Future<AppState?> reduce() async {
    // 新建钱包
    if (count != null) {
      for (var index = 0; index < count!; index++) {
        final completer = Completer<String>();
        WalletActionCreateFromMnemonic(
          'test_wallet_$index',
          'Qq111111',
          '',
          WalletType.mnemonicBip44,
          completer,
        );
        completer.future.then((value) {
          //
        });
      }

      return null;
    }

    await DotEnv().load(fileName: '.env.dev');
    for (var index = 1; index < 20; index++) {
      final mnemonic = DotEnv().env['TEST_MNEMONIC_$index'];
      final name = DotEnv().env['TEST_MNEMONIC_NAME_$index'];
      if (mnemonic != null) {
        await dispatchAsync(
          WalletActionCreateFromMnemonic(
            name ?? 'test_wallet_$index',
            'Qq111111',
            mnemonic,
            WalletType.mnemonicBip44,
            Completer(),
          ),
        );
      }
    }
    return null;
  }
}
