// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:connectivity/connectivity.dart';

StreamTransformer<ConnectivityResult, ConnectivityResult> debounce(
  Duration debounceDuration,
) {
  var _seenFirstData = false;
  Timer _debounceTimer;

  return StreamTransformer<ConnectivityResult, ConnectivityResult>.fromHandlers(
    handleData: (data, sink) {
      if (_seenFirstData) {
        _debounceTimer?.cancel();
        _debounceTimer = Timer(debounceDuration, () => sink.add(data));
      } else {
        sink.add(data);
        _seenFirstData = true;
      }
    },
    handleDone: (sink) {
      _debounceTimer?.cancel();
      sink.close();
    },
  );
}

StreamTransformer<ConnectivityResult, ConnectivityResult> startsWith(
  ConnectivityResult data,
) {
  return StreamTransformer<ConnectivityResult, ConnectivityResult>(
    (
      input,
      cancelOnError,
    ) {
      StreamController<ConnectivityResult> controller;
      StreamSubscription<ConnectivityResult> subscription;

      controller = StreamController<ConnectivityResult>(
        sync: true,
        onListen: () => controller?.add(data),
        onPause: ([resumeSignal]) =>
            subscription.pause(resumeSignal as Future<dynamic>),
        onResume: () => subscription.resume(),
        onCancel: () => subscription.cancel(),
      );

      subscription = input.listen(
        controller.add,
        onError: controller.addError,
        onDone: controller.close,
        cancelOnError: cancelOnError,
      );

      return controller.stream.listen(null);
    },
  );
}

const kOfflineDebounceDuration = Duration(seconds: kDebugMode ? 1 : 3);

class OfflineBuilder extends StatefulWidget {
  factory OfflineBuilder({
    Key key,
    Duration debounceDuration = kOfflineDebounceDuration,
    AsyncWidgetBuilder<bool> builder,
    Widget child,
    WidgetBuilder errorBuilder,
  }) {
    return OfflineBuilder.initialize(
      key: key,
      connectivityService: Connectivity(),
      debounceDuration: debounceDuration,
      builder: builder,
      errorBuilder: errorBuilder,
      child: child,
    );
  }

  @visibleForTesting
  const OfflineBuilder.initialize({
    @required this.connectivityService,
    Key key,
    this.debounceDuration = kOfflineDebounceDuration,
    this.builder,
    this.child,
    this.errorBuilder,
  })  : assert(debounceDuration != null, 'debounceDuration cannot be null'),
        assert(
            connectivityService != null, 'connectivityService cannot be null'),
        assert(
            !(builder is WidgetBuilder && child is Widget) &&
                !(builder == null && child == null),
            'You should specify either a builder or a child'),
        super(key: key);

  /// Override connectivity service used for testing
  final Connectivity connectivityService;

  /// Debounce duration from epileptic network situations
  final Duration debounceDuration;

  /// Used for building the child widget
  final AsyncWidgetBuilder<bool> builder;

  /// The widget below this widget in the tree.
  final Widget child;

  /// Used for building the error widget incase of any platform errors
  final WidgetBuilder errorBuilder;

  @override
  OfflineBuilderState createState() => OfflineBuilderState();
}

class OfflineBuilderState extends State<OfflineBuilder> {
  Stream<ConnectivityResult> _connectivityStream;

  @override
  void initState() {
    super.initState();

    _connectivityStream =
        Stream.fromFuture(widget.connectivityService.checkConnectivity())
            .asyncExpand((data) => widget
                .connectivityService.onConnectivityChanged
                .transform(startsWith(data)))
            .transform(debounce(widget.debounceDuration));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
      stream: _connectivityStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData && !snapshot.hasError) {
          return SizedBox();
        }

        if (snapshot.hasError) {
          if (widget.errorBuilder != null) {
            return widget.errorBuilder(context);
          }
          throw OfflineBuilderError(snapshot.error);
        }

        return widget.child ??
            widget.builder(
              context,
              AsyncSnapshot.withData(
                ConnectionState.done,
                snapshot.data == ConnectivityResult.none,
              ),
            );
      },
    );
  }
}

class OfflineBuilderError extends Error {
  OfflineBuilderError(this.error);

  final Object error;

  @override
  String toString() => error.toString();
}
