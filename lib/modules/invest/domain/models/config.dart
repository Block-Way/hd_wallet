part of invest_domain_module;

abstract class InvestConfig
    implements Built<InvestConfig, InvestConfigBuilder> {
  // Constructors
  factory InvestConfig([Function(InvestConfigBuilder) b]) = _$InvestConfig;
  InvestConfig._();

  static Serializer<InvestConfig> get serializer => _$investConfigSerializer;

// Serializers
  static InvestConfig fromJson(List<dynamic> json) {
    return deserialize<InvestConfig>({'mints': json});
  }

// Fields

  @nullable
  @BuiltValueField(wireName: 'mints')
  BuiltList<MintItem> get mints;

  @nullable
  @BuiltValueField(wireName: 'airdrops')
  BuiltList<MintItem> get airdrops;

  MintItem get defaultMint =>
      mints != null && mints.isNotEmpty ? mints.first : null;
}
