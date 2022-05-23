part of common_ui_module;

class QRScannerPage extends StatefulWidget {
  static const routeName = '/common/scan';

  static Future<String> open() {
    return AppNavigator.push<String>(routeName);
  }

  static Route<String> route(RouteSettings settings) {
    return DefaultTransition<String>(settings, QRScannerPage());
  }

  @override
  State createState() => _QRScannerPage();
}

class _QRScannerPage extends State<QRScannerPage>
    with TickerProviderStateMixin {
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController qrController;
  StreamSubscription<String> qrSubscription;
  AnimationController animationController;
  Animation<Offset> animation;
  final borderWidth = 6.0;
  bool hasPermission = false;

  @override
  void initState() {
    super.initState();
    Permission.camera.request().then((value) {
      if (value != PermissionStatus.granted) {
        showConfirmDialog(
          context,
          title: tr('global:dialog_permission_title'),
          content: tr('global:dialog_permission_camera'),
          cancelBtnText: tr('global:btn_deny'),
          confirmBtnText: tr('global:btn_open_settings'),
          onConfirm: () {
            openAppSettings();
            AppNavigator.goBack();
          },
          onCancel: () {
            Toast.show(tr('global:msg_permission_denied_camera'));
            AppNavigator.goBack();
          },
        );
        return;
      }
      setState(() {
        hasPermission = true;
      });
    }).catchError((error) {
      Toast.showError(error);
    });

    Timer.run(() {
      animationController = AnimationController(
        duration: Duration(milliseconds: 3000),
        vsync: this,
      );

      animationController.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          //动画在结束时停止的状态
          // animationController.reverse(); // 反向开始执行动画
          animationController.reset();
        } else if (status == AnimationStatus.dismissed) {
          // 动画从 controller.reverse() 反向执行 结束时会回调此方法
          animationController.forward(); // 正向开始执行动画
        }
      });

      animation = Tween(
        begin: Offset.zero,
        // 1- 中间线的高度
        end: Offset(0.0, context.mediaWidth * 0.65 - borderWidth / 2) / 3,
      ).animate(animationController);
      //开始执行动画
      animationController.forward();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return CSScaffold(
      title: tr('global:btn_scan'),
      addTopInset: false,
      addBottomInset: false,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      headerBgColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      outerBackground: Colors.black,
      brightness: Brightness.dark,
      bottomChild: Material(
        type: MaterialType.transparency,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: context.mediaWidth * 0.2),
            child: CSButtonIcon(
              icon: Icons.image,
              size: 35,
              color: context.whiteColor,
              borderRadius: 50,
              containerSize: 60,
              background: context.blackColor.withOpacity(0.8),
              onPressed: () {
                scanFromLocalImage();
              },
            ),
          ),
        ),
      ),
      outerChild: Stack(
        children: [
          if (hasPermission)
            QRView(
              key: qrKey,
              onQRViewCreated: onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: context.primaryColor,
                borderLength: 30,
                borderWidth: borderWidth,
                borderRadius: context.edgeSize,
                cutOutSize: context.mediaWidth * 0.65,
              ),
            ),
          if (animation != null && hasPermission)
            Align(
              child: Container(
                margin: EdgeInsets.only(bottom: context.mediaWidth * 0.65),
                child: SlideTransition(
                  position: animation,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: context.radiusAll,
                      gradient: RadialGradient(
                        center: Alignment(-0.0, -0.0),
                        radius: (context.mediaWidth * 0.65 - borderWidth) / 6,
                        colors: [
                          context.primaryColor,
                          context.primaryColor,
                          context.primaryColor.withOpacity(0.9),
                          context.primaryColor.withOpacity(0.8),
                          context.primaryColor.withOpacity(0.7),
                          context.primaryColor.withOpacity(0.6),
                          context.primaryColor.withOpacity(0.5),
                          context.primaryColor.withOpacity(0.45),
                          context.primaryColor.withOpacity(0.4),
                          context.primaryColor.withOpacity(0.35),
                          context.primaryColor.withOpacity(0.3),
                          context.primaryColor.withOpacity(0.25),
                          context.primaryColor.withOpacity(0.2),
                          context.primaryColor.withOpacity(0.15),
                          context.primaryColor.withOpacity(0.1),
                          context.primaryColor.withOpacity(0.05),
                          Colors.transparent,
                        ],
                      ),
                    ),
                    child: SizedBox(
                      height: 3,
                      width: context.mediaWidth * 0.65 - borderWidth,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      child: SizedBox(),
    );
  }

  void onQRViewCreated(QRViewController ctrl) {
    qrController = ctrl;
    qrController.startScan();
    qrSubscription = qrController.scannedDataStream.listen((scanData) {
      if (scanData != null && scanData != '') {
        qrController.pauseCamera();
        AppNavigator.popWithResult(scanData);
      }
    });
  }

  void scanFromLocalImage() {
    qrController.pauseCamera();
    // 选择图片
    CameraUtils.openGallery().then((imgResult) {
      if (imgResult == null || imgResult.file == null) {
        qrController.resumeCamera();
      } else {
        // 识别图片
        QrCodeToolsPlugin.decodeFrom(imgResult.file.path).then((scanData) {
          if (scanData != null && scanData != '') {
            AppNavigator.popWithResult(scanData);
          } else {
            qrController.resumeCamera();
            Toast.show(tr('global:msg_scan_invalid'));
          }
        }).catchError((_) {
          qrController.resumeCamera();
          Toast.show(tr('global:msg_scan_invalid'));
        });
      }
    }).catchError((error) {
      Toast.showError(error);
      qrController.resumeCamera();
    });
  }

  @override
  void dispose() {
    super.dispose();
    qrSubscription?.cancel();
    qrController?.dispose();
  }
}
