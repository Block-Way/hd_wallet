part of home_domain_module;

class HomeRepository {
  factory HomeRepository([HomeApi? _api]) {
    _instance._api = _api ?? HomeApi();
    return _instance;
  }
  HomeRepository._internal();

  late HomeApi _api;

  static final _instance = HomeRepository._internal();

  Future<List<dynamic>> getBanners() async {
    return _api.getBanners();
  }

  Future<List<Map<String, dynamic>>> getQuotations({
    String? marketId,
    int? timestamp,
  }) async {
    print('stsetas sdfsfasfds one');
    final a = _api.getQuotations(marketId: marketId ?? '', timestamp: timestamp);
    print('stsetas sdfsfasfds two');
    print('$a');

    return a;
  }
}
