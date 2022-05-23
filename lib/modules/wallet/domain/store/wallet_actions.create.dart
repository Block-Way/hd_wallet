part of wallet_domain_module;

class WalletActionCreateFromMnemonic extends _BaseAction {
  WalletActionCreateFromMnemonic(
    this.name,
    this.pwd, [
    this.importMnemonic,
    this.type,
    this.completer,
  ]) : assert(name != null, pwd != null);

  final String name;
  final String pwd;
  final String importMnemonic;
  final WalletType type;
  final Completer<String> completer;

  @override
  Future<AppState> reduce() async {
    var mnemonic = importMnemonic ?? '';
    final isImport = mnemonic.isNotEmpty;

    // Create new Wallet
    if (!isImport) {
      mnemonic = await WalletRepository().generateMnemonic();
    }

    // Import new wallet Or use created
    final coinList = await WalletRepository().importMnemonic(
      mnemonic: mnemonic,
      options: WalletCoreOptions(
        useBip44: type == WalletType.mnemonicBip44,
      ),
    );

    // Check mnemonic, if still empty, wallet creation failed
    if (mnemonic == null || mnemonic.isEmpty) {
      throw WalletMnemonicError();
    }

    // Generate unique wallet ID
    final walletId = await generateWalletId(mnemonic);

    // 加密记词, 保存助记词
    await saveWalletPrivateData(
      walletId: walletId,
      password: pwd,
      mnemonic: mnemonic,
      privateKey: '',
    );

    // 创建本地钱包信息
    final addresses = coinList.entries
        .map(
          (item) => CoinAddress(
            chain: item.key,
            symbol: item.key,
            address: item.value.address,
            publicKey: item.value.publicKey,
          ),
        )
        .toList();

    final existingWallet = await WalletRepository().getWalletById(walletId);

    // Only add wallet if is new, otherwise use existing one
    final walletModel = existingWallet ??
        Wallet(
          id: walletId,
          type: type,
          name: name,
          coins: AppCoins.defaultCoins,
          addresses: addresses,
          // If import Mnemonic, I guess user already did backup
          hasBackup: isImport,
        );

    walletModel.name = name;
    walletModel.addresses = addresses;

    final allWallets = await WalletRepository().saveWallet(
      walletId,
      walletModel,
    );

    dispatch(AppActionLoadWallet(walletModel));

    completer.complete(mnemonic);

    return state.rebuild(
      (b) => b
        ..walletState.activeWalletId = walletId
        ..walletState.activeWallet = walletModel
        ..walletState.wallets = allWallets,
    );
  }

  @override
  Object wrapError(dynamic error) {
    completer.completeError(error);
    return error;
  }
}

class WalletActionCreateFromPrivateKey extends _BaseAction {
  WalletActionCreateFromPrivateKey(
    this.name,
    this.password,
    this.chain,
    this.privateKey,
  ) : assert(name != null, password != null);

  final String name;
  final String password;
  final String chain;
  final String privateKey;

  @override
  Future<AppState> reduce() async {
    // Generate unique wallet ID
    final walletId = await generateWalletId(privateKey);

    // 加密记词, 保存助记词
    await saveWalletPrivateData(
      walletId: walletId,
      password: password,
      mnemonic: '',
      privateKey: privateKey,
    );

    // 创建本地钱包信息

    final existingWallet = await WalletRepository().getWalletById(walletId);

    // Only add wallet if is new, otherwise use existing one
    // TODO: base on chain or add extra parameter for chain
    final walletModel = existingWallet ??
        Wallet(
          id: walletId,
          type: WalletType.privateKey,
          name: name,
          coins: AppCoins.defaultCoins,
          addresses: [],
          hasBackup: true,
        );

    walletModel.name = name;

    final allWallets = await WalletRepository().saveWallet(
      walletId,
      walletModel,
    );

    return state.rebuild(
      (b) => b
        ..walletState.activeWalletId = walletId
        ..walletState.activeWallet = walletModel
        ..walletState.wallets = allWallets,
    );
  }

  @override
  Object wrapError(dynamic error) {
    return error;
  }
}

class WalletActionUpdateAddress extends _BaseAction {
  WalletActionUpdateAddress({
    @required this.mnemonic,
    @required this.completer,
    @required this.chain,
  });

  final String mnemonic;
  final String chain;
  final Completer<bool> completer;

  @override
  Future<AppState> reduce() async {
    final wallet = store.state.walletState.activeWallet;
    final walletId = store.state.walletState.activeWalletId;

    if (!WalletSdkChains.all.contains(chain)) {
      throw AssertionError('$chain not supported in this wallet');
    }

    final coinList = await WalletRepository().importMnemonic(
      mnemonic: mnemonic,
      options: WalletCoreOptions(
        useBip44: wallet.type == WalletType.mnemonicBip44,
      ),
      symbols: [chain],
    );

    // 创建本地钱包信息
    final addresses = coinList.entries
        .map(
          (item) => CoinAddress(
            chain: item.key,
            symbol: item.key,
            address: item.value.address,
            publicKey: item.value.publicKey,
          ),
        )
        .toList();

    final item = addresses.firstWhere((e) => e.chain == chain);
    wallet.updateCoinAddress(
      chain: chain,
      address: item.address,
      publicKey: item.publicKey,
    );

    final allWallets = await WalletRepository().saveWallet(
      walletId,
      wallet,
    );

    dispatch(AppActionLoadWallet(wallet));

    completer.complete(true);

    return state.rebuild(
      (b) => b
        ..walletState.activeWallet = wallet
        ..walletState.wallets = allWallets,
    );
  }

  @override
  Object wrapError(dynamic error) {
    completer.completeError(error);
    return error;
  }
}
