part of utils;

/// Toast
class Toast {
  // ignore: prefer_function_declarations_over_variables
  static String Function(dynamic) onParseError = (error) => error?.toString();

  static void show(String msg, {int duration = 3500}) {
    if (msg == null) {
      return;
    }
    showToast(
      msg,
      duration: Duration(milliseconds: kDebugMode ? 5000 : duration),
      dismissOtherToast: true,
    );
  }

  static void showError(
    dynamic error, {
    String defaultMessage,
    bool appendErrorToDefaultMessage = false,
  }) {
    // Add the errors to check for message
    if (error is DioError) {
      show(onParseError(error.error));
    } else if (error is PlatformException) {
      show('[${error.code}]: ${error.message}');
    } else if (error is FlutterError) {
      show(error.message);
    } else if (error is HiveError) {
      show(error.message);
    } else {
      final message = onParseError(error);
      if (appendErrorToDefaultMessage) {
        show('[$defaultMessage]: $message');
      } else {
        show(defaultMessage ?? message);
      }
    }
  }

  static void hide() {
    dismissAllToast();
  }
}
