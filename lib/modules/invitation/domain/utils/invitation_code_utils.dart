part of invitation_domain_module;

class InvitationCodeUtils {
  static String encodeQRCodeData({
    @required String chain,
    @required String symbol,
    @required String address,
    @required String subSign,
    @required String sharePrvKey,
  }) {
    return '${chain}_${symbol}_${address}_${subSign}_$sharePrvKey';
  }

  static Future<List<String>> decodeQRCodeData({
    @required String chain,
    @required String symbol,
    @required String data,
  }) {
    final list = data.split('_');
    if (list != null && list.length == 5) {
      for (final item in list) {
        if (item.isEmpty) {
          return Future.error(InvitationCodeDecodeError());
        }
      }
      if (list[0] == chain && list[1] == symbol) {
        return Future.value(list.sublist(2, list.length));
      } else {
        return Future.error(InvitationCodeDecodeSymbolError(symbol));
      }
    }
    return Future.error(InvitationCodeDecodeError());
  }
}
