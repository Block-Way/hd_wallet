part of asset_domain_module;

class AssetApi {
  /// **** Prices ****

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

  /// **** Balance ****

  //获取交易费信息
  Future<Map<String, dynamic>> getTransactionFeeInformation({
    @required String symbol,
    @required String address,
  }) async {
    final dio = Dio();
    final response = await dio.get(
        '${AppConstants.randomApiUrl}/fee?address=$address&symbol=$symbol');
    final data = response.data;
    return data; // data as Map<String, dynamic>;
  }

  //获得投票节点的方法
  Future<List<dynamic>> getVoteNodeList() async {
    final dio = Dio();
    final response = await dio.get('${AppConstants.randomApiUrl}/listdelegate');
    final data = response.data;
    return data; // data as Map<String, dynamic>;
  }

  // 获取投票地址的方法
  Future<Map<String, dynamic>> getVoteNodeDetail({
    @required String delegate,
    @required String owner,
    @required int rewardmode,
  }) async {
    final dio = Dio();
    final response = await dio.post('${AppConstants.randomApiUrl}/GetVote',
        data: {'delegate': delegate, "owner": owner, "rewardmode": rewardmode});
    final data = response.data;
    print("投票地址请求=============== 》");
    return data;
  }

  // 投票/撤投
  Future<Map<String, dynamic>> createTransaction({
    @required dynamic time,
    @required String fork,
    @required dynamic nonce,
    @required dynamic from,
    @required dynamic to,
    @required String amount,
    @required dynamic gasprice,
    @required dynamic gaslimit,
    @required String data
  }) async {
    final dio = Dio();
    final response = await dio.post(
        '${AppConstants.randomApiUrl}/createtransaction',
        data: {
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
    print("投票 撤投 =============== 》");
    print(response.data);
    final resData = response.data;
    return resData;
  }

  // 发送交易
  Future<dynamic> submitTransaction({
    @required String hex,
  }) async {
    final dio = Dio();
    final response =
    await dio.get('${AppConstants.randomApiUrl}/sendtransaction?hex=$hex');
    dynamic resData = response.data;
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

  //获取余额
  Future<Map<String, dynamic>> getCoinBalanceWithUnconfirmed({
    @required String chain,
    @required String symbol,
    @required String address,
  }) async {
    final dio = Dio();
    final response = await dio.get(
        '${AppConstants.randomApiUrl}/balance?address=$address&symbol=$symbol');
    final data = response.data;
    print('拿到的余额数据 $data');
    return data; // data as Map<String, dynamic>;
  } //=>
  // Request().getObject(
  //   '/v2/hd/wallet/$chain/$symbol/$address/balance',
  // );

  Future<String> getBtcBalance(
    String address,
  ) =>
      Request().getExternalObject<String>(
        '/address/$address',
        baseUrl: 'https://chain.api.btc.com/v3',
        onResponse: (response) {
          if (response?.data == null ||
              response.data is String ||
              response.data['data'] == null) {
            return null;
          }
          return NumberUtil.getIntAmountAsDouble(
            response.data['data']['balance'],
            8,
          ).toString();
        },
      );

  Future<String> getEthTokenBalance({
    @required String address,
    @required String contract,
  }) =>
      Request().getExternalObject<String>(
        '/api?module=account&action=tokenbalance&contractaddress=$contract&address=$address&tag=latest&apikey=${AppConstants.etherscanApiKey}',
        baseUrl: WalletConfigNetwork.eth
            ? 'https://api-ropsten.etherscan.io'
            : 'https://api-cn.etherscan.com',
        onResponse: (response) {
          if (response?.data == null ||
              response.data is String ||
              response.data['result'] == null) {
            return null;
          }
          return response.data['result']?.toString();
        },
      );

  Future<List<Map<String, dynamic>>> searchEthTokens(String term) =>
      Request().getExternalListOfObjects(
        '/api?module=account&action=tokenbalance&contractaddress=&tag=latest&apikey=${AppConstants.etherscanApiKey}',
        baseUrl: WalletConfigNetwork.eth
            ? 'https://api-ropsten.etherscan.io'
            : 'https://api-cn.etherscan.com',
        onResponse: (response) {
          return response.data['list'];
        },
      );

  /// **** Transactions ****

  Future<Map<String, dynamic>> getSingleTransaction({
    @required String chain,
    @required String symbol,
    @required String txId,
    @required String walletId,
  }) =>
      Request().getObject(
        '/v1/hd/wallet/$chain/$symbol/$txId/transaction_info',
      );

  Future<List<Map<String, dynamic>>> getCoinTransactions({
    @required String chain,
    @required String symbol,
    @required String address,
    @required int page,
    int take = 10,
  }) async {
    final dio = Dio();
    final response = await dio.get(
        '${AppConstants.randomApiUrl}/transaction?address=$address&symbol=$symbol&page=$page&take=$take');
    final data = response.data;
    return List<Map<String, dynamic>>.from(
      data.map(
        (e) => Map<String, dynamic>.from(e as Map<String, dynamic>),
      ),
    );
  }

  /*
  =>
      Request().getListOfObjects(
        '/v1/hd/wallet/$chain/$symbol/$address/transaction?page=$page&take=$take',
      );
*/

  Future<List<Map<String, dynamic>>> getEthTransactions(
    String address,
    int page, [
    int take = 10,
  ]) async {
    return [];
  }

  Future<List<Map<String, dynamic>>> getBtcTransactions(
    String address,
    int page, [
    int take = 10,
  ]) =>
      Request().getExternalListOfObjects(
        '/address/$address/tx?page=$page&pageSize=$take',
        baseUrl: 'https://chain.api.btc.com/v3',
        onResponse: (response) {
          if (response?.data != null &&
              response.data['data'] != null &&
              response.data['data']['list'] != null) {
            return response.data['data']['list'] ?? [];
          }
          return [];
        },
      );

  Future<Map<String, dynamic>> getTrxTransactions({
    @required String symbol,
    @required String address,
    @required String fingerprint,
  }) =>
      Request().getObject(
        '/v1/hd/wallet/TRX/$symbol/$address/transaction?page=$fingerprint',
      );

  Future<List<Map<String, dynamic>>> getEthTransactionsByToken({
    @required String address,
    @required String contract,
  }) =>
      Request().getExternalListOfObjects(
        '/api?module=account&action=tokentx&contractaddress=$contract&address=$address&page=1&offset=10&sort=desc&apikey=${AppConstants.etherscanApiKey}',
        baseUrl: WalletConfigNetwork.eth
            ? 'https://api-ropsten.etherscan.io'
            : 'https://api-cn.etherscan.com',
        onResponse: (response) {
          if (response?.data != null && response.data['result'] != null) {
            return response.data['result'] ?? [];
          }
          return [];
        },
      );

  /// **** Address ****

  ///添加地址 post {{host}}/v1/hd/auth/custom/ETH/USDT/address address comments hash
  Future<String> submitAddressAdd({
    @required String walletId,
    @required String chain,
    @required String symbol,
    @required String address,
    @required String comments,
  }) =>
      addAuthSignature(
        walletId,
        {
          'address': address,
          'comments': comments,
        },
        (params, auth) => Request().post(
          '/v1/hd/auth/custom/$chain/$symbol/address',
          params,
          authorization: auth,
        ),
      );

  ///修改地址 patch {{host}}/v1/hd/auth/custom/ETH/USDT/address  address comments hash id
  Future<void> submitAddressEdit({
    @required String walletId,
    @required String chain,
    @required String symbol,
    @required String addressId,
    @required String address,
    @required String comments,
  }) =>
      addAuthSignature(
        walletId,
        {
          'id': addressId,
          'address': address,
          'comments': comments,
        },
        (params, auth) => Request().patch(
          '/v1/hd/auth/custom/$chain/$symbol/address',
          params,
          authorization: auth,
        ),
      );

  ///删除地址 delete {{host}}/v1/hd/auth/custom/ETH/USDT/address?hash=hash
  Future<void> submitAddressDelete({
    @required String walletId,
    @required String chain,
    @required String symbol,
    @required String addressId,
  }) =>
      addAuthSignature(
        walletId,
        {
          'id': addressId,
        },
        (params, auth) => Request().delete(
          '/v1/hd/auth/custom/$chain/$symbol/address',
          data: params,
          authorization: auth,
        ),
      );

  ///获取地址列表 get {{host}}/v1/hd/auth/custom/ETH/USDT/address?hash=hash
  Future<List<Map<String, dynamic>>> getAddressList({
    @required String walletId,
    @required String chain,
    @required String symbol,
  }) =>
      addAuthSignature(
        walletId,
        {},
        (params, auth) => Request().getListOfObjects(
          '/v1/hd/auth/custom/$chain/$symbol/address?hash=$walletId',
          params: params,
          authorization: auth,
        ),
      );
}
