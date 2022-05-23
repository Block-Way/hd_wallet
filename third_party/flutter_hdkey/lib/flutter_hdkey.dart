import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hdkey/request_bytes_builder.dart';

export 'byte_utils.dart';
export 'request_bytes_builder.dart';

enum _ResultEnum {
  string,
  integer,
  hex,
}

class HDKeyCore {
  static const _methodChannel = MethodChannel('flutter_hdkey');

  static const _eventChannel = EventChannel('flutter_hdkey_event');

  /// 获取模块关于信息
  static const _tagGetAbout = 0x01;

  // /// 查询模块的运行状态
  // static const _tagDeviceStatus = 0x02;

  // /// 设置(新建&修改)硬件访问密钥
  // static const _tagSetPinCode = 0x03;

  /// 硬件模块接入验证（登录）
  static const _tagAccessByPinCode = 0x04;

  /// 写入私钥
  static const _tagWriteKeyPair = 0x05;

  /// 擦除私钥（需要再次验证pin code）
  static const _tagEraseKeyPair = 0x06;

  // /// 写入秘密数据
  // static const _tagWriteSecret = 0x07;

  // ///	擦除秘密（需要验证pin code）
  // static const _tagEraseSecret = 0x08;

  // /// 读取秘密数据
  // static const _tagReadSecret = 0x09;

  static var _id = 1;
  static int _getId() {
    return _id++;
  }

  static Future<String> _request(
    int id,
    Uint8List bytes, [
    _ResultEnum type = _ResultEnum.string,
  ]) async {
    return _methodChannel.invokeMethod<String>('request', {
      'id': id,
      'bytes': bytes,
      'type': type == _ResultEnum.integer
          ? 'int'
          : type == _ResultEnum.string
              ? 'string'
              : type == _ResultEnum.hex
                  ? 'hex'
                  : '',
    });
  }

  // test method start
  /// 模拟设备连接
  static Future<void> testDeviceAttached() async {
    await _methodChannel.invokeMethod<void>('testDeviceAttached');
  }

  ///模拟设备移除
  static Future<void> testDeviceDetached() async {
    await _methodChannel.invokeMethod<void>('testDeviceDetached');
  }

  ///清除测试数据，缓存ping code 等
  static Future<void> clearTestData() async {
    await _methodChannel.invokeMethod<void>('clearTestData');
  }
  // test method end

  ///* add hdkey connect state change
  ///* event msg 1.DeviceAttached 2.DeviceDetached
  static void addEventListener(Function(dynamic event) listener) {
    _eventChannel.receiveBroadcastStream().listen(listener);
  }

  ///* active check hdkey is connect
  ///* result bool
  static Future<bool> hasHDKey() async {
    final result = await _methodChannel.invokeMethod<bool>('hasHDKey');
    return result;
  }

  ///* connect HDKey
  ///* result bool
  static Future<bool> connectHDKey() async {
    final result = await _methodChannel.invokeMethod<bool>('connectHDKey');
    return result;
  }

  ///* get hdkey info
  ///* result {use_pin: false(need init hdkey) true(need validate pin code)}
  static Future<Map<String, dynamic>> getInfo() async {
    final result = Map<String, dynamic>.from(
      await _methodChannel.invokeMethod('getInfo'),
    );
    return result;
    // final id = _getId();
    // final bytes = RequestBytesBuilder().
    // setId(id).setTag(_tagGetAbout).build();
    // final result = await _request(id, bytes);
    // final data = json.decode(result);
    // return data as Map<String, dynamic>;
  }

  ///* get hdkey status
  static Future<Map<String, dynamic>> getDeviceStatus() async {
    await Future.delayed(Duration(seconds: 1));
    return {
      'pincode': '0', // 0-已启用pincode；1-未启用pincode；2-设备异常
      'solt0': '1', // 0-已使用；1-未使用；2-设备异常
      'solt1': '1',
      'solt2': '1',
      'solt3': '1',
      'solt4': '1',
      'solt5': '1',
      'solt6': '1',
      'secret0': '1', //0-已使用；1-未使用；2-设备异常
      'secret1': '1',
      'secret2': '1',
      'secret3': '1',
      'secret4': '1',
      'secret5': '1',
      'secret6': '1',
    };

    // final id = _getId();
    // final bytes =
    //     RequestBytesBuilder().setId(id).setTag(_tagDeviceStatus).build();
    // final result = await _request(id, bytes);
    // final data = json.decode(result);
    // return data as Map<String, dynamic>;
  }

  ///硬件模块接入验证（登录）  参数1：pin code
  static Future<bool> accessByPinCode(
    String pinCode,
  ) async {
    final id = _getId();
    final bytes = RequestBytesBuilder()
        .setId(id)
        .setTag(_tagAccessByPinCode)
        .addIntParams(6)
        .addStrParams(pinCode)
        .build();

    debugPrint('isme bytes:$bytes');

    final result = await _request(id, bytes, _ResultEnum.integer);
    return result == '1';

    // final result = await _methodChannel.invokeMethod<bool>(
    //   'access_by_pincode',
    //   {
    //     "pinCode": pinCode,
    //   },
    // );
    // return result;
  }

  ///* validate pin code
  ///* result bool
  static Future<bool> validatePin(String pinCode) async {
    final result = await _methodChannel.invokeMethod<bool>(
      'validatePin',
      {'pin': pinCode},
    );
    return result;
  }

  ///* on init set pin code
  ///* result bool  PIN_CODE_USED
  ///* error -1 PIN_CODE_USED
  static Future<bool> setPin(String pinCode) async {
    final result = await _methodChannel.invokeMethod<bool>(
      'setPin',
      {'pin': pinCode},
    );
    return result;

    //   final id = _getId();
    // final bytes = RequestBytesBuilder()
    //     .setId(id)
    //     .setTag(_tagGetAbout)
    //     .addIntParams(6)
    //     .addStrParams('123456')
    //     .addIntParams(6)
    //     .addStrParams(pinCode)
    //     .build();

    // debugPrint('isme bytes:$bytes');

    // final result = await _request(id, bytes, _ResultEnum.integer);
    // return result == '1';
  }

  ///* change pin code
  ///* result bool
  ///* error -1 OLD_PIN_FAIL ,-2 NEW_PIN_LENGTH_FAIL
  static Future<bool> changePin({
    @required String oldPin,
    @required String newPin,
  }) async {
    // final result = await _methodChannel.invokeMethod<bool>(
    //   'changePin',
    //   {
    //     "oldPin": oldPin,
    //     "newPin": newPin,
    //   },
    // );
    // return result;

    final id = _getId();
    final bytes = RequestBytesBuilder()
        .setId(id)
        .setTag(_tagGetAbout)
        .addIntParams(6)
        .addStrParams(oldPin)
        .addIntParams(6)
        .addStrParams(newPin)
        .build();

    debugPrint('isme bytes:$bytes');

    final result = await _request(id, bytes, _ResultEnum.integer);
    return result == '1';
  }

  ///* get mnemonic list,, Don't use it yet
  ///* result bool
  static Future<List<String>> getMnemonicList(
    String pinCode,
  ) async {
    final result = await _methodChannel.invokeMethod<List<String>>(
      'getMnemonicList',
      {'pin': pinCode},
    );
    return result;
  }

// wallet method

  ///写入私钥 参数1：写入的solt，值为0~6 参数2：32字节私钥 参数3：32字节公钥
  static Future<bool> writeKeyPair({
    @required int solt,
    @required String privateKey,
    @required String publicKey,
  }) async {
    // final result = await _methodChannel.invokeMethod<bool>(
    //   'write_keypair',
    //   {
    //     "solt": solt,
    //     "privateKey": privateKey,
    //     "publicKey": publicKey,
    //   },
    // );
    // return result;
    final id = _getId();
    final bytes = RequestBytesBuilder()
        .setId(id)
        .setTag(_tagWriteKeyPair)
        .addIntParams(solt)
        .addStrParams(privateKey)
        .addStrParams(publicKey)
        .build();
    debugPrint('isme bytes:$bytes');
    final result = await _request(id, bytes, _ResultEnum.integer);
    return result == '1';
  }

  ///擦除私钥 参数1：写入的solt，值为0~6   参数2：pin code
  static Future<bool> eraseKeyPair({
    @required int solt,
    @required String pinCode,
  }) async {
    // final result = await _methodChannel.invokeMethod<bool>(
    //   'erase_keypair',
    //   {
    //     "solt": solt,
    //     "pinCode": pinCode,
    //   },
    // );
    // return result;
    final id = _getId();
    final bytes = RequestBytesBuilder()
        .setId(id)
        .setTag(_tagEraseKeyPair)
        .addIntParams(solt)
        .addIntParams(6)
        .addStrParams(pinCode)
        .build();
    debugPrint('isme bytes:$bytes');
    final result = await _request(id, bytes, _ResultEnum.integer);
    return result == '1';
  }

  /// 写入秘密数据 参数1：写入的section，值为0~6 参数2: pin code
  static Future<bool> writeSecret({
    @required int secret,
    @required String data,
  }) async {
    final result = await _methodChannel.invokeMethod<bool>(
      'write_secret',
      {
        'secret': secret,
        'data': data,
      },
    );
    return result;
  }

  /// 擦除秘密数据
  static Future<bool> eraseSecret({
    @required int secret,
    @required String pinCode,
  }) async {
    final result = await _methodChannel.invokeMethod<bool>(
      'erase_secret',
      {
        'secret': secret,
        'pinCode': pinCode,
      },
    );
    return result;
  }

  /// 写入秘密数据 参数1：需要读取的section，值为0~6
  static Future<String> readSecret(
    int secret,
  ) async {
    final result = await _methodChannel.invokeMethod<String>(
      'read_secret',
      {
        'secret': secret,
      },
    );
    return result;
  }

  ///重置设备（需要验证pincode）  参数1：pin code
  static Future<bool> resetDevice(
    String pinCode,
  ) async {
    final result = await _methodChannel.invokeMethod<bool>(
      'reset_device',
      {
        'pinCode': pinCode,
      },
    );
    return result;
  }
}
