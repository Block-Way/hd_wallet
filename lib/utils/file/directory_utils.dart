part of utils;

class DirectoryUtils {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<String> createDirectory(String dirName) async {
    final path = await _localPath;
    final directory = await Directory('$path/$dirName').create(recursive: true);
    return directory.path;
  }
}
