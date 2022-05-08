part of common_ui_module;

class QrCodeView extends StatelessWidget {
  const QrCodeView(this.text,
      {Key key,
      this.size,
      this.embeddedImage,
      this.embeddedSize,
      this.errorCorrectionLevel = QrErrorCorrectLevel.L,
      this.backgroundColor = const Color(0x00FFFFFF),
      this.foregroundColor = const Color(0xFF000000),
      this.padding = const EdgeInsets.all(10),
      this.gapless = true})
      : super(key: key);

  final String text;
  final double size;
  final bool gapless; // default true
  final Color backgroundColor; // default 0x00FFFFFF
  final Color foregroundColor; // default 0xFF000000
  final EdgeInsets padding;

  /// 二维码纠错登记 如果中间有logo 建议提高 不然容易识别错误
  final int errorCorrectionLevel; //  QrErrorCorrectLevel.L,

  // center image
  final AssetImage embeddedImage; //AssetImage('assets/images/user_avatar.png'),
  final double embeddedSize;

  @override
  Widget build(BuildContext context) {
    return QrImage(
      data: text,
      size: size,
      padding: padding,
      gapless: gapless,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      embeddedImage: embeddedImage,
      errorCorrectionLevel: errorCorrectionLevel,
      // embeddedImageStyle: QrEmbeddedImageStyle(
      //   size: Size(embeddedSize, embeddedSize),
      // ),
    );
  }
}
