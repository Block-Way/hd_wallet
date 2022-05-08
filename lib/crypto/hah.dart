import 'dart:typed_data';
import 'package:pointycastle/digests/blake2b.dart';
import 'package:sugar/crypto/base32.dart';
import 'package:hex/hex.dart';
import 'package:decimal/decimal.dart';

Uint8List getHexByAddr(String addr) {
  return base32Decode(addr);
}

Map<String, String> getVote(String delegate, String owner, int rewardmode) {
  final Blake2bDigest digest = Blake2bDigest(digestSize: 32);
  digest.reset();
  final ret1 = base32Decode(owner);
  final ret2 = base32Decode(delegate);
  final prefix = Uint8List.fromList([7, 0]);
  final ret3 = Uint8List.fromList([0, 0, 0, 0]);
  if (rewardmode > 0) {
    ret3[0] = 1;
  }
  final ret = ret2 + ret1 + ret3;
  final hashRet = digest.process(Uint8List.fromList(ret));
  final hexAddr = prefix + hashRet.sublist(0, 30);
  final voteAddr = '2${base32Encode(Uint8List.fromList(hexAddr))}';
  final hex = HEX.encode(ret2 + ret1 + ret3);
  return {'hex': hex, 'address': voteAddr};
}

Uint8List float2hex(String str) {
  final ret = List<int>(32);
  var value = Decimal.parse(str);
  value = value * Decimal.parse('1000000000000000000');
  final mod = Decimal.parse('256');
  for (var i = 0; i < 32; i++) {
    ret[31 - i] = (value % mod).toInt();
    value = value / mod;
  }
  return Uint8List.fromList(ret);
}

Uint8List int2hex(String str) {
  final ret = List<int>(32);
  var value = Decimal.parse(str);
  final mod = Decimal.parse('256');
  for (var i = 0; i < 32; i++) {
    ret[31 - i] = (value % mod).toInt();
    value = value / mod;
  }
  return Uint8List.fromList(ret);
}

Map<String, String> getTx(Map<String, Object> tx) {
  final nVersion = ByteData(2);
  nVersion.setInt16(0, 1, Endian.little);

  final nType = ByteData(2);
  nType.setInt16(0, 0, Endian.little);

  final nTimeStamp = ByteData(4);
  nTimeStamp.setInt32(0, tx['time'] as int, Endian.little);

  final hashFork = ByteData(32);
  for (var i = 0; i < 32; i++) {
    final hex = (tx['fork'] as String).substring(i * 2, i * 2 + 2);
    final v = int.tryParse('0x$hex');
    hashFork.setInt8(i, v);
  }

  final nTxNonce = ByteData(8);
  nTxNonce.setInt64(0, tx['nonce'] as int, Endian.little);

  final from = getHexByAddr(tx['from'] as String);

  final to = getHexByAddr(tx['to'] as String);

  final nAmount = float2hex(tx['amount'] as String);
  final nGasPrice = float2hex(tx['gasprice'] as String);
  final nGasLimit = int2hex(tx['gaslimit'].toString());
  var dataHex = tx['data'] as String;
  if (dataHex == '') {
    dataHex = '00';
  }
  final len = dataHex.length ~/ 2;
  final data = ByteData(len);
  for (var i = 0; i < len; i++) {
    final hex = dataHex.substring(i * 2, i * 2 + 2);
    final v = int.tryParse('0x$hex');
    data.setInt8(i, v);
  }

  final ret = nVersion.buffer.asInt8List() +
      nType.buffer.asInt8List() +
      nTimeStamp.buffer.asInt8List() +
      hashFork.buffer.asUint8List() +
      nTxNonce.buffer.asUint8List() +
      from +
      to +
      nAmount +
      nGasPrice +
      nGasLimit +
      data.buffer.asUint8List();

  final Blake2bDigest digest = Blake2bDigest(digestSize: 32);
  digest.reset();
  final hashRet = digest.process(Uint8List.fromList(ret));
  return {
    'tx_hash': HEX.encode(hashRet),
    'tx_hex': HEX.encode(Uint8List.fromList(ret))
  };
}
