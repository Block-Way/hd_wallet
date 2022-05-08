part of utils;

class VersionUtils {
  // 优先认为 本地的版本是更高的
  static bool netIsNew({@required String local, @required String net}) {
    if (local == null || net == null) {
      return false;
    }

    final localNum = local.split('.');
    final netNum = net.split('.');

    if (localNum.length != netNum.length) {
      return false;
    }

    final min = math.min(localNum.length, netNum.length);
    for (var index = 0; index < min; index++) {
      if ((int.tryParse(netNum[index]) ?? 0) >
          (int.tryParse(localNum[index]) ?? 0)) {
        return true;
      }
    }

    return false;
  }
}
