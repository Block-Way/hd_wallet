part of hdkey_ui_module;

class HDKeyDeviceListener extends StatelessWidget {
  const HDKeyDeviceListener({
    @required this.activeWalletId,
    @required this.builder,
    Key key,
  }) : super(key: key);

  final String activeWalletId;
  final Widget Function({
    bool isHDKeyConnected,
  }) builder;

  @override
  Widget build(BuildContext context) {
    final hdKeyDevice = GetIt.I<HDKeyDevice>();
    return StreamBuilder<HDKeyDeviceStatus>(
        stream: hdKeyDevice.statusChanged,
        builder: (context, status) {
          final isHDKeyConnected =
              hdKeyDevice.connectedWalletId == activeWalletId &&
                  status.data == HDKeyDeviceStatus.ready;
          return builder(
            isHDKeyConnected: isHDKeyConnected,
          );
        });
  }
}
