// Dart imports:
import 'dart:math' show sqrt, max;
import 'dart:ui' show lerpDouble;

// Flutter imports:
import 'package:flutter/material.dart';

class DefaultTransition<T> extends MaterialPageRoute<T> {
  DefaultTransition(RouteSettings settings, Widget page)
      : super(
          settings: settings,
          builder: (context) => page,
        );
}

class FadeRoute extends PageRouteBuilder {
  FadeRoute({this.page, this.settings})
      : super(
          pageBuilder: (
            context,
            animation,
            secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            context,
            animation,
            secondaryAnimation,
            child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
  final Widget page;
  @override
  final RouteSettings settings;
}

class EnterExitRoute extends PageRouteBuilder {
  EnterExitRoute({this.exitPage, this.enterPage})
      : super(
          pageBuilder: (
            context,
            animation,
            secondaryAnimation,
          ) =>
              enterPage,
          transitionsBuilder: (
            context,
            animation,
            secondaryAnimation,
            child,
          ) =>
              Stack(
            children: <Widget>[
              SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(0.0, 0.0),
                  end: Offset(-1.0, 0.0),
                ).animate(animation),
                child: exitPage,
              ),
              SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: enterPage,
              )
            ],
          ),
        );

  final Widget enterPage;
  final Widget exitPage;
}

class RevealRoute extends PageRouteBuilder {
  /// Reveals the next item pushed to the navigation using circle shape.
  ///
  /// You can provide [centerAlignment] for the reveal center or if you want a
  /// more precise use only [centerOffset] and leave other blank.
  ///
  /// The transition doesn't affect the entry screen so we will only touch
  /// the target screen.
  RevealRoute({
    @required this.page,
    @required this.maxRadius,
    this.minRadius = 100,
    this.duration = 1000,
    this.centerAlignment = Alignment.center,
    this.centerOffset,
    this.settings,
  }) : super(
          transitionDuration: Duration(milliseconds: duration),
          pageBuilder: (
            context,
            animation,
            secondaryAnimation,
          ) {
            return page;
          },
          transitionsBuilder: (
            context,
            animation,
            secondaryAnimation,
            child,
          ) {
            if (animation.status == AnimationStatus.reverse) {
              return page;
            }
            return ClipPath(
              clipper: CircularRevealClipper(
                fraction: animation.value,
                centerAlignment: centerAlignment,
                centerOffset: centerOffset,
                minRadius: minRadius,
                maxRadius: maxRadius,
              ),
              child: page,
            );
          },
        );

  final Widget page;
  final Alignment centerAlignment;
  final Offset centerOffset;
  final int duration;
  final double minRadius;
  final double maxRadius;
  @override
  final RouteSettings settings;
}

class CircularRevealClipper extends CustomClipper<Path> {
  const CircularRevealClipper({
    @required this.fraction,
    this.centerAlignment,
    this.centerOffset,
    this.minRadius,
    this.maxRadius,
  });

  final double fraction;
  final Alignment centerAlignment;
  final Offset centerOffset;
  final double minRadius;
  final double maxRadius;

  @override
  Path getClip(Size size) {
    final center = centerAlignment?.alongSize(size) ??
        centerOffset ??
        Offset(size.width / 2, size.height / 2);
    final minRadius = this.minRadius ?? 0;
    final maxRadius = this.maxRadius ?? calcMaxRadius(size, center);

    return Path()
      ..addOval(
        Rect.fromCircle(
          center: center,
          radius: lerpDouble(minRadius, maxRadius, fraction),
        ),
      );
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;

  static double calcMaxRadius(Size size, Offset center) {
    final w = max(center.dx, size.width - center.dx);
    final h = max(center.dy, size.height - center.dy);
    return sqrt(w * w + h * h);
  }
}
