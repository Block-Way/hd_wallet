part of utils;

// getApplicationDocumentsDirectory()        路径相当于 '/data/user/0/xx.xx.xx/app_flutter'
// getTemporaryDirectory()                   路径相当于 '/data/user/0/xx.xx.xx/cache'
// getExternalStorageDirectory()             仅Android平台可用，路径相当于'/storage/emulated/0'外置存储根路径
// getApplicationSupportDirectory()          仅Ios平台可用

class FileUtilsPermissionError extends Error {}

class FileUtils {
  static Future<Map<String, dynamic>> readLocalJson(String assetPath) async {
    return json.decode(await rootBundle.loadString(assetPath))
        as Map<String, dynamic>;
  }

  /// Save image to user album
  static Future<dynamic> saveImage(
    Uint8List imageBytes, {
    int quality = 80,
    String name,
  }) async {
    assert(imageBytes != null);

    return Permission.storage.request().then((value) async {
      if (value != PermissionStatus.granted) {
        throw FileUtilsPermissionError(); //没有存储权限
      } else {
        final result = await ImageGallerySaver.saveImage(
          imageBytes,
          quality: quality,
          name: name,
        );

        if (Platform.isIOS && result != null && result['isSuccess'] == false) {
          throw FileUtilsPermissionError(); //假设没有存储权限
        }

        return result;
      }
    });
  }

  /// Save image to private cache path
  static Future<String> saveImageToCache(
    Uint8List imageBytes, {
    String name,
  }) async {
    assert(imageBytes != null);

    final imageName = name ?? '${DateTime.now().millisecondsSinceEpoch}.jpg';
    final dir = await getTemporaryDirectory();
    final path = '${dir.path}/images/$imageName';
    final file = File(path);
    final exist = await file.exists();
    if (!exist) {
      // create file and dir
      await file.create(recursive: true);
      File(path).writeAsBytesSync(imageBytes, flush: true);
    }
    return file.path;
  }

  /// Check first 8-bytes of PNG
  /// This isn't 100% sufficient to determine if our download was successful,
  /// but it's probably good enough for most cases
  static Future<bool> pngHasValidSignature(File file) async {
    if (!await file.exists()) {
      return false;
    }
    final List<int> asBytes = await file.readAsBytes();
    if (asBytes == null || asBytes.length < 8) {
      await file.delete();
      return false;
    }
    if (asBytes[0] == 137 &&
        asBytes[1] == 80 &&
        asBytes[2] == 78 &&
        asBytes[3] == 71 &&
        asBytes[4] == 13 &&
        asBytes[5] == 10 &&
        asBytes[6] == 26 &&
        asBytes[7] == 10) {
      return true;
    }
    // Not a valid PNG, delete it
    await file.delete();
    return false;
  }

  /// Return true if a SVG is valid
  static Future<bool> isValidSVG(File file) async {
    if (!await file.exists()) {
      return false;
    }
    final svgRegex = RegExp(
        r'/^\s*(?:<\?xml[^>]*>\s*)?(?:<!doctype svg[^>]*\s*(?:\[?(?:\s*<![^>]*>\s*)*\]?)*[^>]*>\s*)?<svg[^>]*>[^]*<\/svg>\s*$/i');
    // Read file as string
    final svgContents = await file.readAsString();
    if (svgRegex.hasMatch(svgContents)) {
      return true;
    }
    await file.delete();
    return false;
  }
}
