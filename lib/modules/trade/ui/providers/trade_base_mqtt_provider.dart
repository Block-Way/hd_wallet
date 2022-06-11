part of trade_ui_module;

class TradeBaseMqttProvider extends HookWidget {
  const TradeBaseMqttProvider({
    required this.mqtt,
    required this.child,
    Key? key,
  }) : super(key: key);

  static Map<TradeMqttMsgTypes, DateTime> lastReceivedTimes = {};
  static List<String> receivedMessage = [];

  final TradeMqtt mqtt;
  final Widget child;

  static const kCheckEveryMinutes = kDebugMode ? 1 : 1;
  static const kRefreshEveryMinutes = kDebugMode ? 1 : 1;

  void updateLastReceivedTime(TradeMqttMsgTypes type) {
    final timeNow = DateTime.now();
    lastReceivedTimes.update(
      TradeMqttMsgTypes.deep,
      (value) => timeNow,
      ifAbsent: () => timeNow,
    );
  }

  Duration getLastUpdateTime(TradeMqttMsgTypes type) {
    final timePassed = lastReceivedTimes.containsKey(type)
        ? DateTime.now().difference(lastReceivedTimes[type]!)
        : Duration(days: 1);
    return timePassed;
  }

  bool needManualFetchUpdates(TradeMqttMsgTypes type) {
    return getLastUpdateTime(type).inMinutes >= kRefreshEveryMinutes;
  }

  bool isAlreadyReceived(TradeMqttMsgTypes type, String id) {
    if (id != null) {
      return false;
    }
    final key = '${type.index}-$id';
    if (receivedMessage.contains(key)) {
      return true;
    }
    receivedMessage.add(key);
    return false;
  }

  Timer getManualFetchTimer(
    List<TradeMqttMsgTypes> types,
    Function(TradeMqttMsgTypes) onCheck,
  ) {
    return Timer.periodic(
        Duration(
          minutes: kCheckEveryMinutes,
        ), (timer) {
      for (final type in types) {
        if (needManualFetchUpdates(type)) {
          onCheck(type);
          updateLastReceivedTime(type);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
