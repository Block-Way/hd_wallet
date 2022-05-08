part of asset_domain_module;

class AssetApi {
  /// **** Prices ****

  Future<Map<String, dynamic>> getExchangeRates() => Request().getObject(
        '/v1/exchange_rate',
      );

  Future<Map<String, dynamic>> getPrices() => Request().getObject(
        '/v1/price/all',
      );

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

  Future<String> getCoinBalance({
    @required String chain,
    @required String symbol,
    @required String address,
  }) =>
      Request().getValue<String>(
        '/v1/hd/wallet/$chain/$symbol/$address/balance',
      );

  Future<Map<String, dynamic>> getCoinBalanceWithUnconfirmed({
    @required String chain,
    @required String symbol,
    @required String address,
  }) =>
      Request().getObject(
        '/v2/hd/wallet/$chain/$symbol/$address/balance',
      );

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
  }) =>
      Request().getListOfObjects(
        '/v1/hd/wallet/$chain/$symbol/$address/transaction?page=$page&take=$take',
      );

  Future<List<Map<String, dynamic>>> getEthTransactions(
    String address,
    int page, [
    int take = 10,
  ]) =>
      Request().getExternalListOfObjects(
        '/api?module=account&action=txlist&address=$address&page=$page&offset=10&sort=desc&apikey=${AppConstants.etherscanApiKey}',
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
