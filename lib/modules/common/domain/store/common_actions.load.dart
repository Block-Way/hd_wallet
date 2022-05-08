part of common_domain_module;

class CommonActionLoadCache extends _BaseAction {
  CommonActionLoadCache();

  @override
  Future<AppState> reduce() async {
    // Load Env
    await DotEnv().load();
    AppConstants.isBeta = DotEnv().env['IS_BETA'] == 'true';
    AppConstants.buildId = DotEnv().env['BUILD_ID'];
    AppConstants.commitHash = DotEnv().env['COMMIT_HASH'];

    // Check if is a new installation
    if (Platform.isIOS) {
      final shared = await SharedPreferences.getInstance();
      if (!shared.containsKey('isInitialized')) {
        final storage = FlutterSecureStorage();
        await storage.deleteAll();
        shared.setBool('isInitialized', true);
      }
    }

    // Load DB
    await AppHiveCache.initHive();

    // Getit
    await AppGetIt.initGetIt();

    var initialState = await appPersistor.readState();
    if (initialState == null) {
      initialState = AppState.initialState();
      await appPersistor.saveInitialState(initialState);
    }
    return store.state.rebuild((a) => a.replace(initialState));
  }
}

class CommonActionLoadDeviceInfo extends _BaseAction {
  CommonActionLoadDeviceInfo();

  @override
  Future<AppState> reduce() async {
    final appInfo = await PlatformUtils.getAppInfo();
    final deviceId = await PlatformUtils.getDeviceId();
    // final deviceInfo = await PlatformUtils.getDeviceInfo();
    return state.rebuild(
      (b) => b.commonState
        ..appInfo = appInfo
        ..deviceId = deviceId,
      // ..deviceInfo = deviceInfo
    );
  }
}

class CommonActionLoadSettings extends _BaseAction {
  CommonActionLoadSettings();

  @override
  Future<AppState> reduce() async {
    final settings = CommonRepository().getSettings();

    settings.installId = settings.installId ?? generateUuidV4();
    AppConfig().installId = settings.installId;

    return state.rebuild(
      (b) => b.commonState
        ..language = settings.language
        ..fiatCurrency = settings.fiatCurrency,
    );
  }
}

class CommonActionLoadHost extends _BaseAction {
  CommonActionLoadHost();

  @override
  Future<AppState> reduce() async {
    final hostBase64 = await CommonRepository().getApiDns();

    final apiUrl = utf8.decode(base64Decode(hostBase64));
    Request().updateBaseUrl(apiUrl);
    return null;
  }
}

class CommonActionLoadImageConfig extends _BaseAction {
  @override
  Future<AppState> reduce() async {
    final settings = CommonRepository().getSettings();
    final timeNow = DateTime.now();
    // Use cache last Signature
    final prevJson = settings.imageSignature;
    if (prevJson != null) {
      final prevSigned = prevJson['signed'] ?? {};
      AppConfig().setImageUrl(
        prevJson['url'].toString(),
        prevSigned['Key-Pair-Id']?.toString(),
        prevSigned['Policy']?.toString(),
        prevSigned['Signature']?.toString(),
      );
    }

    if (kDebugMode ||
        settings.imageSignatureLastUpdate == null ||
        timeNow
                .difference(DateTime.fromMillisecondsSinceEpoch(
                    settings.imageSignatureLastUpdate))
                .inDays >
            10) {
      final configJson = await CommonRepository().getConfigImage();
      final configSigned = configJson['signed'] ?? {};
      AppConfig().setImageUrl(
        configJson['url'].toString(),
        configSigned['Key-Pair-Id']?.toString(),
        configSigned['Policy']?.toString(),
        configSigned['Signature']?.toString(),
      );
      settings.imageSignature = configJson;
      settings.imageSignatureLastUpdate = timeNow.millisecondsSinceEpoch;
      await settings.save();
    }
    return null;
  }
}
