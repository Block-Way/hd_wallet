import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class WalletBTC {
  static const _channel = MethodChannel('wallet_sdk_flutter');

  static Future<String?> createBTCTransaction({
    required List<Map<String, dynamic>> utxos,
    required String toAddress,
    required double toAmount,
    required String fromAddress,
    required int feeRate,
    required bool beta,
    required bool isGetFee,
  }) async {
    final result = await _channel.invokeMethod<String>(
      'createBTCTransaction',
      {
        'utxos': utxos,
        'toAddress': toAddress,
        'fromAddress': fromAddress,
        'amount': toAmount,
        'feeRate': feeRate,
        'beta': beta,
        'isGetFee': isGetFee,
      },
    );
    return result;
  }

  static Future<bool?> validateBTCAddress(Map<String, dynamic> params) async {
    final result = await _channel.invokeMethod<bool>(
      'validateBTCAddress',
      params,
    );
    return result;
  }
}
