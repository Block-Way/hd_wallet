part of widgets;

/// Creates a [BehaviorStreamController] automatically disposed.
///
/// See also:
///   * [BehaviorStreamController], the created object
///   * [useStream], to listen to the created [BehaviorStreamController]
BehaviorSubject<T> useBehaviorStreamController<T>(
    {bool sync = false,
    VoidCallback onListen,
    VoidCallback onCancel,
    List<Object> keys}) {
  return use(_BehaviorStreamControllerHook(
    onCancel: onCancel,
    onListen: onListen,
    sync: sync,
    keys: keys,
  ));
}

class _BehaviorStreamControllerHook<T> extends Hook<BehaviorSubject<T>> {
  const _BehaviorStreamControllerHook(
      {this.sync = false, this.onListen, this.onCancel, List<Object> keys})
      : super(keys: keys);

  final bool sync;
  final VoidCallback onListen;
  final VoidCallback onCancel;

  @override
  _BehaviorStreamControllerHookState<T> createState() =>
      _BehaviorStreamControllerHookState<T>();
}

class _BehaviorStreamControllerHookState<T>
    extends HookState<BehaviorSubject<T>, _BehaviorStreamControllerHook<T>> {
  BehaviorSubject<T> _controller;

  @override
  void initHook() {
    super.initHook();
    _controller = BehaviorSubject<T>(
      sync: hook.sync,
      onCancel: hook.onCancel,
      onListen: hook.onListen,
    );
  }

  @override
  void didUpdateHook(_BehaviorStreamControllerHook<T> oldHook) {
    super.didUpdateHook(oldHook);
    if (oldHook.onListen != hook.onListen) {
      _controller.onListen = hook.onListen;
    }
    if (oldHook.onCancel != hook.onCancel) {
      _controller.onCancel = hook.onCancel;
    }
  }

  @override
  BehaviorSubject<T> build(BuildContext context) {
    return _controller;
  }

  @override
  void dispose() {
    _controller.close();
  }

  @override
  String get debugLabel => 'useBehaviorStreamController';
}
