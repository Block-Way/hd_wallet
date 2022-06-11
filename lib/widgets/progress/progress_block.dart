part of widgets;

class _StaggerAnimation extends StatelessWidget {
  _StaggerAnimation({
    Key? key,
    this.controller,
    this.end,
    this.start,
  })  : color = ColorTween(
          begin: Color(0xFFf7f7f7),
          end: Color(0xFFff8c2e),
        ).animate(
          CurvedAnimation(
            parent: controller!,
            curve: Interval(
              start!,
              end!,
              curve: Curves.ease,
            ),
          ),
        ),
        super(key: key);

  final Animation<double>? controller;
  late final Animation<Color?> color;
  final double? end;
  final double? start;

  Widget _buildAnimation(BuildContext context, Widget? child) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: 4,
        height: 12,
        decoration: BoxDecoration(
          color: color.value,
          borderRadius: BorderRadius.all(Radius.circular(3)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller!,
    );
  }
}

class CSProgressBlock extends HookWidget {
  const CSProgressBlock({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = useAnimationController(
      duration: const Duration(milliseconds: 4000),
    );
    final _squaresList = useMemoized(
      () => List.generate(
        25, // 25 squares
        (i) => _StaggerAnimation(
          controller: _controller.view,
          key: Key(i.toString()),
          start: i * 0.04,
          end: (i + 1) * 0.04,
        ),
      ),
    );

    useEffect(() {
      void onListen(AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          _controller.reset();
        }
        if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      }

      if (_squaresList.isNotEmpty) {
        _controller.forward();
        _controller.addStatusListener(onListen);
      }
      return () {
        _controller.removeStatusListener(onListen);
        _controller.dispose();
      };
    }, []);

    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _squaresList.isNotEmpty ? _squaresList : [Container()],
      ),
    );
  }
}
