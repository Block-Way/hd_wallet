import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

enum BbcDataType {
  /// String data
  strData,

  /// Hex String data
  hexData,

  ///
  withData,
}

class BbcAddressInfo {
  BbcAddressInfo({
    required this.address,
    required this.publicKey,
    required this.privateKey,
  });
  final String address;
  final String publicKey;
  final String privateKey;
}

class BbcTemplateData {
  BbcTemplateData({
    required this.address,
    required this.template,
  });
  final String address;
  final String template;
}

class WalletBBC {
  static const _channel = MethodChannel('wallet_sdk_flutter');

  ///
  static Future<String?> createBBCTransaction({
    required List<Map<String, dynamic>> utxos,
    required String address,
    required int timestamp,
    required String anchor,
    required double amount,
    required double fee,
    required int version,
    required int lockUntil,
    required int type,
    String data = '',
    String dataUUID = '',
    String templateData = '',
    BbcDataType? dataType,
  }) async {
    final result = await _channel.invokeMethod<String>(
      'createBBCTransaction',
      {
        'utxos': utxos,
        'address': address,
        'timestamp': timestamp,
        'anchor': anchor,
        'amount': amount,
        'fee': fee,
        'version': version,
        'type': type,
        'lockUntil': lockUntil,
        'data': data,
        'dataWithUUID': dataUUID,
        'templateData': templateData,
        'dataType': dataType?.index ?? BbcDataType.strData.index,
        'dataWithFmt': '',
      },
    );
    return result;
  }

  static Future<bool?> validateBBCAddress(Map<String, dynamic> params) async {
    final result = await _channel.invokeMethod<bool>(
      'validateBBCAddress',
      params,
    );
    return result;
  }

  static Future<BbcTemplateData> createBBCDexOrderTemplateData({
    required String tradePair,
    required int price,
    required int fee,
    required int timestamp,
    required int validHeight,
    required String sellerAddress,
    required String recvAddress,
    required String matchAddress,
    required String dealAddress,
  }) async {
    final result = Map<String, dynamic>.from(
      await _channel.invokeMethod(
        'createBBCDexOrderTemplateData',
        {
          'fee': fee,
          'price': price,
          'tradePair': tradePair,
          'timestamp': timestamp,
          'validHeight': validHeight,
          'sellerAddress': sellerAddress,
          'recvAddress': recvAddress,
          'matchAddress': matchAddress,
          'dealAddress': dealAddress,
        },
      ),
    );
    return BbcTemplateData(
      address: result['address'].toString(),
      template: result['rawHex'].toString(),
    );
  }

  static Future<BbcAddressInfo> createBbcKeyPair({
    required String bip44Path,
    required String bip44Key,
  }) async {
    final keyInfo = Map<String, dynamic>.from(
      await _channel.invokeMethod(
        'createBBCKeyPair',
        {
          'bip44Path': bip44Path,
          'bip44Key': bip44Key,
        },
      ),
    );
    return BbcAddressInfo(
      address: keyInfo['address'].toString(),
      publicKey: keyInfo['publicKey'].toString(),
      privateKey: keyInfo['privateKey'].toString(),
    );
  }

  static Future<BbcAddressInfo> createBbcFromPrivateKey({
    required String privateKey,
  }) async {
    final keyInfo = Map<String, dynamic>.from(
      await _channel.invokeMethod(
        'createBBCFromPrivateKey',
        {
          'privateKey': privateKey,
        },
      ),
    );
    return BbcAddressInfo(
      address: keyInfo['address'].toString(),
      publicKey: keyInfo['publicKey'].toString(),
      privateKey: keyInfo['privateKey'].toString(),
    );
  }

  static Future<String?> addressBBCToPublicKey({
    required String address,
  }) async {
    final publicKey = await _channel.invokeMethod<String>(
      'addressBBCToPublicKey',
      {
        'address': address,
      },
    );
    return publicKey;
  }
}
