part of hdkey_ui_module;

void showHDKeyConnectingDialog(
  BuildContext context,
  HDKeyDeviceStatus initialStatus,
  Stream<HDKeyDeviceStatus> statusStream,
) {
  return showCSBottomSheet(
    context,
    (context) => HDKeyWalletConnect(
      initialStatus: initialStatus,
      statusStream: statusStream,
    ),
  );
}

class HDKeyWalletConnect extends HookWidget {
  const HDKeyWalletConnect({
    @required this.initialStatus,
    @required this.statusStream,
  });

  final HDKeyDeviceStatus initialStatus;
  final Stream<HDKeyDeviceStatus> statusStream;

  @override
  Widget build(BuildContext context) {
    final hdKeyDevice = GetIt.I<HDKeyDevice>();
    final statusData = useStream(statusStream);
    final deviceStatus = statusData.data ?? initialStatus;

    if (deviceStatus == HDKeyDeviceStatus.disconnected) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '硬件钱包断开连接了，请保持设备连接状态',
              style: context.textBody(
                color: context.titleColor,
                bold: true,
              ),
            ),
            SizedBox(height: context.edgeSizeDouble),
            Icon(
              Icons.error_outline,
              color: context.redColor,
              size: context.mediaWidth * 0.25,
            ),
            SizedBox(height: context.edgeSize),
            CSButton(
              label: '关闭',
              onPressed: () {
                AppNavigator.goBack();
              },
            ),
          ],
        ),
      );
    }

    Widget buildContent() {
      // 连接
      if (deviceStatus == HDKeyDeviceStatus.connecting) {
        return Column(
          children: [
            CSImage(
              'assets/images/hdkey_tip_connecting.png',
              width: context.mediaWidth * 0.39,
              height: context.mediaWidth * 0.44,
              backgroundColor: Colors.transparent,
            ),
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Text(
                tr('设备连接中，请稍后…'),
                style: context.textBody(
                  bold: true,
                ),
              ),
            ),
          ],
        );
      }

      // 新设备
      if (deviceStatus == HDKeyDeviceStatus.empty) {
        return HDKeyDeviceEmpty(
          onCreate: (pin) {
            return hdKeyDevice.createNew(pin);
          },
        );
      }

      // 验证pin
      if (deviceStatus == HDKeyDeviceStatus.authorize) {
        return HDKeyDeviceAuthorize(
          onAuthorize: (pin) {
            return hdKeyDevice.authorize(pin);
          },
        );
      }

      // if (deviceStatus == HDKeyDeviceStatus.empty)
      //   SliverFillRemaining(
      //     child: CSEmpty(
      //       label: tr('wallet:hdkey_error_device'),
      //       imageUrl: 'assets/images/notify_empty_search.png',
      //     ),
      //   ),

      return Container();
    }

    return Container(
      padding: context.edgeHorizontal,
      height: 300,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          return ScaleTransition(
            scale: animation,
            child: child,
          );
        },
        child: Container(
          key: Key(deviceStatus.toString()),
          child: buildContent(),
        ),
      ),
    );
  }
}
