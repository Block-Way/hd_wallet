part of asset_domain_module;

abstract class _BaseAction extends ReduxAction<AppState> {
  //
}

class AssetActionSyncWalletCoins extends _BaseAction {
  AssetActionSyncWalletCoins(this.wallet);
  final Wallet wallet;

  @override
  Future<AppState> reduce() async {
    if (wallet == null) {
      return state.rebuild((a) => a..assetState.coins = ListBuilder([]));
    }

    final walletCoins = wallet.coins ?? [];
    final configCoins = store.state.commonState.config?.coins?.values ?? [];

    // If needed remove faulty coins
    walletCoins.removeWhere((e) => [].contains(e.symbol));

    // We take the config coins as the good ones
    configCoins.toList().forEach((remote) {
      // Update local coin with config infos (icon, name, etc)
      final existing = walletCoins?.firstWhere(
        (local) => local.symbol == remote.symbol && local.chain == remote.chain,
        orElse: () => null,
      );
      if (existing != null) {
        existing.name = remote.name;
        existing.fullName = remote.fullName;
        existing.iconOnline = remote.icon;
        existing.contract = remote.contract ?? '';
        existing.chainPrecision = remote.chainPrecision;
        existing.displayPrecision = remote.displayPrecision;
        existing.isFixed = kDefaultCoinFixed.contains(remote.symbol);
        existing.isEnabled = true; // kDefaultCoinFixed.contains(remote.symbol);
        if (kDebugMode) {
          // Only in Debug mode update chain with API config
          existing.chain = remote.chain;
        }
      } else {
        walletCoins.add(
          CoinInfo(
            chain: remote.chain,
            symbol: remote.symbol,
            contract: remote.contract,
            name: remote.name,
            fullName: remote.fullName,
            iconLocal: '',
            iconOnline: remote.icon,
            chainPrecision: remote.chainPrecision,
            displayPrecision: remote.displayPrecision,
            isFixed: kDefaultCoinFixed.contains(remote.symbol),
            isEnabled: true, // kDefaultCoinFixed.contains(remote.symbol),
          ),
        );
      }
    });

    // Disable coins without address
    for (final e in walletCoins) {
      final address = wallet.getCoinAddressByChain(e.chain);
      if (address == null || address.isEmpty) {
        e.isEnabled = false;
      }
    }

    // If we have configCoins, then we might had some changes to save
    if (configCoins.isNotEmpty) {
      wallet.coins = walletCoins;
      // TODO: covert in action WalletActionUpdateWallet
      await WalletRepository().saveWallet(wallet.id, wallet);
    }

    final assetCoins = wallet.coins.map(
      (e) => AssetCoin(
        (a) => a
          ..chain = e.chain
          ..symbol = e.symbol
          ..name = e.name
          ..fullName = e.fullName
          ..iconLocal = e.iconLocal
          ..iconOnline = e.iconOnline
          ..chainPrecision = e.chainPrecision ?? 18
          ..displayPrecision = e.displayPrecision ?? 8
          ..address = wallet.getCoinAddressByChain(e.chain)
          ..balance = wallet.getCoinBalance(
            chain: e.chain,
            symbol: e.symbol,
          )
          ..balanceUnconfirmed = wallet.getCoinBalanceUnconfirmed(
            chain: e.chain,
            symbol: e.symbol,
          )
          ..isEnabled = e.isEnabled
          ..isFixed = e.isFixed
          ..contract = e.contract,
      ),
    );

    // Set Initial balance in cubit
    for (final coin in assetCoins) {
      GetIt.I<AssetBalanceCubit>().updateBalance(
        symbol: coin.symbol,
        address: coin.address,
        balance: coin.balance,
        unconfirmed: coin.balanceUnconfirmed,
      );
    }

    return state.rebuild((a) => a..assetState.coins.replace(assetCoins));
  }

  @override
  Object wrapError(dynamic error) {
    CrashesReport().reportEvent(
      'AssetLog_01_SyncWalletCoins',
      error,
      StackTrace.current,
    );
    return error;
  }
}

class AssetActionToggleHideSmallAssets extends _BaseAction {
  AssetActionToggleHideSmallAssets({this.hide});
  final bool hide;

  @override
  Future<AppState> reduce() async {
    return state.rebuild((a) => a..assetState.hideSmallAssets = hide);
  }
}

class AssetActionSearchCoin extends _BaseAction {
  AssetActionSearchCoin(this.searchTerm);
  String searchTerm;

  @override
  AppState reduce() {
    return state.rebuild((a) => a..assetState.coinsSearchTerm = searchTerm);
  }
}
