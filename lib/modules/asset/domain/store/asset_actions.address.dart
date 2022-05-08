part of asset_domain_module;

class AssetActionAddressListClear extends _BaseAction {
  @override
  Future<AppState> reduce() async {
    return state.rebuild(
      (a) => a..assetState.addressList.replace([]),
    );
  }
}

class AssetActionAddressListSaveRequestId extends _BaseAction {
  AssetActionAddressListSaveRequestId(this.id);

  final String id;

  @override
  Future<AppState> reduce() async {
    return state.rebuild(
      (a) => a..assetState.addressRequestId = id,
    );
  }
}

class AssetActionAddressList extends _BaseAction {
  AssetActionAddressList(
    this.coinInfo,
    this.requestId, {
    this.isLocal = false,
  });

  final AssetCoin coinInfo;
  final String requestId;
  final bool isLocal;

  @override
  Future<void> before() async {
    await store.dispatchFuture(AssetActionAddressListSaveRequestId(requestId));
  }

  @override
  Future<AppState> reduce() async {
    var result = <AssetAddress>[];
    if (isLocal) {
      final wallets = store.state.walletState.wallets
          .where((e) => e.id != store.state.walletState.activeWalletId);
      if (wallets != null && wallets.isNotEmpty) {
        for (final wallet in wallets) {
          final address = wallet.getCoinAddressByChain(coinInfo.chain);
          if (address != null && address.isNotEmpty) {
            result.add(AssetAddress.fromLocal(
              walletName: wallet.name,
              address: address,
              chain: coinInfo.chain,
              symbol: coinInfo.symbol,
            ));
          }
        }
      }
    } else {
      final walletId = store.state.walletState.activeWalletId;
      result = await AssetRepository().getAddressList(
        walletId: walletId,
        chain: coinInfo.chain,
        symbol: coinInfo.symbol,
      );
    }

    if (state.assetState.addressRequestId != requestId) {
      return null;
    }

    return state.rebuild(
      (a) => a..assetState.addressList.replace(result),
    );
  }
}

class AssetActionAddressEdit extends _BaseAction {
  AssetActionAddressEdit(
    this.coinInfo,
    this.assetAddress, {
    this.isDelete = false,
  });
  final AssetCoin coinInfo;
  final AssetAddress assetAddress;
  final bool isDelete;

  @override
  Future<AppState> reduce() async {
    final walletId = store.state.walletState.activeWalletId;
    // delete
    if (isDelete == true) {
      await AssetRepository().submitAddressDelete(
        walletId: walletId,
        chain: coinInfo.chain,
        symbol: coinInfo.symbol,
        addressId: assetAddress.id,
      );
      // edit
    } else if (assetAddress.id != null && assetAddress.id.isNotEmpty) {
      await AssetRepository().submitAddressEdit(
        walletId: walletId,
        chain: coinInfo.chain,
        symbol: coinInfo.symbol,
        addressId: assetAddress.id,
        address: assetAddress.address,
        comments: assetAddress.comments,
      );
      // add
    } else if (assetAddress != null) {
      await AssetRepository().submitAddressAdd(
        walletId: walletId,
        chain: coinInfo.chain,
        symbol: coinInfo.symbol,
        addressId: assetAddress.id,
        address: assetAddress.address,
        comments: assetAddress.comments,
      );
    }

    try {
      await store.dispatchFuture(AssetActionAddressList(coinInfo, ''));
    } catch (_) {}
    return null;
  }
}
