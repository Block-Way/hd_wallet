part of app_module;

class AnalyticsReport {
  // Singleton instance

  factory AnalyticsReport() {
    _instance._analytics = Amplitude.getInstance(instanceName: '304538');
    _instance._analytics.init(AppConstants.amplitudeApiKey);

    // Enable COPPA privacy guard.
    // This is useful when you choose not to report sensitive user information.
    // await  analytics.enableCoppaControl();

    _instance._analytics.setServerUrl('https://api2.amplitude.com');
    _instance._analytics.trackingSessionEvents(true);

    final userProps = {
      'isBeta': AppConstants.isBeta,
      'codeVersion': AppConstants.codeVersion,
    };
    _instance._analytics.setUserProperties(userProps);

    return _instance;
  }

  AnalyticsReport._internal();

  static final AnalyticsReport _instance = AnalyticsReport._internal();

  Amplitude _analytics;

  void setUserId(String id) {
    _analytics.setUserId(id);
  }

  Future<void> reportLog(String eventType, Map<String, dynamic> data) async {
    // Log an event
    if (!kDebugMode && !AppConstants.isBeta) {
      await _analytics.logEvent(eventType, eventProperties: {...data});
    }
  }
}
