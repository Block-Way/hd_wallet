part of invest_domain_module;

class InvestApi {
  /// Invest config
  Future<List<Map<String, dynamic>>> getConfig() =>
      Request().getListOfObjects('/v1/hd/defi/mint/config');

  /// 矿池详情
  Future<Map<String, dynamic>> getMintInfo({
    @required String fork,
    @required String walletId,
  }) =>
      addAuthSignature(
        walletId,
        {},
        (params, auth) => Request().getObject(
          '/v1/hd/defi/mint/info?fork=$fork',
          params: params,
          authorization: auth,
        ),
      );

  /// 矿池收益曲线图
  Future<List<Map<String, dynamic>>> getChartList({
    @required String fork,
    @required String walletId,
  }) =>
      addAuthSignature(
        walletId,
        {},
        (params, auth) => Request().getListOfObjects(
          '/v1/hd/defi/mint/curve?fork=$fork',
          params: params,
          authorization: auth,
        ),
      );

  /// 收益列表
  Future<List<Map<String, dynamic>>> getProfitRecordList({
    @required String fork,
    @required String walletId,
    @required int skip,
    @required int take,
  }) =>
      addAuthSignature(
        walletId,
        {},
        (params, auth) => Request().getListOfObjects(
          '/v1/hd/defi/mint/list/$skip/$take?fork=$fork',
          params: params,
          authorization: auth,
        ),
      );

  /// 推荐 列表
  Future<List<Map<String, dynamic>>> getProfitInvitationList({
    @required String fork,
    @required String walletId,
    @required int skip,
    @required int take,
  }) =>
      addAuthSignature(
        walletId,
        {},
        (params, auth) => Request().getListOfObjects(
          '/v1/hd/defi/mint/promote_list/$skip/$take?fork=$fork',
          params: params,
          authorization: auth,
        ),
      );
}
