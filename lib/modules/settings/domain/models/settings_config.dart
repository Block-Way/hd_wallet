part of settings_domain_module;

abstract class SettingsConfig
    implements Built<SettingsConfig, SettingsConfigBuilder> {
  // Constructors
  factory SettingsConfig([Function(SettingsConfigBuilder) b]) =
      _$SettingsConfig;
  SettingsConfig._();

  static Serializer<SettingsConfig> get serializer =>
      _$settingsConfigSerializer;

// Serializers
  static SettingsConfig fromJson(dynamic json) {
    return deserialize<SettingsConfig>(json);
  }

  Object toJson() {
    return serialize<SettingsConfig>(this);
  }

// Fields

  @nullable
  String get apiBaseUrl;

  @nullable
  String get apiAppVersion;

  @nullable
  String get mqttUseTls;

  @nullable
  String get mqttDisabled;

  @nullable
  String get proxyUrl;

  bool get isMqttUseTls => mqttUseTls == 'true';

  bool get isMqttDisabled => mqttDisabled == 'true';

  bool get isApiDevServer => apiBaseUrl == AppConstants.apiUrlDev.first;

  bool get hasProxyUrl => proxyUrl?.isNotEmpty == true;

  bool get hasApiBaseUrl => apiBaseUrl?.isNotEmpty == true;

  bool get hasApiAppVersion => apiAppVersion?.isNotEmpty == true;
}
