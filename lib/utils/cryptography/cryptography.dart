part of utils;

class CryptographyUtils {
  static const uniqueChars = 'abcdefghijklmnopqrstuvwxyz1234567890';

  static Future<String> _crypto(
    String value,
    String password, [
    bool isEncrypt = true,
  ]) async {
    assert(value != null);
    assert(password != null);

    final cipher = chacha20Poly1305Aead;
    final listIntPwd = utf8.encode('$password$uniqueChars'.substring(0, 32));
    final secretKey = SecretKey(listIntPwd);
    final nonce = Nonce(utf8.encode(uniqueChars.substring(0, 12)));
    final message =
        isEncrypt ? utf8.encode(value) : Uint8List.fromList(value.codeUnits);
    final action = isEncrypt ? cipher.encrypt : cipher.decrypt;
    final encrypted = await action(
      message,
      secretKey: secretKey,
      nonce: nonce,
    );
    return String.fromCharCodes(encrypted) ?? '';
  }

  static Future<String> encrypt(String value, String pwd) async {
    return _crypto(value, pwd);
  }

  static Future<String> decrypt(String value, String pwd) async {
    return _crypto(value, pwd, false);
  }
}
