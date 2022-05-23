part of common_domain_module;

abstract class ConfigSystem
    implements Built<ConfigSystem, ConfigSystemBuilder> {
// Constructors
  factory ConfigSystem([Function(ConfigSystemBuilder) b]) = _$ConfigSystem;
  ConfigSystem._();

  static Serializer<ConfigSystem> get serializer => _$configSystemSerializer;

// Fields
  @nullable
  BuiltMap<String, ConfigSystemApp> get config;

  bool get isIOSAppStore => config['pg'] == null || config['pg'].enable == true;
}
