part of admission_domain_module;

abstract class AdmissionState
    implements Built<AdmissionState, AdmissionStateBuilder> {
// Constructors
  factory AdmissionState() {
    return _$AdmissionState._(
      admissionList: BuiltList([]),
    );
  }
  AdmissionState._();

  factory AdmissionState.fromCache(
    List<dynamic> _,
  ) {
    try {
      return _$AdmissionState._(
        admissionList: BuiltList([]),
      );
    } catch (_) {
      return AdmissionState();
    }
  }

  List<dynamic> toCache() {
    try {
      return [];
    } catch (_) {
      return [];
    }
  }

// Config
  @nullable
  AdmissionConfig get config;

  @nullable
  int get configState;

// Fields
  @nullable
  BuiltList<AdmissionInfo> get admissionList;
}
