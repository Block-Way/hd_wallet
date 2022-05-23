part of utils;

Future<void> doOpenUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  }
}
