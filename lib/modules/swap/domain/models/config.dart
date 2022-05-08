part of swap_domain_module;

abstract class SwapConfig implements Built<SwapConfig, SwapConfigBuilder> {
  // Constructors
  factory SwapConfig([Function(SwapConfigBuilder) b]) = _$SwapConfig;
  SwapConfig._();

  static Serializer<SwapConfig> get serializer => _$swapConfigSerializer;

// Serializers
  static SwapConfig fromJson(List<List<dynamic>> json) {
    return deserialize<SwapConfig>({'tradePairs': json});
  }

// Fields

  @nullable
  @BuiltValueField(wireName: 'tradePairs')
  BuiltList<BuiltList<SwapConfigCoin>> get tradePairs;

  List<MapEntry<SwapConfigCoin, SwapConfigCoin>> get enabledTradePairs {
    final result = <MapEntry<SwapConfigCoin, SwapConfigCoin>>[];

    for (final pairs in tradePairs) {
      if (pairs.first.enabled) {
        result.add(MapEntry(
          pairs.last,
          pairs.first,
        ));
      }
      if (pairs.last.enabled) {
        result.add(MapEntry(
          pairs.first,
          pairs.last,
        ));
      }
    }

    return result;
  }
}
