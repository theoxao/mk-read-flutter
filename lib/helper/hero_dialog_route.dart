import 'package:flutter/material.dart';

class HeroDialogRoute<T> extends PageRoute<T>{

  HeroDialogRoute(this.builder);

  final WidgetBuilder builder;


  @override
  bool get opaque =>false;


  @override
  bool get barrierDismissible =>false;

  @override
  Color get barrierColor => Colors.black;

  @override
  String get barrierLabel => "";

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return builder(context);
  }


  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return new FadeTransition(
        opacity: new CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut
        ),
        child: child
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration (milliseconds: 300);



}