part of common_domain_module;

abstract class ConfigUpdate
    implements Built<ConfigUpdate, ConfigUpdateBuilder> {
  // Constructors
  factory ConfigUpdate([Function(ConfigUpdateBuilder) b]) = _$ConfigUpdate;
  ConfigUpdate._();

  static Serializer<ConfigUpdate> get serializer => _$configUpdateSerializer;

  static ConfigUpdate? fromJson(Map<String, dynamic> json) {
    return deserialize<ConfigUpdate>(json);
  }

// Fields
  //@nullable
  @BuiltValueField(wireName: 'update')
  bool? get needUpdate;

  //@nullable
  ConfigUpdateData? get data;

  bool get hasNewVersion => needUpdate == true && data?.downloadUrl != null;
}
