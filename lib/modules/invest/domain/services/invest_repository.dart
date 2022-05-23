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
    @required String walletId,
  }) async {
    final dio = Dio();
    final response =
        await dio.get('${AppConstants.randomApiUrl}/mint?walletId=$walletId');
    final data = response.data;
    return data;
  }

  Future<List<Map<String, dynamic>>> getChartList({
    @required String fork,
    @required String walletId,
  }) async {
    final dio = Dio();
    final response =
        await dio.get('${AppConstants.randomApiUrl}/chart?walletId=$walletId');
    final data = response.data;
    return List<Map<String, dynamic>>.from(
      data.map(
        (e) => Map<String, dynamic>.from(e as Map<String, dynamic>),
      ),
    );
    /*
    return _api.getChartList(
      fork: fork,
      walletId: walletId,
    );*/
  }

  // 收益列表
  Future<List<Map<String, dynamic>>> getProfitRecordList({
    @required String fork,
    @required String walletId,
    @required int skip,
    @required int take,
  }) async {
    final dio = Dio();
    final response =
        await dio.get('${AppConstants.randomApiUrl}/profit?walletId=$walletId');
    final data = response.data;
    return List<Map<String, dynamic>>.from(
      data.map(
        (e) => Map<String, dynamic>.from(e as Map<String, dynamic>),
      ),
    );
    /*
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
    ];*/
    /*
    return _api.getProfitRecordList(
      fork: fork,
      walletId: walletId,
      skip: skip,
      take: take,
    );*/
  }

  // 邀请人列表
  Future<List<Map<String, dynamic>>> getProfitInvitationList({
    @required String fork,
    @required String walletId,
    @required int skip,
    @required int take,
  }) async {
    final dio = Dio();
    final response = await dio
        .get('${AppConstants.randomApiUrl}/invitation?walletId=$walletId');
    final data = response.data;
    return List<Map<String, dynamic>>.from(
      data.map(
        (e) => Map<String, dynamic>.from(e as Map<String, dynamic>),
      ),
    );
    /*
    return [
      {'_id': '12345678901234567890', 'achievement': '100'},
      {'_id': '12345678902234567890', 'achievement': '200'},
      {'_id': '11112345678902234567890', 'achievement': '300'}
    ];*/
    /*
    return _api.getProfitInvitationList(
      fork: fork,
      walletId: walletId,
      skip: skip,
      take: take,
    );*/
  }
}
