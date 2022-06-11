part of wallet_domain_module;

class WalletRepository {
// Singleton instance

  factory WalletRepository([
    WalletApi? _api,
    FlutterSecureStorage? _storage,
  ]) {
    _instance._api = _api ?? WalletApi();
    _instance._storage = _storage ?? FlutterSecureStorage();
    return _instance;
  }
  WalletRepository._internal();

  static final _instance = WalletRepository._internal();

  late WalletApi _api;
  late FlutterSecureStorage _storage;
  late LazyBox<Wallet> _wallets;
  late LazyBox<List<dynamic>> _broadcasts;
  late LazyBox<List<dynamic>> _unspents;

  static const _walletCacheKey = 'wallets_v1';
  static const _unspentsCacheKey = 'unspents_v1';
  static const _broadcastsCacheKey = 'broadcasts_v1';

  /// Secure storage mnemonic key
  static const _walletPrivateKey = 'hd/wallet';

  /// m/44'/%d'/0'/0/0 兼容imToken
  static const walletPathImToken = "m/44'/%d'/0'/0/0";

  /// imToken
  static const walletPasswordImToken = '';

// Methods

  Future<void> initializeCache() async {
    _wallets = await AppHiveCache.openEncryptedBox<Wallet>(
      _walletCacheKey,
    );
    _broadcasts = await AppHiveCache.openLazyBox<List<dynamic>>(
      _broadcastsCacheKey,
    );
    _unspents = await AppHiveCache.openLazyBox<List<dynamic>>(
      _unspentsCacheKey,
    );
  }

  Future<bool> getWalletStatus({
    required Wallet wallet,
    required String deviceId,
  }) async {
    final json = await _api.getWalletStatus(
      walletId: wallet.id,
      deviceId: deviceId,
    );

    final isSync = json['sync'] == true;

    if (isSync) {
      final registeredCoins = List.from(
        json['wallet_list'] as List<dynamic>,
      ).map(
        (e) => '${e['chain']}-${e['currency']}',
      );

      if (wallet.coins
          .map((e) => '${e.chain}-${e.symbol}')
          .where((e) => !registeredCoins.contains(e))
          .isNotEmpty) {
        return false;
      }
      return registeredCoins.isNotEmpty;
    } else {
      return false;
    }
  }

  Future<void> postWalletRegister(
    Wallet wallet,
    String deviceId,
    dynamic options,
  ) async {
    return _api.postWalletRegister(
      walletId: wallet.id,
      deviceId: deviceId,
      options: options,
      coins: wallet.coins
          .map(
            (e) => {
              'chain': e.chain,
              'device': deviceId,
              'currency': e.symbol,
              'address': wallet.addresses
                  .firstWhere((a) => a.chain == e.chain)
                  .address,
            },
          )
          .toList(),
    );
  }

  Future<Map<String, dynamic>> getFee({
    required String chain,
    required String symbol,
    String? toAddress,
    String? fromAddress,
    String data = '',
  }) {
    return _api.getFee(
      chain: chain,
      symbol: symbol,
      toAddress: toAddress,
      fromAddress: fromAddress,
      data: data,
    );
  }

  Future<Map<String, dynamic>> createtransaction({
    String? toAddress,
    String? fromAddress,
    int? time,
    int? nonce,
    String? amount,
  }) {
    return _api.createtransaction(
      toAddress: toAddress,
      fromAddress: fromAddress,
      time: time,
      nonce: nonce,
      amount: amount,
    );
  }

//  ▼▼▼▼▼▼ Unspent ▼▼▼▼▼▼  //

  Future<List<Map<String, dynamic>>> getUnspentFromApi({
    required String chain,
    required String symbol,
    required String address,
    required String type,
  }) {
    return _api.getUnspent(
      chain: chain,
      symbol: symbol,
      address: address,
      type: type,
    );
  }

  /// null-api error ,[]-balance zero ,[unspent]-nice
  Future<List<Map<String, dynamic>>> getUnspentFromCache({
    required String symbol,
    required String address,
  }) async {
    final list = await _unspents.get('$symbol:$address');
    if (list != null && list.isNotEmpty) {
      return List<Map<String, dynamic>>.from(
        list.map(
          (e) => (e as Map).cast<String, dynamic>(),
        ),
      );
    }

    if (list == null) {
      return [];
    }
    return List.from(list);
  }

  Future<void> saveUnspentToCache({
    required String symbol,
    required String address,
    required List<Map<String, dynamic>> unspent,
  }) async {
    await _unspents.put(
      '$symbol:$address',
      unspent,
    );
  }

  Future<void> clearUnspentCache({
    required String symbol,
    required String address,
  }) async {
    await _unspents.put(
      '$symbol:$address',
      [],
    );
  }

//  ▼▼▼▼▼▼ Manage Wallet ▼▼▼▼▼▼  //

  Future<List<Wallet>> getAllWallets() async {
    final wallets = <Wallet>[];
    final walletsKeys = _wallets.keys;
    for (final walletKey in walletsKeys) {
      wallets.add((await _wallets.get(walletKey))!);
    }
    wallets.sort(
      (a, b) =>
          (a.createdAt.millisecondsSinceEpoch) -
          (b.createdAt.millisecondsSinceEpoch),
    );
    return wallets;
  }

  Future<Wallet?> getWalletById(String walletId) async {
    if (walletId != null) {
      return _wallets.get(walletId);
    }
    return null;
  }

  Future<List<Wallet>> saveWallet(String walletId, Wallet wallet) async {
    wallet.updatedAt = DateTime.now();
    await _wallets.put(walletId, wallet);
    return getAllWallets();
  }

  /// Create new mnemonic
  Future<String?> generateMnemonic() {
    return WalletCore.generateMnemonic();
  }

  /// Validate mnemonic
  Future<bool?> validateMnemonic(String mnemonic) {
    return WalletCore.validateMnemonic(mnemonic);
  }

  /// Validate Address
  Future<bool?> validateAddress({
    required String chain,
    required String address,
  }) {
    return WalletCore.validateAddress(
      chain: chain,
      address: address,
      isBeta: WalletConfigNetwork.getTestNetByChain(chain), // 只有btc 要 beta
    );
  }

  /// Import existing mnemonic
  /// mnemonic 助记词
  /// path xxx
  /// password 钱包标识，一个应用一个password
  Future<Map<String, WalletAddressInfo>> importMnemonic({
    String? mnemonic,
    WalletCoreOptions options = const WalletCoreOptions(),
    List<String>? symbols,
  }) async {
    final keys = await WalletCore.importMnemonic(
      mnemonic: mnemonic!,
      path: walletPathImToken,
      password: walletPasswordImToken,
      symbols: symbols ??
          [
            WalletSdkChains.btc,
            WalletSdkChains.bbc,
            WalletSdkChains.eth,
            WalletSdkChains.trx,
          ],
      options: options,
    );
    return keys;
  }

  Future<String?> exportPrivateKey({
    required String mnemonic,
    required String chain,
    required String forkId,
    WalletCoreOptions options = const WalletCoreOptions(),
  }) {
    return WalletCore.exportPrivateKey(
      symbol: chain,
      mnemonic: mnemonic,
      path: walletPathImToken,
      password: walletPasswordImToken,
      options: options,
    );
  }

  Future<String?> getWalletMnemonic(String walletId) async {
    return _storage.read(key: '${_walletPrivateKey}_mn_$walletId');
  }

  Future<void> setWalletMnemonic(String walletId, String value) async {
    await _storage.write(
        key: '${_walletPrivateKey}_mn_$walletId', value: value);
  }

  Future<String?> getWalletPrivateKey(String walletId) async {
    return _storage.read(key: '${_walletPrivateKey}_pk_$walletId');
  }

  Future<void> setWalletPrivateKey(String walletId, String value) async {
    await _storage.write(
        key: '${_walletPrivateKey}_pk_$walletId', value: value);
  }

  Future<String?> getWalletPassWord(String walletId) async {
    return _storage.read(key: '${_walletPrivateKey}_PW_$walletId');
  }

  Future<void> setWalletPassWord(String walletId, String value) async {
    await _storage.write(
        key: '${_walletPrivateKey}_PW_$walletId', value: value);
  }

  //  ▼▼▼▼▼▼ Save Broadcast TxId ▼▼▼▼▼▼  //

  Future<List<BroadcastTxInfo>> getBroadcastsFromCache(
    String walletId,
  ) async {
    try {
      //final list = await _broadcasts.get(
      //  walletId,
      //  defaultValue: [],
      //);
      return List.from([]);
    } catch (_) {
      return List.from([]);
    }
  }

  Future<void> saveBroadcastsToCache(
    String walletId,
    List<BroadcastTxInfo> broadcasts,
  ) async {
    await _broadcasts.put(
      walletId,
      broadcasts,
    );
  }

  Future<void> clearBroadcastsCache(
    String walletId,
  ) async {
    await _broadcasts.put(
      walletId,
      [],
    );
  }

//  ▼▼▼▼▼▼ Create Withdraw Transaction ▼▼▼▼▼▼  //

  Future<String?> createETHTransaction({
    required int nonce,
    required int gasLimit,
    required String address,
    required int amount,
    required int gasPrice,
    String? contract,
  }) {
    return WalletETH.createETHTransaction(
      nonce: nonce,
      gasLimit: gasLimit,
      address: address,
      amount: amount,
      gasPrice: gasPrice,
      contract: contract!,
    );
  }

  Future<String?> createBTCTransaction({
    required List<Map<String, dynamic>> utxos,
    required String toAddress,
    required double toAmount,
    required String fromAddress,
    required int feeRate,
    required bool beta,
    required bool isGetFee,
  }) {
    return WalletBTC.createBTCTransaction(
      utxos: utxos,
      toAddress: toAddress,
      toAmount: toAmount,
      fromAddress: fromAddress,
      feeRate: feeRate,
      beta: beta,
      isGetFee: isGetFee,
    );
  }

  Future<String> createTRXTransaction({
    required String symbol,
    required String from,
    required String address,
    required int amount,
    required int fee,
  }) {
    return _api.postTRXCreateTransaction(
      chain: 'TRX',
      symbol: symbol,
      from: from,
      amount: amount,
      address: address,
      fee: fee,
    );
  }

//  ▼▼▼▼▼▼ Create DEX Transaction ▼▼▼▼▼▼  //

  Future<double> getDexApproveBalance({
    required String chain,
    required String symbol,
    required String contract,
    required String sellAddress,
    required int chainPrecision,
  }) async {
    final balance = await _api.getDexApproveBalance(
      chain: chain,
      symbol: symbol,
      contract: contract,
      sellAddress: sellAddress,
    );
    return balance != null
        ? NumberUtil.getIntAmountAsDouble(
            balance['balance']?.toString() ?? 0,
            chainPrecision,
          )
        : 0.0;
  }

  Future<double> getDexOrderBalance({
    required String chain,
    required String symbol,
    required String primaryKey,
    required String sellAddress,
    required int chainPrecision,
  }) async {
    final balance = await _api.getDexOrderBalance(
      chain: chain,
      symbol: symbol,
      primaryKey: primaryKey,
      sellAddress: sellAddress,
    );
    return balance != null
        ? NumberUtil.getIntAmountAsDouble(
            balance,
            chainPrecision,
          )
        : 0.0;
  }

  Future<Map<String, dynamic>> dexCreateApproveTransaction({
    required String chain,
    required String symbol,
    required int sellAmount,
    required String sellContract,
    required String sellAddress,
  }) {
    return _api.dexCreateApproveTransaction(
      chain: chain,
      symbol: symbol,
      sellAmount: sellAmount,
      sellContract: sellContract,
      sellAddress: sellAddress,
    );
  }

  Future<Map<String, dynamic>> dexCreateApiOrderTransaction({
    required int fee,
    required int validHeight,
    required int buyAmount,
    required int sellAmount,
    required String chain,
    required String symbol,
    required String buyContract,
    required String sellContract,
    required String recvAddress,
    required String sellAddress,
    required String matchAddress,
    required String dealAddress,
    required String primaryKey,
  }) {
    return _api.getDexOrderCreateRawTx(
      chain: chain,
      symbol: symbol,
      validHeight: validHeight,
      recvAddress: recvAddress,
      sellAddress: sellAddress,
      matchAddress: matchAddress,
      dealAddress: dealAddress,
      buyContract: buyContract,
      sellContract: sellContract,
      sellAmount: sellAmount,
      buyAmount: buyAmount,
      primaryKey: primaryKey,
      fee: fee,
    );
  }

  Future<Map<String, dynamic>> dexCancelOrderTransaction({
    required String chain,
    required String symbol,
    required String primaryKey,
    required String sellAddress,
  }) {
    return _api.getDexOrderCancelRawTx(
      chain: chain,
      symbol: symbol,
      primaryKey: primaryKey,
      sellAddress: sellAddress,
    );
  }

//  ▼▼▼▼▼▼ Sign and Submit Transaction ▼▼▼▼▼▼  //

  Future<String?> signTx({
    required String mnemonic,
    required String chain,
    required String rawTx,
    WalletCoreOptions options = const WalletCoreOptions(),
  }) {
    return WalletCore.signTx(
      mnemonic: mnemonic,
      path: walletPathImToken,
      password: walletPasswordImToken,
      chain: chain,
      rawTx: rawTx,
      options: options,
    );
  }

  Future<String?> signMsg({
    required String mnemonic,
    required String chain,
    required String msg,
    WalletCoreOptions options = const WalletCoreOptions(),
  }) {
    return WalletCore.signMsg(
      mnemonic: mnemonic,
      path: walletPathImToken,
      password: walletPasswordImToken,
      chain: chain,
      msg: msg,
      options: options,
    );
  }

  Future<String?> signMsgWithPKAndBlake({
    required String privateKey,
    required String msg,
  }) {
    return WalletCore.signMsgWithPKAndBlake(
      privateKey: privateKey,
      msg: msg,
    );
  }

  Future<String> submitTransaction({
    required String chain,
    required String symbol,
    required String signedTx,
    required String walletId,
    required String type,
  }) {
    return _api.submitTransaction(
      chain: chain,
      symbol: symbol,
      tx: signedTx,
      walletId: walletId,
      type: type,
    );
  }
}
