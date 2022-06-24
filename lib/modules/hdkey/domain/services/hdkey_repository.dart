part of hdkey_domain_module;

class HDKeyRepository {
// Singleton instance

  factory HDKeyRepository([
    HDKeyApi? _api,
    FlutterSecureStorage? _storage,
  ]) {
    _instance._api = _api ?? HDKeyApi();
    _instance._storage = _storage ?? FlutterSecureStorage();
    return _instance;
  }
  HDKeyRepository._internal();

  static final _instance = HDKeyRepository._internal();

  late HDKeyApi _api;
  late FlutterSecureStorage _storage;

// Methods

//  ▼▼▼▼▼▼ Manage Wallet ▼▼▼▼▼▼  //

  /// Write Mnemonic on Device
  void writeMnemonicOnDevice(String mnemonic) {
    // TODO: implement
    _api.toString();
    _storage.toString();
  }
}
