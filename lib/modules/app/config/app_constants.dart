part of app_module;

class AppConstants {
  static const bbc_fork =
      '00000000a137256624bda82aec19645b1dd8d41311ceac9b5c3e49d2822cd49f';
  static const btca_fork =
      '0000000190e31a56bea3d263cc271649bf72ef1bf5ca8aa7e271ba9dd754f2da';
  static const hah_fork =
      '000000007fd73a8a4dc7cb9e67dd9a8f61a09606514c4f9f7c8c7867a2a47944';
  static const codeVersion = 0;

  // From env
  static bool isBeta = true;
  static String buildId = '0';
  static String commitHash = 'local';

  // App Info
  static const appName = 'Sugar';

  // Api/Service data
  static const apiUrl = [
    // 'https://hapi.sugar.one/api',
    'http://119.8.55.78:7711'
  ];
  static const apiUrlDev = [
    'http://dabank.coinbi.io:8000/sugar_api',
  ];
  static const imageUrl = 'https://image.sugar.one/';

  // AppCenter
  static const appCenterId = 'Sugar-Mirror';
  static const appCenterIOsSecret = '8a747517-190c-40e9-84cd-5620cf4ad6d7';
  static const appCenterAndroidSecret = '1f372149-8eee-4eaa-8105-610c753d72c1';
  static const appCenterIOsDist = '9ca5b51c-b363-4655-93b9-291246901a1f';
  static const appCenterAndroidDist = 'd8aab221-5f96-4fc4-8d2b-d69ae8efa5bb';

  static const sentryDnsBeta =
      'https://c8147acda83e4de98fc9b239d958f0b3@o381530.ingest.sentry.io/5557281';
  static const sentryDnsProd =
      'https://211e5700eaf94713a1308c6c7b273140@o381530.ingest.sentry.io/5557833';

  static const amplitudeApiKey = 'd96d63bb78e3de19567eae1b3d523cf5';
  static const etherscanApiKey = 'M4ECBHNAZA8DRPPF2FK19I1CZSR64PXFZU';

  static const defaultLanguage = 'en';
  static const defaultCurrency = 'USD';
  static final supportedCurrency = ['CNY', 'USD'];

  static const defaultMarket = 'BBC';
  static const defaultTradePair = 'BBC/USDT-TRC20';
  static const dexConfigVersion = 20210208;

  static const admissionUUID = '99757c2b210e4bd898dcf239b233e301';
  static const swapUUID = '4b19a2cabd0d4e859b02bc776af87d01';

  static const fiatPrecision = 2;

  static String get sentryDns => isBeta ? sentryDnsBeta : sentryDnsProd;

  static String get randomApiUrl {
    final random = math.Random();
    final randomIndex = random.nextInt(apiUrl.length);
    return apiUrl[randomIndex];
  }
}
