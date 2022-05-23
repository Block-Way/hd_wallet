part of common_domain_module;

abstract class ConfigUpdateData
    implements Built<ConfigUpdateData, ConfigUpdateDataBuilder> {
// Constructors
  factory ConfigUpdateData([Function(ConfigUpdateDataBuilder) b]) =
      _$ConfigUpdateData;
  ConfigUpdateData._();

  factory ConfigUpdateData.create(
    String version,
    String description,
    String downloadUrl, {
    bool forceUpdate,
  }) {
    return _$ConfigUpdateData._(
      version: version,
      description: description,
      downloadUrl: downloadUrl,
      forceUpdate: forceUpdate,
    );
  }

  static Serializer<ConfigUpdateData> get serializer =>
      _$configUpdateDataSerializer;

  @nullable
  String get version;
  @nullable
  String get description;
  @nullable
  @BuiltValueField(wireName: 'force_update')
  bool get forceUpdate;
  @nullable
  @BuiltValueField(wireName: 'download_url')
  String get downloadUrl;

  @nullable
  @BuiltValueField(wireName: 'disable_functions')
  BuiltMap<String, String> get disabledModules;
}
