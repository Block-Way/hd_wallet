part of app_module;

final _ignoreErrors = [
  'VideoError, Video player had error',
  'Error: query timeout,110',
  'OS Error: Software caused connection abort',
  'OS Error: Operation timed out',
  'OS Error: Broken pipe',
  'DioError',
  'ETH地址有误',
  'TimeoutException',
  'SocketException',
  'Connection timed out',
  'Tx rejected : transaction inputs are conflicting',
];

class CrashesReport {
  // Singleton instance

  factory CrashesReport() {
    _instance._sentry = SentryClient(SentryOptions(
      dsn: AppConstants.sentryDns,
    ));
    return _instance;
  }
  CrashesReport._internal();

  static final CrashesReport _instance = CrashesReport._internal();

  // Fields
  SentryClient _sentry;
  PackageInfo _appInfo;
  DeviceInfo _deviceInfo;

  static FutureOr<void> getSentryOptions(SentryFlutterOptions options) {
    options.dsn = AppConstants.sentryDns;
    options.environment = AppConstants.isBeta ? 'beta' : 'production';
    // options.debug = AppConstants.isBeta;
    options.beforeSend = (event, {hint}) {
      if (kDebugMode ||
          _ignoreErrors
              .where((text) => event.exception?.value?.contains(text))
              .isNotEmpty) {
        dev.log(
          'Report: Ignore error',
          error: event.toJson(),
          name: 'CrashesReport',
        );
        return null;
      }
      return event;
    };
  }

  Future<Contexts> getAppContexts() async {
    _appInfo = _appInfo ?? await PlatformUtils.getAppInfo();
    _deviceInfo = _deviceInfo ?? await PlatformUtils.getDeviceInfo();

    return Contexts(
      operatingSystem: OperatingSystem(
        name: _deviceInfo.osName,
        version: _deviceInfo.osVersion,
        build: _deviceInfo.osBuild ?? '',
      ),
      app: App(
        name: _appInfo.appName,
        version: _appInfo.version,
        identifier: _appInfo.packageName,
        build: _appInfo.buildNumber,
        deviceAppHash: _deviceInfo.deviceId,
        startTime: DateTime.now().toUtc(),
      ),
      device: Device(
        model: _deviceInfo.model,
        modelId: _deviceInfo.product,
        brand: _deviceInfo.brand,
        manufacturer: _deviceInfo.manufacturer,
        bootTime: DateTime.now().toUtc(),
        timezone: DateTime.now().timeZoneName,
      ),
    );
  }

  /// Reports [error] along with its [stackTrace] to Sentry.io.
  Future<void> reportEvent(
    String name,
    dynamic error,
    StackTrace stackTrace, [
    Map<String, String> extra,
  ]) async {
    // Errors thrown in development mode are unlikely to be interesting. You can
    // check if you are running in dev mode using an assertion and omit sending
    // the report.
    if (kDebugMode) {
      dev.log(
        'ReportError: $name',
        error: error,
        stackTrace: stackTrace,
        name: 'CrashesReport',
      );
      return;
    }

    final errorMessage = error?.toString() ?? '';
    if (_ignoreErrors.where((text) => errorMessage.contains(text)).isNotEmpty) {
      return;
    }

    final contexts = await getAppContexts();

    final event = SentryEvent(
      logger: name,
      environment: AppConstants.isBeta ? 'beta' : 'production',
      extra: extra,
      contexts: contexts,
    );

    _submitToSentry(event);
  }

  Future<bool> _submitToSentry(SentryEvent event) async {
    await _sentry.captureEvent(event);
    return true;
  }

  Map<String, dynamic> getAppBugLog(SentryEvent event) {
    final timeNow = DateTime.now();
    final appInfo = event.contexts.app;
    final deviceInfo = event.contexts.device;
    final osInfo = event.contexts.operatingSystem;
    final data = {
      'type': 'managedError',
      'timestamp': timeNow.toIso8601String(),
      'appLaunchTimestamp': timeNow.toIso8601String(),
      'processId': '123',
      'id': generateUuidV4(),
      'fatal': true,
      'processName': AppConstants.appName,
      'device': {
        'sdkVersion': osInfo.kernelVersion,
        'osName': osInfo.name,
        'osVersion': osInfo.version,
        'model': deviceInfo.model,
        'appVersion': appInfo.version,
        'appBuild': appInfo.build,
        'appIsBeta': AppConstants.isBeta,
        'appReleaseId': AppConstants.buildId,
        'appCodeVersion': AppConstants.codeVersion,
        'appCodeCommit': AppConstants.commitHash,
      },
      'extra': event.extra,
      'userId': _deviceInfo.deviceId,
      'exception': {
        'type': 'Exception',
        'message': event.exception.toString(),
        'stackTrace': event.stackTrace?.toString(),
      }
    };

    return data;
  }

  Future<bool> submitToAppCenter(Map<String, dynamic> data) async {
    // try {
    //   final request = Request().postExternal('/logs?Api-Version=1.0.0',
    //       baseUrl: 'https://in.appcenter.ms',
    //       options: Options(headers: {
    //         'app-secret': AppConfig().appCenterAppSecret,
    //         'install-id': AppConfig().installId,
    //       }),
    //       data: data);
    //   await request;
    // } catch (error) {
    //   dev.log(
    //     'AppCenter Error $error',
    //     name: 'CrashesReport',
    //   );
    // }

    return true;
  }
}
