part of widgets;

AutoScrollController useAutoScrollController({
  double initialScrollOffset = 0.0,
  bool keepScrollOffset = true,
  String debugLabel,
  Axis axis,
  List<Object> keys,
}) {
  return use(
    _AutoScrollControllerHook(
      initialScrollOffset: initialScrollOffset,
      keepScrollOffset: keepScrollOffset,
      debugLabel: debugLabel,
      axis: axis,
      keys: keys,
    ),
  );
}

class _AutoScrollControllerHook extends Hook<AutoScrollController> {
  const _AutoScrollControllerHook({
    this.initialScrollOffset,
    this.keepScrollOffset,
    this.debugLabel,
    this.axis,
    List<Object> keys,
  }) : super(keys: keys);

  final double initialScrollOffset;
  final bool keepScrollOffset;
  final String debugLabel;
  final Axis axis;

  @override
  HookState<AutoScrollController, Hook<AutoScrollController>> createState() =>
      _AutoScrollControllerHookState();
}

class _AutoScrollControllerHookState
    extends HookState<AutoScrollController, _AutoScrollControllerHook> {
  AutoScrollController controller;

  @override
  void initHook() {
    controller = AutoScrollController(
      axis: hook.axis,
      initialScrollOffset: hook.initialScrollOffset,
      keepScrollOffset: hook.keepScrollOffset,
      debugLabel: hook.debugLabel,
    );
  }

  @override
  AutoScrollController build(BuildContext context) => controller;

  @override
  void dispose() => controller.dispose();

  @override
  String get debugLabel => 'useAutoScrollController';
}
