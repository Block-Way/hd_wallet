part of utils;

void copyTextToClipboard(String text) {
  if (text == null) {
    return;
  }
  debugPrint('isme copy text: $text');
  Clipboard.setData(ClipboardData(text: text));

  // Toast.show(tr('global:msg_copy_success'));
}

Future<String> getTextFromClipboard() async {
  try {
    final str = await Clipboard.getData('text/plain');
    return Future.value(str.text);
  } catch (e) {
    return Future.value('');
  }
}
