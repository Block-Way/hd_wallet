part of swap_domain_module;

class SwapApi {
  Future<List<List<dynamic>>> getConfig() =>
      Request().getListOfValues<List<dynamic>>(
        '/v1/hd/exchange/config',
      );

  Future<List<Map<String, dynamic>>> getSwapList({
    @required int skip,
    @required int take,
    @required String walletId,
  }) =>
      addAuthSignature(
        walletId,
        {},
        (params, auth) => Request().getListOfObjects(
          '/v1/hd/exchange/list/$skip/$take',
          params: params,
          authorization: auth,
        ),
      );

  Future<String> getApproveBalance({
    @required String chain,
    @required String symbol,
    @required String address,
    @required String contract,
  }) =>
      Request().getValue<String>(
        '/v1/hd/exchange/$chain/$symbol/approve/balance',
        params: {
          'from': address,
          'contract': contract,
        },
      );

  Future<Map<String, dynamic>> postApproveTransaction({
    @required String chain,
    @required String symbol,
    @required String address,
    @required String contract,
    @required int amount,
  }) =>
      Request().post(
        '/v1/hd/exchange/$chain/$symbol/approve',
        {
          'from': address,
          'contract': contract,
          'amount': amount,
        },
      );

  Future<Map<String, dynamic>> postCreateTransaction({
    @required String chain,
    @required String symbol,
    @required String fromAddress,
    @required String fromContract,
    @required String toAddress,
    @required String toContract,
    @required int amount,
  }) =>
      Request().post(
        '/v1/hd/exchange/$chain/$symbol',
        {
          'from': fromAddress,
          'contract': fromContract,
          'amount': amount,
          'address': toAddress,
          'fork_hash': toContract,
        },
      );
}
