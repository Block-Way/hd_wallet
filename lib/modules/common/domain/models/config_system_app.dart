part of common_domain_module;

abstract class ConfigSystemApp
    implements Built<ConfigSystemApp, ConfigSystemAppBuilder> {
// Constructors
  factory ConfigSystemApp([Function(ConfigSystemAppBuilder) b]) =
      _$ConfigSystemApp;
  ConfigSystemApp._();

  static Serializer<ConfigSystemApp> get serializer =>
      _$configSystemAppSerializer;

// Fields
  @nullable
  bool get enable;
}
