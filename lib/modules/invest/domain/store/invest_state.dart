part of invest_domain_module;

abstract class InvestState implements Built<InvestState, InvestStateBuilder> {
// Constructors

  factory InvestState() {
    return _$InvestState._(
      configState: ConfigState.loading.index,
      chartList: BuiltList([]),
      profitRecordList: BuiltList([]),
      profitInvitationList: BuiltList([]),
    );
  }
  InvestState._();

  @nullable
  InvestConfig get config;

  @nullable
  int get configState;

  @nullable
  List<MintItem> get mints => config?.mints?.toList() ?? [];

  @nullable
  MintItem get activeMint;

  @nullable
  MintInfo get mintInfo;

  BuiltList<MintChart> get chartList;

  BuiltList<ProfitRecordItem> get profitRecordList;

  BuiltList<ProfitInvitationItem> get profitInvitationList;

  bool get hasMint => activeMint != null;
}
