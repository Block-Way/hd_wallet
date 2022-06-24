part of asset_domain_module;

class AssetTransactionCubit extends AssetDetailCubit {
  AssetTransactionCubit([AssetRepository? assetRepository])
      : super(assetRepository) {
    _assetRepository = assetRepository ?? AssetRepository();
  }

  late AssetRepository _assetRepository;

  void updateList(List<Transaction> list) {
    emit(list);
  }

  @override
  Future<int> loadAll({
    required AssetCoin coin,
    required bool isRefresh,
    required int page,
    required int skip,
    required bool onlyCache,
  }) async {
    final allTransactions = await _assetRepository.getTransactionsFromCache(
      symbol: coin.symbol ?? '',
      address: coin.address ?? '',
    );

    if (onlyCache == true) {
      allTransactions.sort(
        (a, b) => b.timestamp == a.timestamp
            ? b.txId!.compareTo(b.txId ?? '')
            : (b.timestamp ?? 0).compareTo(a.timestamp ?? 0),
      );
      emit(allTransactions);
      return allTransactions.length;
    }

    // ↓↓↓↓↓↓↓↓↓↓ net data ↓↓↓↓↓↓↓↓↓↓
    final apiResult = await _assetRepository.getTransactionsFromApi(
      chain: coin.chain ?? '',
      symbol: coin.symbol ?? '',
      address: coin.address ?? '',
      contract: coin.contract ?? '',
      page: page,
      skip: skip,
    );
    final rawData = apiResult.value;
    final apiDataCount = apiResult.key;

    var newTransactions = <Transaction>[];
    switch (coin.chain) {
      case 'ETH':
        newTransactions = rawData
            .map(
              (e) => Transaction.fromEthTx(
                coin.symbol ?? '',
                coin.address ?? '',
                coin.chainPrecision ?? 0,
                e as Map<String, dynamic>,
              ),
            )
            .toList();
        break;
      case 'BTC':
        newTransactions = rawData
            .map(
              (e) => Transaction.fromBtcTx(
                coin.symbol ?? '',
                coin.address ?? '',
                e as Map<String, dynamic>,
              ),
            )
            .toList();
        break;
      case 'BBC':
        newTransactions = rawData
            .map(
              (e) => Transaction.fromBbcTx(
                coin.symbol ?? '',
                coin.address ?? '',
                e as Map<String, dynamic>,
              ),
            )
            .toList();
        break;
      case 'TRX':
        newTransactions = rawData
            .map(
              (e) => Transaction.fromTrxTx(
                coin.symbol ?? '',
                coin.address ?? '',
                e as Map<String, dynamic>,
              ),
            )
            .toList();
        break;
      default:
    }

    final ids = newTransactions.map((e) => e.txId).toSet();

    // cache
    allTransactions.retainWhere((x) => !ids.contains(x.txId ?? ''));

    allTransactions.addAll(newTransactions);

    // Fix Api returned null txId
    allTransactions.retainWhere((x) => x.txId != 'null');

    allTransactions.sort(
      (a, b) => b.timestamp == a.timestamp
          ? b.txId!.compareTo(b.txId ?? '')
          : (b.timestamp ?? 0).compareTo(a.timestamp ?? 0),
    );

    await AssetRepository().saveTransactionsToCache(
      symbol: coin.symbol ?? '',
      address: coin.address ?? '',
      transactions: allTransactions.toList(),
    );

    // 展示用数据
    final subEnd = (page + 1) * skip;
    final allLength = allTransactions.length;
    final displayData =
        allTransactions.sublist(0, subEnd <= allLength ? subEnd : allLength);

    final dataCount = coin.chain == 'TRX' && apiDataCount == skip
        ? subEnd
        : displayData.length;

    emit(displayData);

    return dataCount;
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
  }
}
