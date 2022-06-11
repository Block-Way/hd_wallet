part of asset_domain_module;

class AssetApi {
  /// **** Prices ****
  /*
  Future<Map<String, dynamic>> getExchangeRates() => Request().getObject(
        '/v1/exchange_rate',
      );

  Future<Map<String, dynamic>> getPrices() async {
    return {}; // Request().getObject('/price');
  }

  Future<Map<String, dynamic>> getDexPrices() async => Request().getObject(
        '/v1/dex/latest_price',
      );

  Future<Map<String, dynamic>> getCoinPrice(
    String tradePairId,
  ) async =>
      Request().getObject(
        '/v1/dex/latest_price/${tradePairId.replaceAll('/', '|')}',
      );
  */
  /// **** Balance ****

  //获取交易费信息
  Future<Map<String, dynamic>> getTransactionFeeInformation({
    required String symbol,
    required String address,
  }) async {
    final dio = Dio();
    final response = await dio.get(
        '${AppConstants.randomApiUrl}/fee?address=$address&symbol=$symbol');
    final data = response.data;
    return data as Map<String, dynamic>;
  }

  //获得投票节点的方法
  Future<List<dynamic>> getVoteNodeList() async {
    final dio = Dio();
    final response = await dio.get('${AppConstants.randomApiUrl}/listdelegate');
    final data = response.data;
    return data as List<dynamic>;
  }

  // 获取投票地址的方法
  Future<Map<String, dynamic>> getVoteNodeDetail({
    required String delegate,
    required String owner,
    required int rewardmode,
  }) async {
    final dio = Dio();
    final response = await dio.post('${AppConstants.randomApiUrl}/GetVote',
        data: {'delegate': delegate, "owner": owner, "rewardmode": rewardmode});
    final data = response.data;
    return data as Map<String, dynamic>;
  }

  /*
  Future<Map<String, dynamic>> createTransaction({
    required dynamic time,
    required String fork,
    required dynamic nonce,
    required dynamic from,
    required dynamic to,
    required String amount,
    required dynamic gasprice,
    required dynamic gaslimit,
    required String data,
  }) async {
    final dio = Dio();
    final response =
        await dio.post('${AppConstants.randomApiUrl}/createtransaction', data: {
      "time": time,
      "fork": fork,
      "nonce": nonce,
      "from": from,
      "to": to,
      "amount": amount,
      "gasprice": gasprice,
      "gaslimit": gaslimit,
      "data": data
    });
    print(response.data);
    final resData = response.data;
    return resData;
  }*/

  Future<dynamic> submitTransaction({
    required String hex,
  }) async {
    final dio = Dio();
    final response =
        await dio.get('${AppConstants.randomApiUrl}/sendtransaction?hex=$hex');
    final resData = response.data;
    return resData;
  }

  // Future<String> getCoinBalance({
  //   @required String chain,
  //   @required String symbol,
  //   @required String address,
  // }) =>
  //     Request().getValue<String>(
  //       '/v1/hd/wallet/$chain/$symbol/$address/balance',
  //     );

  Future<Map<String, dynamic>> getCoinBalanceWithUnconfirmed({
    required String chain,
    required String symbol,
    required String address,
  }) async {
    final dio = Dio();
    final response = await dio.get(
        '${AppConstants.randomApiUrl}/balance?address=$address&symbol=$symbol');
    final data = response.data;
    return data as Map<String, dynamic>;
  } //=>
  // Request().getObject(
  //   '/v2/hd/wallet/$chain/$symbol/$address/balance',
  // );

  /// **** Transactions ****

  Future<List<Map<String, dynamic>>> getCoinTransactions({
    required String chain,
    required String symbol,
    required String address,
    required int page,
    int take = 10,
  }) async {
    final dio = Dio();
    final response = await dio.get(
        '${AppConstants.randomApiUrl}/transaction?address=$address&symbol=$symbol&page=$page&take=$take');
    final data = response.data;
    return data as List<Map<String, dynamic>>;
    /*
    return List<Map<String, dynamic>>.from(
      // ignore: avoid_dynamic_calls
      data.map(
        (e) => Map<String, dynamic>.from(e as Map<String, dynamic>),
      ),
    );*/
  }

  Future<List<Map<String, dynamic>>> getEthTransactions(
    String address,
    int page, [
    int take = 10,
  ]) async {
    return [];
  }
}
