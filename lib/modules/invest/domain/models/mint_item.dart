part of invest_domain_module;

abstract class MintItem implements Built<MintItem, MintItemBuilder> {
// Constructors
  factory MintItem([Function(MintItemBuilder) updates]) = _$MintItem;
  MintItem._();

  static Serializer<MintItem> get serializer => _$mintItemSerializer;

// Fields

  int get id;

  @nullable
  @BuiltValueField(wireName: 'fork')
  String get forkId;

  BuiltMap<String, String> get name;

  String get symbol;

  String get chain;

  /// 10-关闭，11-开启
  @nullable
  @BuiltValueField(wireName: 'mint_enable')
  int get mintEnable;

  @nullable
  @BuiltValueField(wireName: 'min_balance')
  double get minBalance;

  /// 是否开启挖矿
  bool get isMining => mintEnable == 11;

  String nameByLang(String lang) => name[lang] ?? name['en'] ?? '';
}
