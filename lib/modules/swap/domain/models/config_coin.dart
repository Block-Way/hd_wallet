part of swap_domain_module;

abstract class SwapConfigCoin
    implements Built<SwapConfigCoin, SwapConfigCoinBuilder> {
// Constructors
  factory SwapConfigCoin([Function(SwapConfigCoinBuilder) b]) =
      _$SwapConfigCoin;
  SwapConfigCoin._();

  static Serializer<SwapConfigCoin> get serializer =>
      _$swapConfigCoinSerializer;

// Fields

  //@nullable
  String? get address;

  //@nullable
  String? get chain;

  //@nullable
  String? get symbol;

  @BuiltValueField(wireName: 'transfer_min')
  double get transferMin;

  @BuiltValueField(wireName: 'transfer_max')
  double get transferMax;

  //@nullable
  @BuiltValueField(wireName: 'transfer_fee')
  double? get transferFee;

  //@nullable
  bool? get enabled;

  //@nullable
  String? get name;

  String get id => '$chain:$symbol';

  bool get isChainNeedApprove => ['ETH', 'TRX'].contains(chain);
}
