part of swap_domain_module;

class SwapRepository {
  factory SwapRepository([SwapApi _api]) {
    _instance._api = _api ?? SwapApi();
    return _instance;
  }
  SwapRepository._internal();

  SwapApi _api;
  static final _instance = SwapRepository._internal();

  static LazyBox<List<dynamic>> _swaps;
  static const swapsKey = 'swaps_v1';

  Future<void> initializeCache() async {
    _swaps = await AppHiveCache.openLazyBox<List<dynamic>>(swapsKey);
  }

  Future<SwapConfig> getConfig() async {
    final json = [[]];
    return SwapConfig.fromJson(json);
    /*
    final json = await _api.getConfig();
    return SwapConfig.fromJson(json);
    */
  }

  Future<double> getApproveBalance({
    @required String chain,
    @required String symbol,
    @required String contract,
    @required String address,
    @required int chainPrecision,
  }) async {
    final balance = await _api.getApproveBalance(
      chain: chain,
      symbol: symbol,
      address: address,
      contract: contract,
    );
    return balance != null
        ? NumberUtil.getIntAmountAsDouble(
            balance ?? 0,
            chainPrecision,
          )
        : 0.0;
  }

  Future<Map<String, dynamic>> postApproveTransaction({
    @required String chain,
    @required String symbol,
    @required String contract,
    @required String address,
    @required int amount,
  }) {
    return _api.postApproveTransaction(
      chain: chain,
      symbol: symbol,
      address: address,
      contract: contract,
      amount: amount,
    );
  }

  Future<Map<String, dynamic>> postCreateTransaction({
    @required String chain,
    @required String symbol,
    @required String fromAddress,
    @required String fromContract,
    @required String toAddress,
    @required String toContract,
    @required int amount,
  }) {
    return _api.postCreateTransaction(
      chain: chain,
      symbol: symbol,
      fromAddress: fromAddress,
      fromContract: fromContract,
      toAddress: toAddress,
      toContract: toContract,
      amount: amount,
    );
  }

  /// ***  Transactions *** ///

  Future<MapEntry<int, List<Map<String, dynamic>>>> getSwapsFromApi({
    @required String walletId,
    @required int page,
    @required int skip,
  }) async {
    final result =
        await _api.getSwapList(skip: page, take: skip, walletId: walletId);
    final count = result.length;
    return MapEntry(count, result);
  }

  Future<List<Swap>> getSwapsFromCache(
    String walletId,
  ) async {
    try {
      final list = await _swaps.get(
        walletId,
        defaultValue: [],
      );
      return List.from(list);
    } catch (_) {
      return List.from([]);
    }
  }

  Future<void> saveSwapsToCache(
    String walletId,
    List<Swap> swaps,
  ) async {
    await _swaps.put(
      walletId,
      swaps,
    );
  }

  Future<void> clearSwapsCache(
    String walletId,
  ) async {
    await _swaps.put(
      walletId,
      [],
    );
  }
}
