part of hdkey_domain_module;

abstract class _BaseAction extends ReduxAction<AppState> {
  //
}

/// Init the Device SDK code to detect if a device is plugged in
/// - [Android] listen for event from SDK (when device is connected)
///
class HDKeyActionDeviceInit extends _BaseAction {
  HDKeyActionDeviceInit();

  @override
  Future<AppState> reduce() async {
    final hdDevice = GetIt.I<HDKeyDevice>();

    hdDevice.deviceAttached.listen((isConnected) {
      if (isConnected) {
        dispatch(HDKeyActionDeviceConnected());
      } else {
        dispatch(HDKeyActionDeviceDisconnected());
      }
    });

    hdDevice.walletCreated.listen((wallet) async {
      if (wallet != null) {
        await dispatchFuture(AppActionLoadWallet(wallet));
      }
    });

    // Start device listening
    hdDevice.init();

    return null;
  }
}

/// Device Connected:
/// - Read Device info (设备有没有创建硬件钱包)
/// - Load device wallet infos
///
class HDKeyActionDeviceConnected extends _BaseAction {
  HDKeyActionDeviceConnected();

  @override
  AppState reduce() {
    return state.rebuild(
      (b) => b.hdkeyState..isConnected = true,
    );
  }
}

/// Load all wallets in the connected Device
///
class HDKeyActionDeviceDisconnected extends _BaseAction {
  HDKeyActionDeviceDisconnected();

  @override
  Future<AppState> reduce() async {
    // Load wallets from device, make a local cache
    return state.rebuild(
      (b) => b.hdkeyState..isConnected = false,
    );
  }
}
