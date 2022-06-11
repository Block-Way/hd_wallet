part of common_domain_module;

abstract class Config implements Built<Config, ConfigBuilder> {
  // Constructors
  factory Config([Function(ConfigBuilder) b]) = _$Config;
  Config._();

  static Serializer<Config> get serializer => _$configSerializer;

  static Config? fromJson(Map<String, dynamic> json) {
    return deserialize<Config>(json);
  }

// Fields
  @BuiltValueField(wireName: 'currency')
  BuiltMap<String, ConfigCoin> get coins;

  @BuiltValueField(wireName: 'otc_on_chain')
  ConfigOtc get otc;

  //@nullable
  @BuiltValueField(wireName: 'system_store')
  ConfigSystem? get system;

  ConfigUpdate get version;
}
