part of invest_domain_module;

abstract class MintChart implements Built<MintChart, MintChartBuilder> {
// Constructors
  factory MintChart([Function(MintChartBuilder) updates]) = _$MintChart;
  MintChart._();

  factory MintChart.create({
    String? balance,
    String? reward,
    bool isBalance = false,
  }) {
    return MintChart().rebuild(
      (e) => e
        ..balance = balance
        ..reward = reward
        ..isBalance = isBalance,
    );
  }

  static Serializer<MintChart> get serializer => _$mintChartSerializer;

  // Fields

  //@nullable
  @BuiltValueField(wireName: 'balance')
  String? get balance;

  //@nullable
  @BuiltValueField(wireName: 'reward')
  String? get reward;

  //@nullable
  @BuiltValueField(wireName: 'user_balance')
  bool? get isBalance;
}
