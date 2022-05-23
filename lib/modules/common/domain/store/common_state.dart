part of common_domain_module;

abstract class CommonState implements Built<CommonState, CommonStateBuilder> {
// Constructors
  factory CommonState() {
    return _$CommonState._(
      configState: ConfigState.loading.index,
    );
  }
  CommonState._();

  static Serializer<CommonState> get serializer => _$commonStateSerializer;

// Fields
  @nullable
  Config get config;

  @nullable
  int get configState;

  @nullable
  PackageInfo get appInfo;

  @nullable
  String get deviceId;

  @nullable
  String get language;

  @nullable
  String get fiatCurrency;

  String get languageForApi => language == 'zh' ? 'zh-cn' : language;

  @nullable
  ConfigUpdate get newVersion;

  BuiltMap<String, String> get disabledModules =>
      config?.version?.data?.disabledModules;
}
