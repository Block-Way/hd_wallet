part of hdkey_domain_module;

abstract class HDKeyState implements Built<HDKeyState, HDKeyStateBuilder> {
// Constructors
  factory HDKeyState() {
    return _$HDKeyState._(
      isConnected: false,
    );
  }
  HDKeyState._();

  factory HDKeyState.fromCache() {
    try {
      return _$HDKeyState._();
    } catch (error) {
      return HDKeyState();
    }
  }
  static Serializer<HDKeyState> get serializer => _$hDKeyStateSerializer;

  List<dynamic> toCache() {
    return [];
  }

  bool get isConnected;
}
