part of utils;

final _picker = ImagePicker();

class ImagePermissionCameraError extends Error {}

class ImagePermissionGalleryError extends Error {}

class ImageResult {
  ImageResult(
    this.file,
    this.base64,
  );
  final File file;
  String base64;
}

class CameraUtils {
  static Uint8List base64ToFile(String image) => base64.decode(image);

  static Future<ImageResult?> openCamera({
    bool getBase64 = false,
    double? maxWidth,
  }) async {
    final permission = await Permission.camera.request();
    if (permission != PermissionStatus.granted) {
      throw ImagePermissionCameraError();
    }

    final pickedFile = await _picker.getImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
      imageQuality: 95,
      maxWidth: maxWidth,
    );

    if (pickedFile == null || pickedFile.path.isEmpty == true) {
      return null;
    }

    final result = ImageResult(File(pickedFile.path), '');

    if (getBase64) {
      final base64Byte = await pickedFile.readAsBytes();
      final base64Encoded = base64Encode(base64Byte);
      result.base64 = 'data:image/png;base64,$base64Encoded';
    }

    return result;
  }

  static Future<ImageResult?> openGallery({
    bool getBase64 = false,
    double? maxWidth,
  }) async {
    final func = Platform.isIOS ? Permission.photos : Permission.storage;
    final permission = await func.request();
    if (permission != PermissionStatus.granted) {
      throw ImagePermissionGalleryError();
    }

    final pickedFile = await _picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 95,
      maxWidth: maxWidth,
    );

    if (pickedFile == null || pickedFile.path.isEmpty == true) {
      return null;
    }

    final result = ImageResult(File(pickedFile.path), '');

    if (getBase64) {
      final base64Byte = await pickedFile.readAsBytes();
      final base64Encoded = base64Encode(base64Byte);
      result.base64 = 'data:image/png;base64,$base64Encoded';
    }
    return result;
  }
}
