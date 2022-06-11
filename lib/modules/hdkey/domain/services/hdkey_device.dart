part of hdkey_domain_module;

enum HDKeyDeviceStatus {
  /// Device connected, read device info (has PIN, etc)
  connecting,

  /// Device empty, need to initialized (create waller and set PIN, etc)
  empty,

  /// Device has wallet need authorize (login with PIN)
  authorize,

  /// Device Initialized, ready to use
  ready,

  /// Device Connected, but enter PIN is not correct
  unauthorized,

  /// An Error occurred while operating the device, try disconnect and reconnect
  error,

  disconnected,
}

final kHDKeyChainSoltMapping = {
  'BBC': 0x00,
  'BTC': 0x01,
  'ETH': 0x02,
  'TRX': 0x03,
};

class HDKeyDevice {
  final _statusChanged = BehaviorSubject<HDKeyDeviceStatus>();
  final _deviceAttached = StreamController<bool>.broadcast();
  final _walletCreated = StreamController<Wallet>.broadcast();
  late String _connectedWalletId;

  Stream<HDKeyDeviceStatus> get statusChanged => _statusChanged.stream;
  Stream<bool> get deviceAttached => _deviceAttached.stream;
  Stream<Wallet> get walletCreated => _walletCreated.stream;

  /// Current connected device wallet ID
  /// - null if no device are connected
  String get connectedWalletId => _connectedWalletId;

  void _log(String type, String message) {
    dev.log(
      '[$type]: $message',
      name: 'HDKEY',
      time: DateTime.now(),
    );
  }

  Future<bool> init() async {
    _log('Init', 'Initial device state');

    HDKeyCore.addEventListener((event) async {
      switch (event?.toString()) {
        case 'DeviceAttached':
          _deviceAttached.add(true);
          //_connectedWalletId = null;
          _emitStatus(HDKeyDeviceStatus.connecting);

          if (kDebugMode) {
            await Future.delayed(Duration(seconds: 1));
          }

          HDKeyCore.connectHDKey().then((isConnected) {
            if (isConnected) {
              HDKeyCore.getDeviceStatus().then((info) {
                final isInitialized = info['pincode'] == '0';
                _emitStatus(isInitialized
                    ? HDKeyDeviceStatus.authorize
                    : HDKeyDeviceStatus.empty);
              }).catchError((error) {
                _emitStatus(HDKeyDeviceStatus.error);
                _log('Init getDeviceStatus', 'error$error');
              });
            } else {
              _emitStatus(HDKeyDeviceStatus.disconnected);
            }
          }).catchError((error) {
            _emitStatus(HDKeyDeviceStatus.error);
            _log('Init connectHDKey', 'error$error');
          });

          break;
        case 'DeviceDetached':
          _deviceAttached.add(false);
          //_connectedWalletId = null;
          _emitStatus(HDKeyDeviceStatus.disconnected);
          break;
        default:
      }
    });

    // Using Device SDK, listen for connection,
    // when device is Connected emit action
    return false;
  }

  void _emitStatus(HDKeyDeviceStatus status) {
    _statusChanged.add(status);
  }

  // Methods

  // @visibleForTesting
  Future<void> testDeviceConnection({required bool isConnected}) async {
    if (isConnected) {
      return HDKeyCore.testDeviceDetached();
    }
    return HDKeyCore.testDeviceAttached();
  }

  /// Create new
  Future<bool> createNew(String pinCode) async {
    if (kDebugMode) {
      await Future.delayed(Duration(seconds: 1));
    }
    await HDKeyCore.setPin(pinCode);

    final mnemonic = await WalletRepository().generateMnemonic();

    final chainAddress = await WalletRepository().importMnemonic(
      mnemonic: mnemonic,
      // options: WalletCoreOptions(),
    );

    try {
      kHDKeyChainSoltMapping.forEach((key, value) async {
        final item = chainAddress[key];
        if (item != null) {
          // 初始化 钱包私钥
          await HDKeyCore.writeKeyPair(
            solt: value,
            privateKey: item.privateKey,
            publicKey: item.publicKey,
          );
        } else {
          throw Error(); // 如果配置某个币种没有，意味着钱包有问题
        }
      });

      await HDKeyCore.writeSecret(secret: 0, data: mnemonic);
      return true;
    } catch (e) {
      // 重置钱包，为了去掉有问题的 币种地址
      HDKeyCore.resetDevice(pinCode);
      return false;
    }
  }

  // 验证pin 一定在 get status 之前
  Future<bool> authorize(String pinCode) async {
    // access by pin code
    final isValid = await HDKeyCore.accessByPinCode(pinCode);
    if (isValid == true) {
      final mnemonic = await HDKeyCore.readSecret(0);
      final walletId = await generateWalletId(mnemonic);

      // If we don't have this HDKey wallet, add it
      final wallet = await WalletRepository().getWalletById(walletId);
      if (wallet == null) {
        final chainAddress = await WalletRepository().importMnemonic(
          mnemonic: mnemonic,
          // options: WalletCoreOptions(),
        );
        // Create new wallet locally
        final addresses = kHDKeyChainSoltMapping.entries.map((item) {
          final coin = chainAddress[item.key];
          return CoinAddress(
            chain: item.key,
            symbol: item.key,
            address: coin?.address ?? '',
            publicKey: coin?.publicKey ?? '',
          );
        }).toList();

        final wallet = Wallet(
          id: walletId,
          name: 'HDKey Wallet',
          type: WalletType.device,
          coins: AppCoins.defaultCoins, // TODO: check supported coins
          addresses: addresses,
          hasBackup: true,
        );

        await WalletRepository().saveWallet(walletId, wallet);

        _walletCreated.add(wallet);
      }
      _connectedWalletId = walletId;

      _emitStatus(HDKeyDeviceStatus.ready);
    }
    return isValid;
  }

  Future<bool> changePinCode({
    required String oldPinCode,
    required String newPinCode,
  }) async {
    return HDKeyCore.changePin(oldPin: oldPinCode, newPin: newPinCode);
  }

  Future<bool> resetPinCode() async {
    return false;
  }
}
