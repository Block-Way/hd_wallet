part of invest_domain_module;

abstract class MintInfo implements Built<MintInfo, MintInfoBuilder> {
// Constructors
  factory MintInfo([Function(MintInfoBuilder) updates]) = _$MintInfo;
  MintInfo._();

  static Serializer<MintInfo> get serializer => _$mintInfoSerializer;

  //@nullable
  @BuiltValueField(wireName: 'promotion_reward')
  String? get promotionReward;

  //@nullable
  @BuiltValueField(wireName: 'stake_reward')
  String? get stakeReward;

  //@nullable
  @BuiltValueField(wireName: 'this_stake_reward')
  String? get thisStakeReward;

  //@nullable
  @BuiltValueField(wireName: 'this_balance')
  String? get thisBalance;

  @BuiltValueField(wireName: 'min_balance')
  String get minBalance;

  @BuiltValueField(wireName: 'best_balance')
  String get bestBalance;

  @BuiltValueField(wireName: 'best_balance_reward')
  String get bestBalanceReward;

  @BuiltValueField(wireName: 'min_balance_reward')
  String get minBalanceReward;

  double get totalProfit =>
      NumberUtil.plus(promotionReward ?? 0, stakeReward ?? 0) ?? 0;
}
