part of utils;

const kUploadTimeout = kDebugMode ? 3000 : 300000;

enum UploadErrorCode {
  extensionNotSupported,
  uploadRequestFailed,
  uploadFileFailed,
}

class UploadError extends Error {
  UploadError(
    this.code,
    this.message,
  );
  final UploadErrorCode code;
  final String message;

  @override
  String toString() {
    return '${code.toString()}: $message';
  }
}

class UploadResult extends Error {
  UploadResult(this.path);
  final String path;

  @override
  String toString() {
    return path;
  }
}

class UploadUtils {
  static const supportedExtension = ['jpg', 'jpeg', 'png', 'aac', 'protobuf'];

  static Future<UploadResult> requestUpload(
    String type,
    File file, {
    String signature,
    String filename,
    StreamController<num> uploadProgress,
  }) async {
    // If a given filename is provided, use it, otherwise make a new one
    final fileName = filename ?? randomNumeric(20);
    Timer timer;
    var progress = 0;

    uploadProgress.add(1);

    // Fix extension
    final fileExt = path.extension(file.path).substring(1);

    final fileMime = mimeFromExtension(fileExt);

    final fileType = fileMime.split('/').last;

    // Check if server can handle this file
    if (!supportedExtension.contains(fileExt)) {
      throw UploadError(UploadErrorCode.extensionNotSupported, fileExt);
    }

    var uploadRequest = {};
    try {
      uploadRequest = await addAuthSignature(
        signature,
        {},
        (params, auth) => Request().getObject(
          '/v1/upload/proxy_url/$type/$fileName/$fileType',
          params: params,
          authorization: auth,
        ),
      );
    } catch (error) {
      throw UploadError(UploadErrorCode.uploadRequestFailed, error.toString());
    }

    try {
      final isAliYun = uploadRequest['channel'] == 'ALIYUN';
      final uploadUrl = uploadRequest['data']['upload_url'].toString();
      final uploadPath = uploadRequest['data']['path'].toString();

      final putUrl = isAliYun ? '$uploadUrl/$uploadPath' : uploadUrl;

      assert(uploadPath != null);

      final uploadParams = uploadRequest['data']
          .entries
          .where((e) => !['upload_url', if (isAliYun) 'path'].contains(e.key))
          .map((e) => '${e.key}=${e.value}')
          .join('&');

      final contentLength = await file.length();

      void startTimer() {
        if (timer != null) {
          return;
        }
        timer = Timer.periodic(Duration(milliseconds: 500), (_) {
          final gradual = 7 - (contentLength ~/ (1024 * 1024) + 1);
          if (progress < 90) {
            progress = math.Random().nextInt(3) +
                (gradual < 0 ? 1 : gradual) +
                progress;
            uploadProgress.add(progress);
          } else if (progress < 100 && progress != 99) {
            uploadProgress.add(99);
          }
        });
      }

      await Dio().put(
        '$putUrl?$uploadParams',
        data: file.openRead(),
        onSendProgress: (sent, total) {
          startTimer();
          // uploadProgress.add(sent ~/ total * 100);
        },
        options: Options(
          contentType: fileMime,
          headers: {
            Headers.contentLengthHeader: contentLength,
          },
          sendTimeout: kUploadTimeout,
          receiveTimeout: kUploadTimeout,
        ),
      ).timeout(Duration(milliseconds: kUploadTimeout));

      timer.cancel();
      uploadProgress.add(100);
      await Future.delayed(Duration(milliseconds: 200));
      return UploadResult(uploadPath);
    } catch (error) {
      timer.cancel();
      throw UploadError(UploadErrorCode.uploadFileFailed, error.toString());
    }
  }
}
