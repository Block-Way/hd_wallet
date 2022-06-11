part of app_module;

// Global cache
class AppHiveCache {
  static const encryptionKeyLocation = 'Sugar@PublicKey';
  static Directory? storageLocation;

  static Future<void> initHive() async {
    storageLocation = await getApplicationDocumentsDirectory();

    // Init configuration
    Hive.init(storageLocation?.path);

    // Init Project Modules
    await moduleCommonInitHive();
    await moduleAssetInitHive();
    await moduleWalletInitHive();
    await moduleInvitationInitHive();
    await moduleTradeInitHive();
    await moduleInvestInitHive();
    await moduleAdmissionInitHive();
  }

  static Future<List<int>> unlockEncryptionKey() async {
    // Check if storage has been created before
    final storageEngine = FlutterSecureStorage();

    var encryptionKey = await storageEngine.read(
      key: encryptionKeyLocation,
    );
    // Create a encryptionKey if a serialized one is not found
    if (encryptionKey == null) {
      encryptionKey = hex.encode(Hive.generateSecureKey());
      await storageEngine.write(
        key: encryptionKeyLocation,
        value: encryptionKey,
      );
    }

    return hex.decode(encryptionKey);
  }

  static Future<Box<T>> openBox<T>(String boxKey) {
    return Hive.openBox<T>(boxKey);
  }

  static Future<LazyBox<T>> openLazyBox<T>(String boxKey) {
    return Hive.openLazyBox<T>(boxKey);
  }

  static Future<LazyBox<T>> openEncryptedBox<T>(String boxKey) async {
    try {
      final encryptionKey = await unlockEncryptionKey();
      return Hive.openLazyBox<T>(
        boxKey,
        encryptionCipher: HiveAesCipher(encryptionKey),
      );
    } catch (error) {
      dev.log('[OpenHiveState] open failure', error: error);
      rethrow;
    }
  }
}
