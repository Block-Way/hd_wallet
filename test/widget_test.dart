// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// Flutter imports:
//import 'package:flutter/material.dart';

// Package imports:
//import 'package:flutter_test/flutter_test.dart';

// Project imports:
//import 'package:sugar/app.dart';

import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:sugar/crypto/hah.dart';
import 'package:ed25519_dart_base/ed25519_dart.dart';
import 'package:hex/hex.dart';

String formatBytesAsHexString(Uint8List bytes) {
  final result = StringBuffer();
  for (var i = 0; i < bytes.lengthInBytes; i++) {
    final part = bytes[i];
    result.write('${part < 16 ? '0' : ''}${part.toRadixString(16)}');
  }
  return result.toString();
}

void main() {
  testWidgets('Counter increments smoke test', (tester) async {
    const vote = {
      'address': '20w0e9rcg7nq4pet8yz8ch2jt46f7hyjg256ys7dh5gddp0pja5mtm3js',
      'delegate': '20m02d02b17s1bq6z40kf10gkgytxseq5dzpgm3shhhsa2nj6dva81qvy',
      'owner': '1632srrskscs1d809y3x5ttf50f0gabf86xjz2s6aetc9h9ewwhm58dj3',
      'rewardmode': 0,
      'hex': '070002d46e4656a1728c310f0aed6fe5badcb5871382f02620dfdc15f2094b802600050168e4dca5989876ca64f16537e82d05c103e5695dfaf009a01632cb33639cc53000000000',
    };
    var ret = getVote(vote['delegate'] as String, vote['owner'] as String,vote['rewardmode'] as int);
    expect('0700${ret['hex']}', equals(vote['hex']));
    expect(ret['address'], equals(vote['address']));
    const tx = {
      'txid':'85b36243c17dbe53177be4c900d67b3b82c32ef3f649879b7c671728011ed432',
      'version': 1,
      'type': 'token',
      'time': 1648607613,
      'nonce': 2,
      'from': '1632srrskscs1d809y3x5ttf50f0gabf86xjz2s6aetc9h9ewwhm58dj3',
      'to': '20w0e9rcg7nq4pet8yz8ch2jt46f7hyjg256ys7dh5gddp0pja5mtm3js',
      'amount': '200.0000000000',
      'gaslimit': 13700,
      'gasprice': '0.0000010000',
      'gasused': 13700,
      'txfee': "0.0137000000",
      'data':'0101014602d46e4656a1728c310f0aed6fe5badcb5871382f02620dfdc15f2094b802600050168e4dca5989876ca64f16537e82d05c103e5695dfaf009a01632cb33639cc53000000000',
      'sig':'387aa107a4ccd37816f9103cf05d3d37dd980c65db4c8a8e140fdf1b3c65c1b85c97aa06a898d9c3bdf1470618c19644482d768da6439bddf718658914abc705',
      'fork':'0000000027734445141a588af514fba7f24869c830399fe09a1355815b60040d',
      'height': 22,
      'blockhash': '00000016b8b3a1db3bfb02dd4f81e337390962dc89458b82d1f5f2e68007a318',
      'confirmations': 4,
      'serialization':'010000007dc143620000000027734445141a588af514fba7f24869c830399fe09a1355815b60040d02000000000000000168e4dca5989876ca64f16537e82d05c103e5695dfaf009a01632cb33639cc530026951d202db1a2cb19dec4d1150fa789e215a8ac8d0f7483b4b6e3d90e1e40007000000000000000000000000000000000000000000000000000001d1a94a2000000000000000000000000000000000000000000000000000000000000000271000000000000000000000000000000000000000000000000000000000000035840101014602d46e4656a1728c310f0aed6fe5badcb5871382f02620dfdc15f2094b802600050168e4dca5989876ca64f16537e82d05c103e5695dfaf009a01632cb33639cc5300000000040387aa107a4ccd37816f9103cf05d3d37dd980c65db4c8a8e140fdf1b3c65c1b85c97aa06a898d9c3bdf1470618c19644482d768da6439bddf718658914abc705'
    };

    ret = getTx(tx);
    final privateKey = Uint8List.fromList(HEX.decode('ab14e1de9a0e805df0c79d50e1b065304814a247e7d52fc51fd0782e0eec27d6'));
    final rpk = Uint8List.fromList(privateKey.reversed.toList());
    final public = publicKey(rpk);
    final txHash = HEX.decode(ret['tx_hash']);
    final signHex = sign(txHash as Uint8List, rpk, public);
    expect('${ret['tx_hex']}40${HEX.encode(signHex)}', equals(tx['serialization']));

    /*
    final Blake2bDigest digest = Blake2bDigest(digestSize: 32);
    digest.reset();
    final plainText = Uint8List(100);
    for (int i = 0; i < 100; i++) {
      plainText[i] = i;
    }
    final out = digest.process(plainText);
    final hexOut = formatBytesAsHexString(out);
    const expectedHexDigestText =
        '5ac86383dec1db602fdbc2c978c3fe1bf4328fea1e1b495b68be2c3b67ba033b';
    expect(hexOut, equals(expectedHexDigestText));
    //base32转16进制
    final b = base32Decode(
        '965p604xzdrffvg90ax9bk0q3xyqn5zz2vc9zpbe3wdswzazj7d144mm');
    final a = HEX.encode(b);
    const c =
        '498b63009dfb70f7ee0902ba95cc171f7d7a97ff16d89fd96e1f1b9e7d5f91da';
    expect(a, equals(c));

    pubkey="e76226a3933711f195aa6c1879e2381976b33337bf7b3b296edd8dff105b24b5"
	   owner="1965p604xzdrffvg90ax9bk0q3xyqn5zz2vc9zpbe3wdswzazj7d144mm"
    */
  });
}
