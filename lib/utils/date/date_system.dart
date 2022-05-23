part of utils;

class SystemDate {
  static int systemTime = 0;
  static int localTime = 0;
  static void initTime(int time) {
    systemTime = time;
    localTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  }

  static int getTime() {
    final nowTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    return nowTime;
    /*
    if (systemTime == 0) {
      return nowTime;
    }

    return nowTime - localTime + systemTime;
    */
  }
}
