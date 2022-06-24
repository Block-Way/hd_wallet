part of community_domain_module;

abstract class CommunityMember
    implements Built<CommunityMember, CommunityMemberBuilder> {
  // Constructors
  factory CommunityMember([Function(CommunityMemberBuilder) b]) =
      _$CommunityMember;
  CommunityMember._();

  static Serializer<CommunityMember> get serializer =>
      _$communityMemberSerializer;

  static CommunityMember? fromJson(Map<String, dynamic> json) {
    return deserialize<CommunityMember>(json);
  }

// Fields
  //@nullable
  String? get id;

  //@nullable
  int? get status;

  //@nullable
  String? get team;

  //@nullable
  @BuiltValueField(wireName: 'bbc_address')
  String? get bbcAddress;

  //@nullable
  int? get order;

  //@nullable
  @BuiltValueField(wireName: 'is_mine')
  bool? get isMine;

  //@nullable
  CommunityMemberInfo? get info;

  /// 拒绝理由
  String get rejectedMessage {
    if (info != null &&
        info?.admin != null &&
        info?.admin?['rejected_message'] != null) {
      return info?.admin?['rejected_message'].toString() ?? '';
    }
    return '';
  }

  /// 禁用理由
  String get blackMessage {
    if (info != null &&
        info?.admin != null &&
        info?.admin?['black_message'] != null) {
      return info?.admin?['black_message'].toString() ?? '';
    }
    return '';
  }

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

  bool get canSubmit => statusDefault || statusRejected;

  String get statusTransKey {
    if (statusPending) {
      return 'community:join_btn_under_review';
    } else if (statusRejected) {
      return 'community:join_btn_edit';
    } else if (statusBlack) {
      return 'community:join_btn_black';
    } else if (statusSuccess) {
      return 'community:join_btn_success';
    } else {
      return 'community:join_btn_submit';
    }
  }
}
