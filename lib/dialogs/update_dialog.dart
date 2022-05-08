part of dialogs;

void showUpdateAppDialog(
  BuildContext context, {
  @required String downloadUrl,
  @required String description,
  @required String version,
}) {
  Future.delayed(Duration.zero, () {
    showCSDialog(
      context,
      (_) => _UpdateAppDialog(
        content: description ?? tr('global:update_dialog_default_content'),
        onConfirm: () {
          if (Platform.isIOS) {
            doOpenUrl(downloadUrl);
          } else if (Platform.isAndroid) {
            Timer.run(() {
              showCSDialog(
                context,
                (_) => _UpdateAppDownloadDialog(
                  url: downloadUrl,
                  version: version,
                ),
              );
            });
          }
        },
      ),
    );
  });
}

class _UpdateAppDialog extends StatelessWidget {
  const _UpdateAppDialog({
    this.content,
    this.onConfirm,
    this.hideCancel = false,
  });

  /// 弹窗内容
  final String content;
  final bool hideCancel;

  /// 弹窗关闭回调
  final void Function() onConfirm;

  @override
  Widget build(BuildContext context) {
    final width = context.mediaWidth;
    final height = context.mediaHeight;

    return CSBaseDialog(
      hideCancel: hideCancel,
      confirmBtnText: tr('global:update_dialog_btn_confirm'),
      cancelBtnText: tr('global:btn_next_time'),
      onConfirm: onConfirm,
      cancelBtnStyle: context.textBody(
        color: context.secondaryColor,
      ),
      dismissOnBgClick: false,
      contentWidget: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: context.edgeAll,
            child: Center(
              child: Text(
                tr('global:update_dialog_title'),
                style: context.textBig(bold: true),
              ),
            ),
          ),
          Padding(
            padding: context.edgeAll,
            child: Container(
              constraints: BoxConstraints(
                minHeight: width * 0.4,
                maxHeight: height * 0.65,
              ),
              child: SingleChildScrollView(
                child: Text(
                  content ?? '',
                  style: context.textBody(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _UpdateAppDownloadDialog extends HookWidget {
  const _UpdateAppDownloadDialog({
    @required this.url,
    @required this.version,
  });

  final String url;
  final String version;

  @override
  Widget build(BuildContext context) {
    final complete = useState(false);
    final subscription = useMemoized<Map<String, StreamSubscription>>(() => {});

    useEffect(() {
      FlutterDabank.updateDownloadErrors.first.then((error) {
        Toast.showError(
          error,
          appendErrorToDefaultMessage: true,
          defaultMessage: tr('global:update_dialog_msg_fail'),
        );

        FlutterDabank.cancelUpdate();
        if (AppNavigator.canPop()) {
          AppNavigator.goBack();
        }
      });

      subscription['progress'] =
          FlutterDabank.updateDownloadProgress.listen((event) {
        if (event >= 100) {
          complete.value = true;
          Timer.run(FlutterDabank.installApk);
        }
      });

      FlutterDabank.updateAppAndroid(url: url, forceUpdate: false);
      return () {
        if (subscription['progress'] != null) {
          subscription['progress'].cancel();
        }
      };
    }, []);

    final width = context.mediaWidth * 0.75;
    final height = width * 0.91;
    final topImgHeight = width * 0.353;
    //  50 + context.edgeSizeDouble is button view height
    final contentHeight = height - topImgHeight - 50 - context.edgeSizeDouble;

    void handleCancel() {
      FlutterDabank.cancelUpdate();
      AppNavigator.goBack();
    }

    void handleConfirm() {
      FlutterDabank.installApk();
    }

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: GestureDetector(
        child: Material(
          type: MaterialType.transparency,
          child: Center(
            child: Stack(
              children: [
                Container(
                  width: width,
                  height: height,
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: context.radiusAll,
                  ),
                  child: CSImage(
                    'assets/images/update_bg.png',
                    width: width,
                    height: topImgHeight,
                    backgroundColor: Colors.transparent,
                    borderColor: Colors.transparent,
                  ),
                ),
                Container(
                  width: width,
                  height: height,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: topImgHeight,
                        child: Text(version ?? '',
                            style: context.textTitle(bold: true)),
                      ),
                      Container(
                          padding: context.edgeAll,
                          height: contentHeight,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                complete.value
                                    ? tr('global:update_download_complete_lbl')
                                    : tr('global:update_dialog_native_title'),
                                style: context.textBody(bold: true),
                              ),
                              if (!complete.value)
                                SizedBox(height: context.edgeSize),
                              if (!complete.value)
                                StreamBuilder<int>(
                                  stream: FlutterDabank.updateDownloadProgress,
                                  initialData: 0,
                                  builder: (context, snapshot) => Column(
                                    children: [
                                      Container(
                                        width: width * 0.72,
                                        decoration: context
                                            .boxDecoration(
                                              radius: 10,
                                            )
                                            .copyWith(
                                              border: Border.all(
                                                color: context.primaryColor,
                                              ),
                                            ),
                                        child: ClipRRect(
                                          borderRadius: context.radiusAll10,
                                          child: LinearProgressIndicator(
                                            minHeight: 6,
                                            backgroundColor: context.whiteColor,
                                            value: (snapshot?.data ?? 0) * 0.01,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              context.primaryColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                            ],
                          )),
                      Padding(
                        padding: context.edgeAll,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: complete.value == false
                              ? [
                                  CSButton(
                                    label:
                                        tr('global:update_dialog_btn_cancel'),
                                    bordered: true,
                                    borderRadius: 15,
                                    borderColor: Color(0xFFCCCCCC),
                                    backgroundColor: Colors.transparent,
                                    width: width * 0.53,
                                    textColor: context.secondaryColor,
                                    onPressed: handleCancel,
                                  ),
                                ]
                              : [
                                  Expanded(
                                    child: CSButton(
                                      bordered: true,
                                      borderColor: Color(0xFFCCCCCC),
                                      backgroundColor: Colors.transparent,
                                      onPressed: handleCancel,
                                      textColor: context.secondaryColor,
                                      label: tr('global:btn_next_time'),
                                    ),
                                  ),
                                  SizedBox(width: context.edgeSize),
                                  Expanded(
                                    child: CSButton(
                                      onPressed: handleConfirm,
                                      label:
                                          tr('global:update_btn_install_now'),
                                    ),
                                  ),
                                ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
