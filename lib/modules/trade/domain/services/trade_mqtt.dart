part of trade_domain_module;

enum TradeMqttMsgTypes {
  deep,
  price,
  change,
  orderMatch,
  chartKLine,
  chartInfo,
  newest,
}

class TradeMqttMessage {
  TradeMqttMessage({
    @required this.type,
    @required this.data,
    @required this.topic,
    @required this.topicArgs,
  });

  final TradeMqttMsgTypes type;
  final dynamic data;
  final String topic;
  final String topicArgs;
}

class TradeMqtt {
  MqttServerClient _client;

  String walletId;

  bool isInitialized = false;
  final _messages = StreamController<TradeMqttMessage>.broadcast();

  Stream<TradeMqttMessage> get messages => _messages.stream;

  bool get isConnected =>
      _client != null &&
      _client.connectionStatus.state == MqttConnectionState.connected;

  void _log(String type, String message) {
    dev.log(
      '[$type]: $message',
      name: 'MQTT',
      time: DateTime.now(),
    );
  }

  void onConnected() {
    _log('Connected', 'OK Connected');

    _client.updates.listen((messages) async {
      for (final message in messages) {
        final topic = message.topic;
        final payload = message.payload as MqttPublishMessage;

        if (topic.startsWith('dex/deep')) {
          final data = await compute(_parseMqttJsonPayload, payload);
          if (data != null) {
            _messages.sink.add(
              TradeMqttMessage(
                type: TradeMqttMsgTypes.deep,
                data: data,
                topic: topic,
                topicArgs: topic.substring('dex/deep/'.length),
              ),
            );
          }
        } else if (topic.startsWith('dex/price')) {
          final data = await compute(_parseMqttJsonPayload, payload);
          if (data != null) {
            _messages.sink.add(
              TradeMqttMessage(
                type: TradeMqttMsgTypes.price,
                data: data,
                topic: topic,
                topicArgs: topic.substring('dex/price/'.length),
              ),
            );
          }
        } else if (topic.startsWith('dex/match')) {
          final data = await compute(_parseMqttStringPayload, payload);
          if (data != null) {
            _messages.sink.add(
              TradeMqttMessage(
                type: TradeMqttMsgTypes.orderMatch,
                data: data,
                topic: topic,
                topicArgs: topic.substring('dex/match/'.length),
              ),
            );
          }
        }
      }
    });
  }

  /// The subscribed callback
  void onSubscribed(String topic) {
    _log('Subscribe', 'OK for $topic!');
  }

  /// The unsolicited disconnect callback
  void onDisconnected() {
    if (_client.connectionStatus.returnCode ==
        MqttConnectReturnCode.brokerUnavailable) {
      _log('Disconnected', 'Client manually disconnected, will not reconnect');
    } else {
      _log('Disconnected', 'Client abruptly disconnected, try reconnect');
    }
  }

  void onPong() {
    _log('Pong', 'OK Ping');
  }

  void subscribe(String topic) {
    if (isConnected) {
      _client.subscribe(topic, MqttQos.atMostOnce);
    }
  }

  void unsubscribe(String topic) {
    if (isConnected) {
      _client.unsubscribe(topic);
    }
  }

  Future<bool> initMqtt({
    @required String clientId,
    @required String username,
    @required String password,
    @required String host,
    @required int port,
    @required bool useTls,
    @required bool disabled,
  }) async {
    if (_client != null) {
      return true;
    }

    isInitialized = false;

    _client = MqttServerClient.withPort(
      host,
      clientId,
      port,
    );

    if (useTls == true) {
      bool onBadCertificate(_) {
        return true;
      }

      _client.onBadCertificate = onBadCertificate;
      _client.secure = true;
    }
    _client.keepAlivePeriod = 20;
    _client.autoReconnect = true;
    _client.resubscribeOnAutoReconnect = true;
    _client.onDisconnected = onDisconnected;
    _client.onConnected = onConnected;
    _client.onSubscribed = onSubscribed;
    _client.pongCallback = onPong;
    _client.setProtocolV311();

    _client.logging(on: kDebugMode);

    /// Create a connection message to use or use the default one.
    /// The default one sets the
    /// client identifier, any supplied username/password, the default keep alive interval(60s)
    /// and clean session, an example of a specific one below.
    _client.connectionMessage = MqttConnectMessage()
        .withClientIdentifier(clientId)
        .authenticateAs(username, password)
        .keepAliveFor(60)
        .startClean()
        .withWillQos(MqttQos.atMostOnce);

    /// Connect the client, any errors here are communicated by
    ///  raising of the appropriate exception. Note
    /// in some circumstances the broker will
    /// just disconnect us, see the spec about this, we however it will
    /// never send malformed messages.
    try {
      if (disabled != true) {
        await _client.connect();
      }
    } catch (error) {
      _log('InitMqtt', 'Failed to connect $error');
    }

    /// Check if we are connected
    switch (_client.connectionStatus.state) {
      case MqttConnectionState.connected:
        isInitialized = true;
        break;
      case MqttConnectionState.faulted:
        isInitialized = false;
        _client = null;
        break;
      default:
    }

    return isInitialized;
  }

  static Future<dynamic> _parseMqttStringPayload(
    MqttPublishMessage msg,
  ) async {
    try {
      final messageContent = MqttPublishPayload.bytesToStringAsString(
        msg.payload.message,
      );
      return messageContent;
    } catch (_) {
      return null;
    }
  }

  static Future<dynamic> _parseMqttJsonPayload(
    MqttPublishMessage msg,
  ) async {
    try {
      final messageContent = MqttPublishPayload.bytesToStringAsString(
        msg.payload.message,
      );
      return jsonDecode(messageContent) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }
}
