part of app_module;

class AppConfig {
  factory AppConfig() {
    return _singleton;
  }

  AppConfig._internal() {
    //
  }

  static final AppConfig _singleton = AppConfig._internal();

// Fields
  String _imageUrl = AppConstants.imageUrl;
  String _imageUrlKey = '';
  String _imageUrlPolicy = '';
  String _imageUrlSignature = '';

  String installId = '';

// Getters
  String get appCenterAppSecret => Platform.isAndroid
      ? AppConstants.appCenterAndroidSecret
      : AppConstants.appCenterIOsSecret;

  String get appCenterDistribution => Platform.isAndroid
      ? AppConstants.appCenterAndroidDist
      : AppConstants.appCenterIOsDist;

// Methods
  void setImageUrl(String url, String key, String policy, String signature) {
    _imageUrl = url ?? AppConstants.imageUrl;
    _imageUrlKey = key;
    _imageUrlPolicy = policy;
    _imageUrlSignature = signature;
  }

  String getImageUrlFor(String path) {
    if (_imageUrl == null) {
      return 'assets/images/error_image.png';
    }
    if (_imageUrlKey != null &&
        _imageUrlPolicy != null &&
        _imageUrlSignature != null) {
      return '''$_imageUrl$path?Key-Pair-Id=$_imageUrlKey&Policy=$_imageUrlPolicy&Signature=$_imageUrlSignature''';
    }
    return '$_imageUrl$path';
  }
}
