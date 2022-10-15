import 'package:flutter/material.dart';

typedef TransitionBuilder = Widget Function(
    BuildContext context, Animation<double> animation, Widget child);

Widget defaultTransitionBuilder(
    BuildContext context, Animation<double> animation, Widget child) {
  return FadeTransition(
    opacity: animation,
    child: child,
  );
}

class Transitions {
  static Widget fadeIn(
      BuildContext context, Animation<double> animation, Widget child) {
    return Opacity(
      opacity: animation.value,
      child: child,
    );
  }

  static Widget scale(
      BuildContext context, Animation<double> animation, Widget child) {
    return Transform.scale(
      scale: animation.value,
      child: child,
    );
  }

  static Widget slideInFromLeft(
      BuildContext context, Animation<double> animation, Widget child) {
    Animation<Offset> position =
        Tween(begin: const Offset(-1, 0), end: Offset.zero).animate(animation);
    return SlideTransition(
      position: position,
      child: child,
    );
  }

  static Widget slideInFromRight(
      BuildContext context, Animation<double> animation, Widget child) {
    Animation<Offset> position =
        Tween(begin: const Offset(1, 0), end: Offset.zero).animate(animation);
    return SlideTransition(
      position: position,
      child: child,
    );
  }

  static Widget slideInFromBottom(
      BuildContext context, Animation<double> animation, Widget child) {
    Animation<Offset> position =
        Tween(begin: const Offset(0, 1), end: Offset.zero).animate(animation);
    return SlideTransition(
      position: position,
      child: child,
    );
  }

  static TransitionBuilder combine(List<TransitionBuilder> builders) {
    return (context, animation, child) {
      Widget initial = child;
      for (var b in builders) {
        initial = b(context, animation, initial);
      }
      return initial;
    };
  }
}
