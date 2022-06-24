part of invest_domain_module;

abstract class ProfitInvitationItem
    implements Built<ProfitInvitationItem, ProfitInvitationItemBuilder> {
// Constructors
  factory ProfitInvitationItem(
      [Function(ProfitInvitationItemBuilder) updates]) = _$ProfitInvitationItem;
  ProfitInvitationItem._();

  static Serializer<ProfitInvitationItem> get serializer =>
      _$profitInvitationItemSerializer;

// Fields
  @BuiltValueField(wireName: '_id')
  String get address;

  @BuiltValueField(wireName: 'amount')
  String get amount;

  //
  //@nullable
  String? get height;

  //
  //@nullable
  String? get time;
}
