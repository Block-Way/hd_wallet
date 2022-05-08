part of wallet_domain_module;

abstract class _BaseAction extends ReduxAction<AppState> {
  //
}

class WalletActionGetUnspent extends _BaseAction {
  WalletActionGetUnspent({
    @required this.chain,
    @required this.symbol,
    @required this.address,
    @required this.completer,
    @required this.balance,
    this.unspentType,
    this.forceUpdate = false,
  });

  final String chain;
  final String symbol;
  final String address;
  final bool forceUpdate;
  final double balance;
  final String unspentType;
  final Completer<List<Map<String, dynamic>>> completer;

  @override
  Future<AppState> reduce() async {
    if (!kChainsNeedUnspent.contains(chain)) {
      completer.complete(null);
      return null;
    }

    final cacheUnspent = await WalletRepository().getUnspentFromCache(
      symbol: symbol,
      address: address,
    );
    var unspent = <Map<String, dynamic>>[];
    if (forceUpdate ||
        cacheUnspent == null ||
        (cacheUnspent.isEmpty && balance > 0)) {
      unspent = await WalletRepository().getUnspentFromApi(
        chain: chain,
        symbol: symbol,
        address: address,
        type: unspentType,
      );
      await WalletRepository().saveUnspentToCache(
        symbol: symbol,
        address: address,
        unspent: unspent,
      );
    } else {
      unspent = cacheUnspent;
    }

    if (unspent == null || unspent.isEmpty) {
      dispatch(AssetActionResetCoinBalance(
        wallet: store.state.walletState.activeWallet, // TODO: check
        chain: chain,
        symbol: symbol,
        address: address,
      ));
    }

    completer.complete(unspent);

    return null;
  }

  @override
  Object wrapError(dynamic error) {
    WalletRepository().saveUnspentToCache(
      symbol: symbol,
      address: address,
      unspent: null,
    );

    completer.completeError(error);
    return error;
  }
}

class WalletActionValidateMnemonic extends _BaseAction {
  WalletActionValidateMnemonic(this.mnemonic);
  final String mnemonic;

  @override
  Future<AppState> reduce() async {
    await WalletRepository().validateMnemonic(mnemonic);
    return null;
  }

  @override
  Object wrapError(dynamic error) {
    return error;
  }
}

class WalletActionValidateAddress extends _BaseAction {
  WalletActionValidateAddress({this.chain, this.address, this.completer});
  final String chain;
  final String address;
  final Completer<bool> completer;

  @override
  Future<AppState> reduce() async {
    await WalletRepository().validateAddress(
      chain: chain,
      address: address,
    );
    completer.complete(true);
    return null;
  }

  @override
  Object wrapError(dynamic error) {
    completer.complete(false);
    return error;
  }
}
