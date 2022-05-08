part of admission_domain_module;

abstract class AdmissionCondition
    implements Built<AdmissionCondition, AdmissionConditionBuilder> {
// Constructors
  factory AdmissionCondition([Function(AdmissionConditionBuilder) b]) =
      _$AdmissionCondition;
  AdmissionCondition._();

  static Serializer<AdmissionCondition> get serializer =>
      _$admissionConditionSerializer;

// Fields
  @nullable
  @BuiltValueField(wireName: 'black_hole_address')
  String get address;

  @nullable
  @BuiltValueField(wireName: 'black_hole_transfer_data')
  String get transferData;

  @nullable
  @BuiltValueField(wireName: 'black_hole_transfer_count')
  int get transferCount;

  @nullable
  @BuiltValueField(wireName: 'black_hole_transfer_progress')
  int get transferProgress;

  @nullable
  @BuiltValueField(wireName: 'black_hole_transfer_currency')
  BuiltMap<String, BuiltMap<String, String>> get transferCurrency;

  String get progressCountLbl {
    if (transferCount != null && transferProgress != null) {
      return '${transferProgress >= transferCount ? transferCount : transferProgress}/$transferCount';
    }
    return '';
  }

  double get progressPercent {
    if (transferCount != null && transferProgress != null) {
      return NumberUtil.truncateDecimal(
          (transferProgress >= transferCount
                  ? transferCount
                  : transferProgress) /
              transferCount,
          2);
    }
    return 0;
  }

  String get transferAmount {
    if (transferCurrency != null && transferCurrency.isNotEmpty) {
      final firstFork = transferCurrency[transferCurrency.keys.first];
      if (firstFork != null && firstFork.containsKey('amount')) {
        return firstFork['amount'];
      }
    }
    return '';
  }

  String get transferFork {
    if (transferCurrency != null && transferCurrency.isNotEmpty) {
      return transferCurrency.keys.first;
    }
    return '';
  }

  // options 暂时没用到 还不知道什么类型
  // @nullable
  // @BuiltValueField(wireName: 'options')
  // BuiltMap<String, dynamic> get options;
}
