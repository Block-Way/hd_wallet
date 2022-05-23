import 'dart:convert';
import 'dart:typed_data';
import 'package:convert/convert.dart';

class ByteUtils {
  /// int to bytes count max 4
  static List<int> intToBytes(int value, [int count = 1]) {
    final list = Uint8List(4);
    final data = ByteData.view(list.buffer);
    data.setInt32(0, value, Endian.little);
    return list.toList().sublist(0, count);
  }

  static List<int> strToBytes(String value) {
    return utf8.encode(value);
  }

  static String strToHex(String value) {
    return hex.encode(utf8.encode(value));
  }

  static String bytesToHex(List<int> value) {
    return hex.encode(value);
  }

  static String uint8ListToHex(Uint8List value) {
    return hex.encode(value);
  }

  static Uint8List hexToUnitList(String value) {
    return Uint8List.fromList(hexToBytes(value));
  }

  static String hexToString(String value) {
    return utf8.decode(hexToBytes(value));
  }

  static List<int> hexToBytes(String value) {
    return hex.decode(value);
  }
}
