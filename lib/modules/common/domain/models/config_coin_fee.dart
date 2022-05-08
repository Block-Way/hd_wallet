part of common_domain_module;

abstract class ConfigCoinFee
    implements Built<ConfigCoinFee, ConfigCoinFeeBuilder> {
// Constructors
  factory ConfigCoinFee([Function(ConfigCoinFeeBuilder) b]) = _$ConfigCoinFee;
  ConfigCoinFee._();

  static Serializer<ConfigCoinFee> get serializer => _$configCoinFeeSerializer;

  bool get enable;

  BuiltMap<String, double> get level;

  double get fast => level['fast'];

  double get fastest => level['fastest'];

  double get slow => level['slow'];

  double get slowest => level['slowest'];
}
