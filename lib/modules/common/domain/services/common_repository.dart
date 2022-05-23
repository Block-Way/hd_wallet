part of common_domain_module;

class CommonRepository {
  factory CommonRepository([CommonApi _api]) {
    _instance._api = _api ?? CommonApi();
    return _instance;
  }
  CommonRepository._internal();

  static final _instance = CommonRepository._internal();

  CommonApi _api;
  Box<Settings> _settings;

  static const _settingsCacheKey = 'settings_v1';
// Methods

  Future<void> initializeCache() async {
    _settings = await AppHiveCache.openBox<Settings>(_settingsCacheKey);
    if (_settings.get(_settingsCacheKey) == null) {
      await _settings.put(
        _settingsCacheKey,
        Settings(
          fiatCurrency: AppConstants.defaultCurrency,
          language: AppConstants.defaultLanguage,
        ),
      );
    }
  }

  Settings getSettings() {
    if (_settings.get(_settingsCacheKey) == null) {
      final settings = Settings(
        fiatCurrency: AppConstants.defaultCurrency,
        language: AppConstants.defaultLanguage,
      );
      _settings.put(_settingsCacheKey, settings);
      return settings;
    }
    return _settings.get(_settingsCacheKey);
  }

  Future<Config> getConfig() async {
    //final json = await _api.getConfig();
    final json = {
      'version': {},
      'otc_on_chain': {
        'enable': true,
        'system_otc_address': {},
        // 销毁地址
        'system_deposit_address':
            '100000000000000000000000000000000000000000000000000000000'
      },
      'currency': {
        'HAH': {
          'api_name': 'HAH',
          'net_type': 'BBC',
          'anchor': AppConstants.btca_fork,
          'english_name': 'HAH',
          'full_name': 'Hash Ahead',
          'icon_url': '',
          'transfer_fee': 0.01,
          'display_precision': 6,
          'defi_reward': true
        }
      }
    };
    return Config.fromJson(json);
  }

  Future<String> getApiDns() async {
    //return _api.getApiDns();
    debugPrint('getApiDns');
    return 'dns_name';
  }

  Future<int> getSystemDate() async {
    //return _api.getSystemDate();
    debugPrint('getSystemDate');
    final nowTime = DateTime.now();
    return nowTime.millisecondsSinceEpoch;
  }

  Future<Map<String, dynamic>> getConfigImage() async {
    //return _api.getConfigImage();
    debugPrint('getConfigImage');
    final json = {
      'signed': {'Key-Pair-Id': 1, 'Policy': 1, 'Signature': 1},
      'url': ''
    };
    return json;
  }

  Future<ConfigUpdate> getLastVersionProd() async {
    //final json = await _api.getConfigVersion();
    debugPrint('getLastVersionProd');
    final json = {
      'update': 0,
      'data': {
        'version': '1.0.4+1',
        'description': 'A new Flutter project.',
        'force_update': false,
        'download_url': '',
        'disable_functions': {}
      }
    };
    return ConfigUpdate.fromJson(json);
  }

  Future<ConfigUpdateData> getLastVersionBeta() async {
    debugPrint('getLastVersionBeta');
    return null;
    /* 没有可以下载的版本
    final appSecret = AppConfig().appCenterAppSecret;
    final appDistribution = AppConfig().appCenterDistribution;
    final releases = await _api.getLastBetaReleases(
      appName: AppConstants.appCenterId,
      platform: Platform.isAndroid ? 'Android' : 'iOS',
    );
    if (releases != null &&
        releases.isNotEmpty &&
        releases.first['build']['commitHash'].toString() ==
            AppConstants.commitHash) {
      return null;
    }

    final data = await _api.getLastBetaVersion(
      appSecret: appSecret,
      appDistribution: appDistribution,
    );

    final updateData = ConfigUpdateData.create(
      data['short_version']?.toString(),
      [
        'v${data['short_version']}.${data['id']}',
        data['release_notes']?.toString(),
      ].join('\n\n-----------------------------\n\n'),
      Platform.isAndroid
          ? data['download_url']?.toString()
          : data['install_url']?.toString(),
      forceUpdate: data['mandatory_update'] == true,
    );

    return updateData;
    */
  }
}
