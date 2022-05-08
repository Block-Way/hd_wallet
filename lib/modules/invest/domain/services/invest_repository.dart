part of invest_domain_module;

class InvestRepository {
  factory InvestRepository([InvestApi _api]) {
    _instance._api = _api ?? InvestApi();
    return _instance;
  }
  InvestRepository._internal();

  static final _instance = InvestRepository._internal();

  InvestApi _api;

  Future<InvestConfig> getConfig() async {
    final json = await _api.getConfig();
    return InvestConfig.fromJson(json);
  }

  Future<Map<String, dynamic>> getMintInfo({
    @required String fork,
    @required String walletId,
  }) async {
    return _api.getMintInfo(
      fork: fork,
      walletId: walletId,
    );
  }

  Future<List<Map<String, dynamic>>> getChartList({
    @required String fork,
    @required String walletId,
  }) async {
    return _api.getChartList(
      fork: fork,
      walletId: walletId,
    );
  }

  // 收益列表
  Future<List<Map<String, dynamic>>> getProfitRecordList({
    @required String fork,
    @required String walletId,
    @required int skip,
    @required int take,
  }) async {
    return _api.getProfitRecordList(
      fork: fork,
      walletId: walletId,
      skip: skip,
      take: take,
    );
  }

  // 邀请人列表
  Future<List<Map<String, dynamic>>> getProfitInvitationList({
    @required String fork,
    @required String walletId,
    @required int skip,
    @required int take,
  }) async {
    return _api.getProfitInvitationList(
      fork: fork,
      walletId: walletId,
      skip: skip,
      take: take,
    );
  }
}
