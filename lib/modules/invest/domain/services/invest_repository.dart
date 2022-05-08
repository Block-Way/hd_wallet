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
    final json = [
      {
        'id': 1,
        'name': {'HAH': 'Hash Ahead'},
        'symbol': 'HAH',
        'chain': 'BBC',
        'mint_enable': 11,
        'min_balance': 100
      }
    ];
    final c = InvestConfig.fromJson(json);
    return c;
  }

  Future<Map<String, dynamic>> getMintInfo({
    @required String fork,
    @required String addr,
  }) async {
    final dio = Dio();
    final response =
        await dio.get('${AppConstants.randomApiUrl}/mint?addr=$addr');
    final data = response.data;
    return data as Map<String, dynamic>;
  }

  Future<List<dynamic>> getChartList({
    @required String fork,
    @required String addr,
  }) async {
    final dio = Dio();
    final response =
        await dio.get('${AppConstants.randomApiUrl}/chart?addr=$addr');
    return response.data as List<dynamic>;
  }

  //
  Future<List<Map<String, dynamic>>> getProfitRecordList({
    @required String fork,
    @required String walletId,
    @required int skip,
    @required int take,
  }) async {
    /*
    final dio = Dio();
    final response =
        await dio.get('${AppConstants.randomApiUrl}/profit?walletId=$walletId');
    final data = response.data;
    return List<Map<String, dynamic>>.from(
      data.map(
        (e) => Map<String, dynamic>.from(e as Map<String, dynamic>),
      ),
    );
    */
    return [
      {
        'height': 100,
        'balance': '10',
        'stake_reward': '5',
        'promotion_reward': '5'
      },
      {
        'height': 200,
        'balance': '20',
        'stake_reward': '5',
        'promotion_reward': '5'
      },
      {
        'height': 300,
        'balance': '30',
        'stake_reward': '5',
        'promotion_reward': '5'
      }
    ];
    /*
    return _api.getProfitRecordList(
      fork: fork,
      walletId: walletId,
      skip: skip,
      take: take,
    );*/
  }

  //
  Future<List<dynamic>> getProfitInvitationList({
    @required String fork,
    @required String addr,
    @required int skip,
    @required int take,
  }) async {
    final dio = Dio();
    final response =
        await dio.get('${AppConstants.randomApiUrl}/general_reward?addr=$addr');
    return response.data as List<dynamic>;
  }
}
