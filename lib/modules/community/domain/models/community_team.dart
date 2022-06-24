part of community_domain_module;

abstract class CommunityTeam
    implements Built<CommunityTeam, CommunityTeamBuilder> {
  // Constructors
  factory CommunityTeam([Function(CommunityTeamBuilder) b]) = _$CommunityTeam;
  CommunityTeam._();

  static Serializer<CommunityTeam> get serializer => _$communityTeamSerializer;

  static CommunityTeam? fromJson(Map<String, dynamic> json) {
    return deserialize<CommunityTeam>(json);
  }

// Fields
  //@nullable
  String? get id;

  /// 10 缺省， 20 审核通过 , 30 拉黑， 40 拒绝通过
  //@nullable
  int? get status;

  //@nullable
  String? get fork;

  //@nullable
  int? get type;

  CommunityTypes get teamType => CommunityUtils.mapCommunityType(type ?? 0);

  //@nullable
  String? get owner;

  //@nullable
  int? get order;

  //@nullable
  bool? get black;

  //@nullable
  @BuiltValueField(wireName: 'is_mine')
  bool? get isMine;

  //@nullable
  @BuiltValueField(wireName: 'owner_wallet_hash')
  String? get ownerWalletHash;

  //@nullable
  @BuiltValueField(wireName: 'telegram_account')
  String? get telegramAccount;

  //@nullable
  String? get name;

  //@nullable
  CommunityTeamOptions? get options;

  //@nullable
  String? get describe;

  //@nullable
  String? get chain;

  //@nullable
  String? get symbol;

  bool get canJoin => options?.joinApplyType == 'on';

  /// 10 缺省，
  bool get statusPending => status == 10;

  /// 20 审核通过
  bool get statusSuccess => status == 20;

  /// 30 拉黑
  bool get statusBlack => status == 30;

  /// 40 拒绝通过
  bool get statusRejected => status == 40;

  /// 没有提交过
  bool get statusDefault => status == null;

  //@nullable
  @BuiltValueField(wireName: 'create_at')
  int? get createAt;

  String get displayCreatedAt =>
      formatDate(DateTime.fromMillisecondsSinceEpoch((createAt ?? 0) * 1000));

  String get displayIcon => options?.displayIcon ?? '';

  /// 平均持币
  String get displayAverageBalance {
    // 优先取sug 没有sug 取bbc,不能因为 sug 为0 就取bbc，需要按照key 来
    if (options != null && options?.addressAverageBalance != null) {
      var balance = '';
      if (options?.addressAverageBalance?.containsKey('SUG') ?? false) {
        balance = options?.addressAverageBalance?['SUG'] ?? '';
      } else if (options?.addressAverageBalance?.containsKey('BBC') ?? false) {
        balance = options?.addressAverageBalance?['BBC'] ?? '';
      }
      return NumberUtil.truncateDecimal<String>(
        balance != null && balance.isNotEmpty ? balance : 0,
        6,
      );
    }
    return '0';
  }

  String get displayAverageSymbol {
    if (options != null && options?.addressAverageBalance != null) {
      return (options?.addressAverageBalance?.containsKey('SUG') ?? false)
          ? 'SUG'
          : 'BBC';
    }
    return '';
  }

  /// 拒绝理由
  String get rejectedMessage {
    if (options != null &&
        options?.admin != null &&
        options?.admin?['rejected_message'] != null) {
      return options?.admin?['rejected_message'].toString() ?? '';
    }
    return '';
  }

  /// 禁用理由
  String get blackMessage {
    if (options != null &&
        options?.admin != null &&
        options?.admin?['black_message'] != null) {
      return options?.admin?['black_message'].toString() ?? '';
    }
    return '';
  }

  bool get canSubmit => statusDefault || statusRejected;

  String get statusTransKey {
    if (statusPending) {
      return 'community:create_btn_under_review';
    } else if (statusRejected) {
      return 'community:create_btn_edit';
    } else if (statusBlack) {
      return 'community:create_btn_black';
    } else if (statusSuccess) {
      return 'community:create_btn_success';
    } else {
      return 'global:btn_commit';
    }
  }
}
