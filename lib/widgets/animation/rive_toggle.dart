part of widgets;

class RiveToggleAnimation extends HookWidget {
  const RiveToggleAnimation({
    @required this.fileName,
    @required this.animationOnName,
    @required this.animationOffName,
    @required this.isOn,
    @required this.size,
    Key key,
  }) : super(key: key);

  final String fileName;
  final String animationOnName;
  final String animationOffName;
  final bool isOn;
  final double size;

  @override
  Widget build(BuildContext context) {
    final riveReload = useState(0);
    final riveArtboard = useState<Artboard>(null);
    final riveControllerOn = useMemoized(
      () => SimpleAnimation(animationOnName),
    );
    final riveControllerOff = useMemoized(
      () => SimpleAnimation(animationOffName),
    );

    void loadAnimation() {
      if (isOn) {
        riveControllerOn.init(riveArtboard.value.context);
        riveControllerOn.isActive = true;
        riveReload.value = riveReload.value + 1;
      } else {
        riveControllerOff.init(riveArtboard.value.context);
        riveControllerOff.isActive = true;
        riveReload.value = riveReload.value + 1;
      }
    }

    useEffect(() {
      rootBundle.load('assets/rive/$fileName.riv').then(
        (data) async {
          final file = RiveFile();
          if (file.import(data)) {
            riveArtboard.value = file.mainArtboard;
            // The last controller need to be the on one
            riveArtboard.value.addController(
              isOn ? riveControllerOff : riveControllerOn,
            );
            riveArtboard.value.addController(
              isOn ? riveControllerOn : riveControllerOff,
            );
          }
        },
      ).catchError((error) {
        debugPrint(error.toString());
      });
      return null;
    }, []);

    useEffect(() {
      if (riveArtboard.value != null) {
        loadAnimation();
      }
      return null;
    }, [isOn]);

    return SizedBox(
      width: size,
      height: size,
      child: Center(
        child: riveArtboard.value == null
            ? const SizedBox()
            : Rive(artboard: riveArtboard.value),
      ),
    );
  }
}
