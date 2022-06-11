part of trade_domain_module;

class TradeActionLoadMqtt extends _BaseAction {
  TradeActionLoadMqtt();

  @override
  Future<AppState?> reduce() async {
    return null;
    /*
    final mqtt = GetIt.I<TradeMqtt>();

    final mqttHost = store.state.tradeState.config!.randomMqttHost;
    final settings = await SettingsRepository().getSettings();

    var username = 'dex';
    var password = 'KXe7Br9obJlyuGc2';
    var host = mqttHost.key;
    var port = mqttHost.value;
    var useTls = true;

    if (AppConstants.isBeta) {
      useTls = settings.isMqttUseTls;
    }

    if (AppConstants.isBeta && !settings.isMqttUseTls) {
      username = '';
      password = '';
    }
    if (AppConstants.isBeta && settings.isMqttUseTls) {
      host = '18.180.197.171';
      port = 8883;
    }

    await mqtt.initMqtt(
      clientId: store.state.commonState.deviceId ?? '',
      useTls: useTls,
      username: username,
      password: password,
      host: host,
      port: port,
      disabled: AppConstants.isBeta && settings.isMqttDisabled,
    );

    return null;
    */
  }

  @override
  Object? wrapError(dynamic error) {
    return error;
  }
}

class TradeActionSubscribeMqttOrder extends _BaseAction {
  TradeActionSubscribeMqttOrder(this.tradePair);
  final TradePair tradePair;

  @override
  Future<AppState?> reduce() async {
    final mqtt = GetIt.I<TradeMqtt>();

    mqtt.walletId = state.walletState.activeWalletId!;

    if (!mqtt.isConnected) {
      await dispatchAsync(TradeActionLoadMqtt());
    }

    // Subscribe to topic for this Trade Pair
    mqtt.subscribe('dex/deep/${tradePair.toMqttTopic()}');
    mqtt.subscribe('dex/price/${tradePair.toMqttTopic()}');
    mqtt.subscribe('dex/match/${tradePair.toMqttTopic()}');

    return null;
  }

  @override
  Object? wrapError(dynamic error) {
    return error;
  }
}
