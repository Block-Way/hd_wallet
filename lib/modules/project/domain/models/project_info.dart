part of project_domain_module;

abstract class ProjectInfo implements Built<ProjectInfo, ProjectInfoBuilder> {
  // Constructors
  factory ProjectInfo([Function(ProjectInfoBuilder) b]) = _$ProjectInfo;
  ProjectInfo._();

  static Serializer<ProjectInfo> get serializer => _$projectInfoSerializer;

  static ProjectInfo fromJson(Map<String, dynamic> json) {
    return deserialize<ProjectInfo>(json);
  }

// Fields
  @nullable
  int get id;

  @nullable
  @BuiltValueField(wireName: 'currency')
  String get symbol;

  @nullable
  @BuiltValueField(wireName: 'currency_price')
  String get currencyPrice;

  @nullable
  @BuiltValueField(wireName: 'init_amount')
  String get initAmount;

  @nullable
  @BuiltValueField(wireName: 'project_name')
  String get projectName;

  @nullable
  @BuiltValueField(wireName: 'target_number')
  double get targetNumber;

  @nullable
  @BuiltValueField(wireName: 'invite_number')
  double get inviteNumber;

  @nullable
  String get fork;

  @nullable
  @BuiltValueField(wireName: 'total_amount')
  String get totalAmount;

  @nullable
  @BuiltValueField(wireName: 'owner_website')
  String get ownerWebsite;

  @nullable
  @BuiltValueField(wireName: 'owner_name')
  BuiltMap<String, String> get ownerName;

  @nullable
  @BuiltValueField(wireName: 'project_description')
  BuiltMap<String, String> get projectDescription;

  @nullable
  int get status;

//10-不显示矿池入口，11-显示矿池入口
  @nullable
  @BuiltValueField(wireName: 'mining_pool_status')
  int get miningPoolStatus;

  @nullable
  String get iconUrl;

  @nullable
  bool get displayPoolBtn => miningPoolStatus != null && miningPoolStatus == 11;

  @nullable
  String get displayPrice => NumberUtil.truncateDecimal(currencyPrice, 6);

  @nullable
  String get displayInviteNumber => NumberUtil.truncateDecimal(inviteNumber, 2);

  @nullable
  String get displayTotalAmount => NumberUtil.truncateDecimal(totalAmount, 2);

  @nullable
  String get displayInitAmount => NumberUtil.truncateDecimal(initAmount, 2);

  @nullable
  String get displayProgressPair =>
      '${inviteNumber.toInt()}/${targetNumber.toInt()}';

  @nullable
  double get displayProgress =>
      NumberUtil.multiply(NumberUtil.divide(inviteNumber, targetNumber), 120);
}
