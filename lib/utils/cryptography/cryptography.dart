part of utils;

class CryptographyUtils {
  static const uniqueChars = 'abcdefghijklmnopqrstuvwxyz1234567890';

  static Future<String> _crypto(
    String value,
    String password, [
    bool isEncrypt = true,
  ]) async {
    //assert(value != null);
    //assert(password != null);
    final cipher = Chacha20.poly1305Aead();
    final listIntPwd = utf8.encode('$password$uniqueChars'.substring(0, 32));
    final secretKey = SecretKey(listIntPwd);
    final nonce = utf8.encode(uniqueChars.substring(0, 12));
    if (isEncrypt) {
      final ret = await cipher.encrypt(
        utf8.encode(value),
        secretKey: secretKey,
        nonce: nonce,
      );
      final ret_ = List.filled(0, 0, growable: true);
      ret_.addAll(ret.mac.bytes);
      ret_.addAll(ret.cipherText);
      return String.fromCharCodes(ret_);
    } else {
      final ret_ = Uint8List.fromList(value.codeUnits);
      final sb = SecretBox(
        ret_.sublist(16),
        nonce: nonce,
        mac: Mac(ret_.sublist(0, 16)),
      );
      final ret = await cipher.decrypt(sb, secretKey: secretKey);
      return String.fromCharCodes(ret);
    }
  }

  static Future<String> encrypt(String value, String pwd) async {
    return _crypto(value, pwd);
  }

  static Future<String> decrypt(String value, String pwd) async {
    return _crypto(value, pwd, false);
  }
}
