part of utils;

Future<T> addAuthSignature<T>(
  String walletId,
  Map<String, dynamic> params,
  Future<T> Function(Map<String, dynamic>, String) request,
) async {
  final auth = await getAuthSignature(walletId, params);
  return request(params, auth);
}

/// 签名计算方式
Future<String> getAuthSignature(
  String walletId,
  Map<String, dynamic> data,
) async {
  final timestamp = SystemDate.getTime();
  final paths = [2, 4, 8, 7, 3, 1, 6, 2, 0];
  final walletSign = paths.map((e) => walletId[e]).join();

  data.putIfAbsent('hash', () => walletId);

  // Sort data keys alphabetically
  final paramsKey = data?.keys?.toList() ?? [];
  paramsKey.sort((a, b) => a.compareTo(b));
  final paramsData = {};
  for (final key in paramsKey) {
    paramsData[key] = data[key];
  }

  final paramsJson = jsonEncode(paramsData);

  final signature = await sha256.hash(
    utf8.encode('$paramsJson::$timestamp::$walletSign'),
  );

  final signatureString = hex.encode(signature.bytes);

  final auth = base64Encode(
    utf8.encode('$walletId::$timestamp::$signatureString'),
  );
  return auth;
}
