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
    final json = await _api.getConfig();
    return Config.fromJson(json);
  }

  Future<String> getApiDns() {
    return _api.getApiDns();
  }

  Future<int> getSystemDate() {
    return _api.getSystemDate();
  }

  Future<Map<String, dynamic>> getConfigImage() {
    return _api.getConfigImage();
  }

  Future<ConfigUpdate> getLastVersionProd() async {
    final json = await _api.getConfigVersion();
    return ConfigUpdate.fromJson(json);
  }

  Future<ConfigUpdateData> getLastVersionBeta() async {
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
  }
}
