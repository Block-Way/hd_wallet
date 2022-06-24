part of trade_domain_module;

class TradeApi {
  String _getTradePairUrlId(String tradePairId) =>
      tradePairId.replaceAll('/', '|');

  /// **** Config ****

  Future<Map<String, Object>> getConfig() async {
    return {};
  }
  /*=>
      Request().getObject('/v1/dex/config', params: {
        'version': AppConstants.dexConfigVersion,
      });
*/
  /// **** Info ****

  Future<Map<String, dynamic>> getTradePairTickers({
    required String tradePairId,
    required String span,
    required int count,
  }) async {
    return {};
  }

  /*
      Request().getObject(
        '/v1/dex/order/list/${_getTradePairUrlId(tradePairId)}/$count?span=$span',
      );
*/
  Future<List<Map<String, dynamic>>> getTradePairDeals({
    required String tradePairId,
    required int count,
  }) async {
    return [];
  }

  /*
      Request().getListOfObjects(
        '/v1/dex/latest_deal_record/${_getTradePairUrlId(tradePairId)}/$count',
      );
*/
  Future<Map<String, dynamic>> getTradePairInfo24H({
    required String tradePairId,
  }) async {
    return {};
  }
  /*=>
      Request().getObject(
        '/v1/dex/trade_info_24h/${_getTradePairUrlId(tradePairId)}',
      );
*/
  /// **** Chart ****

  Future<Map<String, dynamic>> getKLineLimit() async {
    return {};
  }
  // => Request().getObject(
  //      '/v1/dex/kline/limit',
  //    );

  Future<List<Map<String, Object>>> getKLineData({
    required String resolution,
    required String tradePairId,
    required int limit,
  }) async {
    return [];
  }
  // =>
  //    Request().getListOfObjects(
  //      '/v1/dex/kline/$resolution/$limit?coin_pair=$tradePairId',
  //    );

  /// **** Orders ****

  Future<Map<String, dynamic>> getOrderDetail({
    required String walletId,
    required String txId,
  }) async {
    return {};
  }

  /* =>
      addAuthSignature(
        walletId,
        {},
        (params, auth) => Request().getObject(
          '/v1/dex/order/info/$txId',
          params: params,
          authorization: auth,
        ),
      );
*/
  Future<List<Map<String, dynamic>>> getOrdersAll({
    /// Type, can be:
    /// - [see TradeOrderApiStatus]
    /// RecordType, can be:
    /// - record
    /// - record_for_home
    required String type,
    required String recordType,
    required String tradePairId,
    required String tradePairAddress,
    required String tradeSide,
    required int skip,
    required int take,
    required String walletId,
    required String orderBy,
  }) async {
    return [];
  }

  /*=>
      addAuthSignature(
        walletId,
        {},
        (params, auth) => Request().getListOfObjects(
          '/v1/dex/order/$recordType/${_getTradePairUrlId(tradePairId)}/$tradePairAddress/$tradeSide/$type/$skip/$take$orderBy',
          params: params,
          authorization: auth,
        ),
      );
*/
  Future<List<Map<String, dynamic>>> getOrdersDealFail({
    required String walletId,
    required String tradePairId,
  }) async {
    /*
    final query = tradePairId == null ? '' : '?coin_pair=$tradePairId';
    return addAuthSignature(
      walletId,
      {},
      (params, auth) => Request().getListOfObjects(
        '/v1/dex/order/deal_fail_record$query',
        params: params,
        authorization: auth,
      ),
    );*/
    return [];
  }

  Future<void> postOrderDealFail({
    required String txId,
    required String template,
    required String walletId,
  }) async {
    return;
  }

  /*=>
      addAuthSignature(
        walletId,
        {
          'tx': txId,
          'template': template,
        },
        (params, auth) => Request().post(
          '/v1/dex/order/deal_fail_record',
          params,
          authorization: auth,
        ),
      );
*/
  Future<List<String>> getOrderCancelledIds({
    required String walletId,
    required String txId,
  }) async {
    return [];
  }

  /*=>
      addAuthSignature(
        walletId,
        {},
        (params, auth) => Request().getListOfValues<String>(
          '/v1/dex/order/check_cancel/$txId',
          params: params,
          authorization: auth,
        ),
      );
*/
  /// TODO: next version
  Future<List<String>> getOrderStatusIds({
    required String walletId,
    required String txIds,
  }) async {
    return [];
  }

  /*=>
      addAuthSignature(
        walletId,
        {},
        (params, auth) => Request().getListOfValues<String>(
          '/v1/dex/order/check_status/$txIds',
          params: params,
          authorization: auth,
        ),
      );
*/
  Future<Map<String, dynamic>> getOrderTemplateInfo({
    required String walletId,
    required String address,
  }) async {
    return {};
  }
  /* =>
      addAuthSignature(
        walletId,
        {},
        (params, auth) => Request().getObject(
          '/v1/dex/order/template_hex/$address',
          params: params,
          authorization: auth,
        ),
      );
      */
}
