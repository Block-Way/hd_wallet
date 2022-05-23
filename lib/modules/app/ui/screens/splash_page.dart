part of app_module;

class AppSplashPage extends HookWidget {
  static const routeName = '/app/splash';

  static Route<dynamic> route(RouteSettings settings) {
    return FadeRoute(
      settings: settings,
      page: AppSplashPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context, false);
    final progress = useStreamController<double>();
    final loadEnd = useStreamController<bool>();
    final controller = useMemoized(
      () => VideoPlayerController.asset(
        'assets/video/splash.mp4',
        videoPlayerOptions: VideoPlayerOptions(
          mixWithOthers: true,
        ),
      ),
    );

    useEffect(() {
      controller.initialize();
      controller.setVolume(0);
      controller.play();
      controller.addListener(() {
        if (!controller.value.isPlaying) {
          loadEnd.add(true);
        }
      });

      Future.wait([
        store.dispatchFuture(AppActionInitApp(progress), notify: false),
        loadEnd.stream.firstWhere((end) => end, orElse: () => false),
      ]).catchError((error) {
        Toast.showError(error, defaultMessage: tr('global:msg_app_init_error'));
      }).whenComplete(() {
        AppMainPage.open();
      });

      if (kDebugMode) {
        loadEnd.add(true);
      }

      return () {
        controller.dispose();
      };
    }, []);

    return Scaffold(
      backgroundColor: context.primaryColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: context.primaryColor,
            height: double.infinity,
            width: double.infinity,
            child: AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: VideoPlayer(controller),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).viewPadding.top + 20,
            right: 20,
            child: CSButton(
              flat: true,
              customBorder: CircleBorder(),
              padding: context.edgeAll,
              textColor: context.bodyColor,
              label: tr('global:btn_skip'),
              onPressed: () {
                loadEnd.add(true);
              },
            ),
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: StreamBuilder<double>(
          //     stream: progress.stream,
          //     initialData: 0.0,
          //     builder: (context, data) => LinearProgressIndicator(
          //       value: data.data,
          //       backgroundColor: context.secondaryColor,
          //       valueColor: AlwaysStoppedAnimation(
          //         context.whiteColor,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
