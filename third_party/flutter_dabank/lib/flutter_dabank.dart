import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EventData {
  EventData(dynamic data) {
    type = data['type']?.toString();
    value = data['value']?.toString();
    error = data['error']?.toString();
  }

  String type;
  String value;
  String error;

  bool get isUpdate => type == 'update';

  bool get isError => error?.isNotEmpty;

  int get intValue => int.tryParse(value) ?? 0;
}

class FlutterDabank {
  static const _methodChannel = MethodChannel('flutter_dabank');
  static const _eventChannel = EventChannel('flutter_dabank_event');
  static final Stream<EventData> _eventStream = _eventChannel
      .receiveBroadcastStream()
      .where((event) => event is Map)
      .map((event) => EventData(event));

  static final Map<int, Function> listeners = {};

  static Future<void> updateAppAndroid({
    @required String url,
    @required bool forceUpdate,
  }) async {
    final params = {'url': url};
    await _methodChannel.invokeMethod<void>('updateAppAndroid', params);
  }

  static Future<void> cancelUpdate() async {
    await _methodChannel.invokeMethod<void>('cancelUpdate');
  }

  static Future<void> installApk() async {
    await _methodChannel.invokeMethod<void>('installApk');
  }

  static Stream<int> get updateDownloadProgress => _eventStream
      .where((event) => event.isUpdate)
      .map((event) => event.intValue);

  static Stream<String> get updateDownloadErrors => _eventStream
      .where((event) => event.isUpdate)
      .where((event) => event.isError)
      .map((event) => event.error);
}
