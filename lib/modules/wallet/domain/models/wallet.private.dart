part of wallet_domain_module;

class WalletPrivateData {
  WalletPrivateData({
    this.walletId,
    this.walletType,
    this.mnemonic,
    this.privateKey,
  });

  String? walletId;
  WalletType? walletType;
  String? mnemonic;
  String? privateKey;

  bool get useBip44 => walletType == WalletType.mnemonicBip44;
  bool get hasMnemonic => mnemonic?.isNotEmpty ?? false;
  bool get hasPrivateKey => privateKey?.isNotEmpty ?? false;
}

Future<String> generateWalletId(String mnemonicOrPrivateKey) async {
  // final str = md5.convert(utf8.encode(mnemonicOrPrivateKey)).toString();
  // return str.substring(0, 20);
  final words = mnemonicOrPrivateKey.split(' ').reversed.join('-');
  final signature = await Sha256().hash(utf8.encode(words));
  final signatureString = hex.encode(signature.bytes);
  return signatureString.substring(0, 50);
}

Future<WalletPrivateData> getWalletDevicePrivateData({
  required String walletId,
}) async {
  return WalletPrivateData(
    walletId: walletId,
    walletType: WalletType.device,
    mnemonic: '', // On Device
    privateKey: '', // On Device
  );
}

Future<WalletPrivateData> getWalletPrivateData({
  required String walletId,
  required WalletType walletType,
  required String password,
}) async {
  final encryptMnemonic = await WalletRepository().getWalletMnemonic(
    walletId,
  );
  final encryptPrivateKey = await WalletRepository().getWalletMnemonic(
    walletId,
  );
  final mnemonic = await CryptographyUtils.decrypt(
    encryptMnemonic ?? '',
    password,
  );
  final privateKey = await CryptographyUtils.decrypt(
    encryptPrivateKey ?? '',
    password,
  );
  if (mnemonic.isEmpty && privateKey.isEmpty) {
    throw WalletPasswordError();
  }
  return WalletPrivateData(
    walletId: walletId,
    walletType: walletType,
    mnemonic: mnemonic,
    privateKey: privateKey,
  );
}

Future<void> saveWalletPrivateData({
  required String walletId,
  required String password,
  required String mnemonic,
  required String privateKey,
}) async {
  final encryptMnemonic = await CryptographyUtils.encrypt(
    mnemonic,
    password,
  );
  final encryptPrivateKey = await CryptographyUtils.encrypt(
    privateKey,
    password,
  );
  await WalletRepository().setWalletMnemonic(
    walletId,
    encryptMnemonic,
  );
  await WalletRepository().setWalletPrivateKey(
    walletId,
    encryptPrivateKey,
  );
}
