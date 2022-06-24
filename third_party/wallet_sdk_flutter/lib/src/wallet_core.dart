import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'wallet_bbc.dart';
import 'wallet_btc.dart';
import 'wallet_eth.dart';

class WalletSdkChains {
  static final all = [btc, eth, bbc, trx, usdtOmni];
  static const btc = 'BTC';
  static const eth = 'ETH';
  static const bbc = 'BBC';
  static const trx = 'TRX';
  static const usdtOmni = 'USDT(Omni)';
}

class WalletAddressInfo {
  WalletAddressInfo({
    required this.address,
    required this.publicKey,
    required this.privateKey,
  });

  final String address;
  final String publicKey;
  final String privateKey;
}

class WalletCoreOptions {
  const WalletCoreOptions({
    this.beta = false,
    this.useBip44 = true,
    this.shareAccountWithParentChain = false,
  });
  final bool beta;
  final bool useBip44;
  final bool shareAccountWithParentChain;
}

class WalletCore {
  static const _channel = MethodChannel('wallet_sdk_flutter');

  static Future<bool?> validateAddress({
    required String chain,
    required String address,
    required bool isBeta,
  }) async {
    final params = {'address': address, 'beta': isBeta};
    switch (chain) {
      case 'BBC':
        return WalletBBC.validateBBCAddress(params);
      case 'ETH':
        return WalletETH.validateETHAddress(params);
      case 'BTC':
        return WalletBTC.validateBTCAddress(params);
      default:
        return Future.value(true);
    }
  }

  static Future<String?> generateMnemonic() async {
    final mnemonic = await _channel.invokeMethod<String>('generateMnemonic');
    return mnemonic;
  }

  //true is valid
  static Future<bool?> validateMnemonic(String mnemonic) async {
    final isValid = await _channel.invokeMethod<bool>(
      'validateMnemonic',
      mnemonic,
    );
    return isValid;
  }

  static Future<Map<String, WalletAddressInfo>> importMnemonic({
    required String mnemonic,
    required String path,
    required String password,
    required List<String> symbols,
    WalletCoreOptions options = const WalletCoreOptions(),
  }) async {
    final keyInfo = Map<String, dynamic>.from(
      await _channel.invokeMethod(
        'importMnemonic',
        {
          'mnemonic': mnemonic,
          'path': path,
          'password': password,
          'symbols': symbols.join(','),
          'beta': options.beta,
          'useBip44': options.useBip44,
          'shareAccountWithParentChain': options.shareAccountWithParentChain,
        },
      ),
    );
    return keyInfo.map(
      (key, value) => MapEntry(
        key,
        WalletAddressInfo(
          address: value['address'].toString(),
          publicKey: value['publicKey'].toString(),
          privateKey: value['privateKey'].toString(),
        ),
      ),
    );
  }

  static Future<String?> exportPrivateKey({
    required String mnemonic,
    required String path,
    required String password,
    required String symbol,
    WalletCoreOptions options = const WalletCoreOptions(),
  }) async {
    final privateKey = await _channel.invokeMethod<String>(
      'exportPrivateKey',
      {
        'mnemonic': mnemonic,
        'path': path,
        'password': password,
        'symbol': symbol,
        'beta': options.beta,
        'useBip44': options.useBip44,
        'shareAccountWithParentChain': options.shareAccountWithParentChain,
      },
    );
    return privateKey;
  }

  static Future<String?> signTx({
    required String mnemonic,
    required String path,
    required String password,
    required String chain,
    required String rawTx,
    WalletCoreOptions options = const WalletCoreOptions(),
  }) async {
    final params = {
      'mnemonic': mnemonic,
      'path': path,
      'password': password,
      'symbol': chain,
      'rawTx': rawTx,
      'beta': options.beta,
      'useBip44': options.useBip44,
      'shareAccountWithParentChain': options.shareAccountWithParentChain,
    };

    final signedTx = await _channel.invokeMethod<String>(
      'signTx',
      params,
    );
    return signedTx;
  }

  static Future<String?> signMsg({
    required String mnemonic,
    required String path,
    required String password,
    required String chain,
    required String msg,
    WalletCoreOptions options = const WalletCoreOptions(),
  }) async {
    final params = {
      'mnemonic': mnemonic,
      'path': path,
      'password': password,
      'symbol': chain,
      'msg': msg,
      'beta': options.beta,
      'useBip44': options.useBip44,
      'shareAccountWithParentChain': options.shareAccountWithParentChain,
    };

    final result = await _channel.invokeMethod<String>(
      'signMsg',
      params,
    );
    return result;
  }

  static Future<String?> signMsgWithPKAndBlake({
    required String privateKey,
    required String msg,
  }) async {
    final params = {
      'privateKey': privateKey,
      'msg': msg,
    };

    final result = await _channel.invokeMethod<String>(
      'signMsgWithPKAndBlake',
      params,
    );
    return result;
  }
}
