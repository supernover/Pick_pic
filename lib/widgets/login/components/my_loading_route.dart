import 'package:flutter/material.dart';

/// custom Navigator animation
class MyLoadingRoute<T> extends PageRoute<T> {
  MyLoadingRoute({this.builder, required this.duration, this.color});

  final WidgetBuilder? builder;
  final Duration duration;
  final Color? color;

  @override
  Color? get barrierColor => color;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder!(context);
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => duration;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
        opacity: CurvedAnimation(curve: Curves.easeInOut, parent: animation),child: child,);
  }
}
