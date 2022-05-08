part of settings_domain_module;

class SettingsRepository {
// Singleton instance

  factory SettingsRepository([
    FlutterSecureStorage _storage,
  ]) {
    _instance._storage = _storage ?? FlutterSecureStorage();
    return _instance;
  }
  SettingsRepository._internal();

  static final _instance = SettingsRepository._internal();

  FlutterSecureStorage _storage;

  /// Secure storage mnemonic key
  static const _storageKey = 'DevSettings@All';

// Methods

  Future<SettingsConfig> getSettings() async {
    final json = await _storage.read(key: _storageKey);
    try {
      return SettingsConfig.fromJson(jsonDecode(json) as Map<String, dynamic>);
    } catch (e) {
      return SettingsConfig();
    }
  }

  Future<void> saveSettings(SettingsConfig config) async {
    await _storage.write(key: _storageKey, value: jsonEncode(config.toJson()));
  }
}
