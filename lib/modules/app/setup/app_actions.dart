part of app_module;

abstract class _BaseAction extends ReduxAction<AppState> {
  //
}

class AppActionInitApp extends _BaseAction {
  AppActionInitApp(this.progress);

  final StreamController<double> progress;

  @override
  Future<AppState> reduce() async {
    // Init App Actions
    progress.add(0.1);

    // 1- Load State
    await store.dispatchFuture(CommonActionLoadCache(), notify: false);

    // 2- Load/Update device info in CommonState
    await store.dispatchFuture(CommonActionLoadDeviceInfo(), notify: false);

    // 3- Load Settings
    await store.dispatchFuture(CommonActionLoadSettings(), notify: false);

    // 4- Setup API header with app info
    Request().setup(
      AppConstants.randomApiUrl,
      headers: {
        'app-os': Platform.isIOS ? ' ios' : 'android',
        'app-build': state.commonState.appInfo.buildNumber,
        'app-version': state.commonState.appInfo.version,
        'app-language': state.commonState.languageForApi,
      },
    );

    if (AppConstants.isBeta) {
      final settings = await SettingsRepository().getSettings();
      Request().updateHeader('env', 'develop');
      if (settings.hasApiBaseUrl) {
        Request().updateBaseUrl(settings.apiBaseUrl);
      }
      if (settings.hasApiAppVersion) {
        Request().updateHeader('app-version', settings.apiAppVersion);
      }
      if (settings.hasProxyUrl && Platform.isAndroid) {
        Request().setupProxy(settings.proxyUrl);
      }
    } else {
      // First get api url from api1
      store.dispatch(CommonActionLoadHost(), notify: false);
    }
    progress.add(0.5);

    // 5- Initial Data
    store
        .dispatchFuture(WalletActionWalletLoadAll(), notify: false)
        .whenComplete(() {
      store.dispatch(AppActionLoadWallet(state.walletState.activeWallet));
    });
    store.dispatch(CommonActionLoadConfig(), notify: false);
    store.dispatch(CommonActionLoadImageConfig(), notify: false);
    store.dispatch(TradeActionLoadConfig(), notify: false);
    store.dispatch(CommunityActionLoadConfig(), notify: false);
    store.dispatch(AdmissionActionLoadConfig(), notify: false);
    store.dispatch(SwapActionLoadConfig(), notify: false);
    if (AppConstants.isBeta) {
      store.dispatch(InvestActionLoadConfig(), notify: false);
    }

    progress.add(0.8);

    AnalyticsReport().setUserId(state.commonState.deviceId);
    AnalyticsReport().reportLog(
      'InitApp',
      {'version': state.commonState.appInfo.version},
    );

    progress.add(1);
    return null;
  }

  @override
  Object wrapError(dynamic error) {
    CrashesReport().reportEvent(
      'CommonLog_01_InitApp',
      error,
      StackTrace.current,
    );
    return error;
  }
}

// /// Select and activate a Wallet
// /// - We will "sync" the wallet coin with online coins, in order to add new coins to the wallet
// /// - We will create AssetCoin to display to our asset list
class AppActionLoadWallet extends _BaseAction {
  AppActionLoadWallet(this.wallet);
  final Wallet wallet;

  @override
  Future<AppState> reduce() async {
    // Make sure I set the current wallet
    await dispatchFuture(WalletActionWalletSetActive(wallet));

    await dispatchFuture(AssetActionSyncWalletCoins(wallet));
    // Action to be perform after we load the wallet
    if (wallet != null) {
      // Update prices
      dispatch(AssetActionUpdatePrices(
        store.state.commonState.fiatCurrency,
      ));
      // Update balances
      dispatch(AssetActionUpdateWalletBalances(
        wallet: wallet,
        skipFrequentUpdate: true,
      ));

      dispatch(InvestActionClear());
      dispatch(InvitationActionClear());
      dispatch(TradeActionReSubmitCancelTxid());

      // Check wallet status and register
      dispatch(WalletActionWalletRegister(wallet));
    }
    return null;
  }

  @override
  Object wrapError(dynamic error) {
    CrashesReport().reportEvent(
      'WalletLog_03_LoadActiveWallet',
      error,
      StackTrace.current,
    );
    return error;
  }
}

class AppActionAfterChangeLanguage extends _BaseAction {
  AppActionAfterChangeLanguage(this.language);
  final String language;

  @override
  AppState reduce() {
    // NOTE: Add Actions that need reload data when change Language
    dispatch(CommunityActionLoadConfig());
    dispatch(HomeActionInit());

    return null;
  }
}

class AppActionAfterChangeFiatCurrency extends _BaseAction {
  AppActionAfterChangeFiatCurrency(this.fiatCurrency);
  final String fiatCurrency;

  @override
  AppState reduce() {
    // NOTE: Add Actions that need reload data when change Fiat Currency
    dispatch(AssetActionUpdatePrices(fiatCurrency));

    return null;
  }
}

class AppActionAfterCommonConfig extends _BaseAction {
  AppActionAfterCommonConfig(this.config);
  final Config config;

  @override
  AppState reduce() {
    // NOTE: Add Actions that need execute after get the main config
    dispatch(AssetActionSyncWalletCoins(state.walletState.activeWallet));

    return null;
  }
}
