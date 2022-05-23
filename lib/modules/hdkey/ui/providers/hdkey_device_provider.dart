part of hdkey_ui_module;

class HDKeyDeviceProvider extends HookWidget {
  const HDKeyDeviceProvider({
    @required this.device,
    @required this.child,
    Key key,
  }) : super(key: key);

  final Widget child;
  final HDKeyDevice device;

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      final subStatus = device.statusChanged.listen((status) {
        switch (status) {
          case HDKeyDeviceStatus.connecting:
            showHDKeyConnectingDialog(context, status, device.statusChanged);
            break;
          case HDKeyDeviceStatus.ready:
            // Device ready to use
            break;
          default:
        }
      });
      return () {
        subStatus.cancel();
      };
    }, []);

    return child;
  }
}
