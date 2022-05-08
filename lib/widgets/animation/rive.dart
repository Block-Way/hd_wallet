part of widgets;

class WiperAnimation extends SimpleAnimation {
  WiperAnimation(String animationName) : super(animationName);

  void loop() {
    instance.animation.loop = Loop.loop;
    isActive = true;
  }

  void oneShot() => instance.animation.loop = Loop.oneShot;
}

class RiveAnimation extends HookWidget {
  const RiveAnimation({
    @required this.fileName,
    @required this.animation,
    @required this.width,
    Key key,
    this.height,
    this.isLoop = true,
  }) : super(key: key);

  final String fileName;
  final String animation;
  final double width;
  final double height;
  final bool isLoop;

  @override
  Widget build(BuildContext context) {
    final riveArtboard = useState<Artboard>(null);
    final riveController = useMemoized(() => WiperAnimation(animation));

    useEffect(() {
      rootBundle.load('assets/rive/$fileName.riv').then(
        (data) async {
          final file = RiveFile();

          // Load the RiveFile from the binary data.
          if (file.import(data)) {
            // The artboard is the root of the animation and gets drawn in the
            // Rive widget.
            riveArtboard.value = file.mainArtboard;

            // Add a controller to play back a known animation on the main/default
            // artboard.We store a reference to it so we can toggle playback.
            riveArtboard.value.addController(riveController);
            if (isLoop) {
              riveController.loop();
            } else {
              riveController.oneShot();
            }
          }
        },
      ).catchError((error) {
        debugPrint(error.toString());
      });

      return null;
    }, []);

    return SizedBox(
      width: width,
      height: height ?? width,
      child: Center(
        child: riveArtboard.value == null
            ? const SizedBox()
            : Rive(artboard: riveArtboard.value),
      ),
    );
  }
}
