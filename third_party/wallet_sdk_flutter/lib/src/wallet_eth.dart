import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class WalletETH {
  static const _channel = MethodChannel('wallet_sdk_flutter');

  static Future<String?> createETHTransaction({
    required int nonce,
    required int gasLimit,
    required String address,
    required int amount,
    required int gasPrice,
    String contract = '',
  }) async {
    final result = await _channel.invokeMethod<String>(
      'createETHTransaction',
      {
        'nonce': nonce,
        'amount': amount,
        'address': address,
        'gasLimit': gasLimit,
        'gasPrice': gasPrice,
        'contract': contract
      },
    );
    return result;
  }

  static Future<bool?> validateETHAddress(Map<String, dynamic> params) async {
    final result = await _channel.invokeMethod<bool>(
      'validateETHAddress',
      params,
    );
    return result;
  }
}
