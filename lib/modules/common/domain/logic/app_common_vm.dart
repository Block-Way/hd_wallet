part of common_domain_module;

abstract class AppCommonVM implements Built<AppCommonVM, AppCommonVMBuilder> {
  factory AppCommonVM([void Function(AppCommonVMBuilder) updates]) =
      _$AppCommonVM;
  AppCommonVM._();

// UI Fields
  @BuiltValueField(compare: false)
  List<String> get debugStrings;
  bool get hasWallet;
  String get activeWalletId;
  String get activeWalletName;
  String get fiatCurrency;
  String get appVersion;
  String get appVersionBeta;
  bool get hasNewVersion;

// UI Actions
  @BuiltValueField(compare: false)
  Future<ConfigUpdateData> Function(bool checkBeta) get doCheckForUpdates;

  @BuiltValueField(compare: false)
  Future<void> Function(String language) get doChangeLanguage;

// UI Logic
  static AppCommonVM fromStore(Store<AppState> store) {
    final appInfo = store.state.commonState.appInfo;

    return AppCommonVM(
      (viewModel) => viewModel
        ..doChangeLanguage = (language) async {
          await store.dispatchFuture(CommonActionChangeLanguage(language));
          await store.dispatchFuture(CommonActionChangeFiatCurrency(
            AppLanguages.getCurrencyByLanguage(language),
          ));
        }
        ..doCheckForUpdates = (checkBeta) {
          final completer = Completer<ConfigUpdateData>();
          store.dispatch(CommonActionCheckVersion(
            completer,
            checkBeta: checkBeta,
          ));
          return completer.future;
        }
        ..debugStrings = [
          'IsBeta: ${AppConstants.isBeta}',
          'Build Id: ${AppConstants.buildId}',
          'Build Number: ${store.state.commonState?.appInfo?.buildNumber}',
          'Commit Hash: ${AppConstants.commitHash}',
          'Wallet Id: ${store.state.walletState.activeWalletId}',
          'DB path: ${AppHiveCache.storageLocation.path}',
          'Device Id: ${store.state.commonState?.deviceId}',
        ]
        ..fiatCurrency = store.state.commonState.fiatCurrency ?? ''
        ..activeWalletId = store.state.walletState.activeWalletId ?? ''
        ..activeWalletName = store.state.walletState.activeWallet?.name ?? ''
        ..hasWallet = store.state.walletState.hasWallet
        ..hasNewVersion =
            store.state.commonState.newVersion?.hasNewVersion ?? false
        ..appVersion = appInfo?.version ?? '0.0.0'
        ..appVersionBeta =
            '${appInfo?.version ?? '0.0.0'}.${AppConstants.buildId}',
    );
  }
}
