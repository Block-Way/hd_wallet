part of utils;

const bool inProduction = bool.fromEnvironment('dart.vm.product');

class DeviceInfo {
  DeviceInfo({
    this.brand,
    this.model,
    this.product,
    this.manufacturer,
    this.deviceId,
    this.osName,
    this.osVersion,
    this.osBuild,
  });

  final String brand;
  final String model;
  final String product;
  final String manufacturer;
  final String deviceId;
  final String osName;
  final String osVersion;
  final String osBuild;

  Map<String, String> toJson() {
    final data = <String, String>{};
    data['Brand'] = brand;
    data['Model'] = model;
    data['Manufacturer'] = manufacturer;
    data['OsName'] = osName;
    data['OsVersion'] = osVersion;
    return data;
  }
}

class PlatformUtils {
  static Future<PackageInfo> getAppInfo() {
    return PackageInfo.fromPlatform();
  }

  static Future<String> getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  static Future<String> getBuildNumber() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.buildNumber;
  }

  static Future<String> getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();
    var deviceId = '';
    if (Platform.isAndroid) {
      final data = await deviceInfo.androidInfo;
      deviceId = data.androidId;
    } else if (Platform.isIOS) {
      final data = await deviceInfo.iosInfo;
      deviceId = data.identifierForVendor;
    }
    return deviceId;
  }

  static Future<DeviceInfo> getDeviceInfo() async {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final info = await deviceInfo.androidInfo;
      return DeviceInfo(
        brand: info.brand,
        model: info.model,
        product: info.display,
        manufacturer: info.manufacturer,
        deviceId: info.androidId,
        osName: 'Android',
        osVersion: info.version.release,
        osBuild: info.version.incremental,
      );
    } else if (Platform.isIOS) {
      final info = await deviceInfo.iosInfo;
      return DeviceInfo(
        brand: info.utsname.machine,
        model: info.model,
        product: info.localizedModel,
        manufacturer: 'Apple',
        deviceId: info.identifierForVendor,
        osName: info.systemName,
        osVersion: info.systemVersion,
      );
    } else {
      return null;
    }
  }
}
