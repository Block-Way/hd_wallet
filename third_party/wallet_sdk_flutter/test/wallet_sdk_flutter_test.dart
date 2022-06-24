import 'package:flutter_test/flutter_test.dart';
import 'package:wallet_sdk_flutter/wallet_sdk_flutter.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('#generateMnemonic', () async {
    final mnemonic = await WalletCore.generateMnemonic();
    expect(mnemonic, isNotNull);
    expect(mnemonic.length, isNot(0));
  });

  group('#importMnemonic', () {
    const password = 'test';
    final symbols = ['BTC', 'ETH', 'BBC', 'USDT'];

    test('with default path', () async {
      final String mnemonic = await WalletCore.generateMnemonic();
      const path = "m/44'/0'/0'/0/0";
      final keyInfo = await WalletCore.importMnemonic(
        mnemonic: mnemonic,
        path: path,
        password: password,
        symbols: symbols,
        options: WalletCoreOptions(),
      );

      expect(keyInfo.keys.toList(), symbols);

      for (final symbol in keyInfo.keys) {
        final WalletAddressInfo keys = keyInfo[symbol];

        expect(keys.publicKey, isNotNull);
        expect(keys.address, isNotNull);
      }
    });

    test('with sugar legacy path', () async {
      final mnemonic = await WalletCore.generateMnemonic();
      const path = "m/44'/%d'";
      final keyInfo = await WalletCore.importMnemonic(
        mnemonic: mnemonic,
        path: path,
        password: password,
        symbols: symbols,
      );

      expect(keyInfo.keys.toList(), symbols);

      for (final symbol in keyInfo.keys) {
        final WalletAddressInfo keys = keyInfo[symbol];

        expect(keys.publicKey, isNotNull);
        expect(keys.address, isNotNull);
      }
    });

    test('with custom path', () async {
      final mnemonic = await WalletCore.generateMnemonic();
      const path = "m/44'/0'/1'/0/0";
      final keyInfo = await WalletCore.importMnemonic(
        mnemonic: mnemonic,
        path: path,
        password: password,
        symbols: symbols,
      );

      expect(keyInfo.keys.toList(), symbols);

      for (final symbol in keyInfo.keys) {
        final WalletAddressInfo keys = keyInfo[symbol];

        expect(keys.publicKey, isNotNull);
        expect(keys.address, isNotNull);
      }
    });
  });

  group('#signTx', () {
    const password = 'test';
    const path = "m/44'/0'/0'/0/0";

    test('sign BTC tx', () async {
      const chain = 'BTC';
      final mnemonic = await WalletCore.generateMnemonic();
      const rawTx = 'test_tx';
      final String signTx = await WalletCore.signTx(
        mnemonic: mnemonic,
        path: path,
        password: password,
        chain: chain,
        rawTx: rawTx,
      );
      expect(signTx, isNotNull);
    });

    test('sign ETH tx', () async {
      const chain = 'ETH';
      final String mnemonic = await WalletCore.generateMnemonic();
      const rawTx = 'test_tx';
      final String signTx = await WalletCore.signTx(
        mnemonic: mnemonic,
        path: path,
        password: password,
        chain: chain,
        rawTx: rawTx,
      );
      expect(signTx, isNotNull);
    });

    test('sign BBC tx', () async {
      const chain = 'BBC';
      final mnemonic = await WalletCore.generateMnemonic();
      const rawTx = 'test_tx';
      final signTx = await WalletCore.signTx(
        mnemonic: mnemonic,
        path: path,
        password: password,
        chain: chain,
        rawTx: rawTx,
      );
      expect(signTx, isNotNull);
    });

    test('sign USDT tx', () async {
      const chain = 'ETH';
      final String mnemonic = await WalletCore.generateMnemonic();
      const String rawTx = 'test_tx';
      final signTx = await WalletCore.signTx(
        mnemonic: mnemonic,
        path: path,
        password: password,
        chain: chain,
        rawTx: rawTx,
      );
      expect(signTx, isNotNull);
    });
  });
}
