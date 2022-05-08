part of admission_domain_module;

abstract class AdmissionConfig
    implements Built<AdmissionConfig, AdmissionConfigBuilder> {
// Constructors
  factory AdmissionConfig([Function(AdmissionConfigBuilder) b]) =
      _$AdmissionConfig;
  AdmissionConfig._();

  static Serializer<AdmissionConfig> get serializer =>
      _$admissionConfigSerializer;

  static AdmissionConfig fromJson(Map<String, dynamic> json) {
    return deserialize<AdmissionConfig>(json);
  }

// Fields
  @nullable
  String get fork;

  @nullable
  @BuiltValueField(wireName: 'home_list')
  BuiltList<int> get homeList;

  @nullable
  @BuiltValueField(wireName: 'ecological')
  BuiltList<AdmissionInfo> get projects;
}
