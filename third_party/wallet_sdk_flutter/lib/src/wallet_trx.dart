import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class WalletTRX {
  static const _channel = MethodChannel('wallet_sdk_flutter');

  static Future<String?> createTRXTransaction({
    required List<Map<String, dynamic>> utxos,
    required String toAddress,
    required double toAmount,
    required String fromAddress,
    required int feeRate,
    required bool beta,
  }) async {
    final result = await _channel.invokeMethod<String>(
      'createTRXTransaction',
      {
        'utxos': utxos,
        'toAddress': toAddress,
        'fromAddress': fromAddress,
        'amount': toAmount,
        'feeRate': feeRate,
        'beta': beta,
      },
    );
    return result;
  }

  static Future<bool?> validateTRXAddress(Map<String, dynamic> params) async {
    final result = await _channel.invokeMethod<bool>(
      'validateTRXAddress',
      params,
    );
    return result;
  }
}
