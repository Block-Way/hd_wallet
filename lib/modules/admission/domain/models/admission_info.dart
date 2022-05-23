part of admission_domain_module;

abstract class AdmissionInfo
    implements Built<AdmissionInfo, AdmissionInfoBuilder> {
// Constructors
  factory AdmissionInfo([Function(AdmissionInfoBuilder) b]) = _$AdmissionInfo;
  AdmissionInfo._();

  static Serializer<AdmissionInfo> get serializer => _$admissionInfoSerializer;

  static AdmissionInfo fromJson(Map<String, dynamic> json) {
    return deserialize<AdmissionInfo>(json);
  }

// Fields
  @nullable
  int get id;

  @nullable
  String get name;

  @nullable
  String get describe;

  @nullable
  @BuiltValueField(wireName: 'end_time')
  int get endTime;

  @nullable
  @BuiltValueField(wireName: 'start_time')
  int get startTime;

  @nullable
  BuiltList<AdmissionCondition> get condition;

  /// 第一个规则 现在只有一个
  AdmissionCondition get transferCondition =>
      condition != null && condition.isNotEmpty ? condition.first : null;

// "ecological": {
//     "chain": "BBC",
//     "fork": "123123123123",
//     "currency": "BBC"
// },
  @nullable
  BuiltMap<String, String> get ecological;

  String get chain => ecological != null ? ecological['chain'] : '';

  String get symbol => ecological != null ? ecological['currency'] : '';

  String get fork => ecological != null ? ecological['fork'] : '';

  bool get isRunning {
    if (startTime != null && endTime != null) {
      final nowTime = SystemDate.getTime();
      return startTime < nowTime && nowTime < endTime;
    }
    return false;
  }

  bool get notStart {
    if (startTime != null) {
      return startTime > SystemDate.getTime();
    }
    return false;
  }

  bool get isEnd {
    if (endTime != null) {
      return endTime < SystemDate.getTime();
    }
    return false;
  }
}
