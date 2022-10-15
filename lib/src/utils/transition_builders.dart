import 'package:flutter/material.dart';

typedef ChildTransitionBuilder = Widget Function(
    BuildContext context, Animation<double> animation, Widget child);

typedef IndexedChildTransitionBuilder = Widget Function(
    BuildContext context, Animation<double> animation, Widget child, int index);

const Duration kChildAnimationDuration = Duration(milliseconds: 300);
const Duration kChildAnimationDelay = Duration(milliseconds: 40);
const Curve kChildAnimationCurve = Curves.linear;

Widget defaultTransitionBuilder(
    BuildContext context, Animation<double> animation, Widget child) {
  return FadeTransition(
    opacity: animation,
    child: child,
  );
}

class Transitions {
  static const ChildTransitionBuilder defaultTransitionVertical =
      _verticalCombination;
  static const ChildTransitionBuilder defaultTransitionHorizontal =
      _horizontalCombination;

  static Widget _verticalCombination(BuildContext context, animation, child) {
    return combine([fadeIn, slideInFromBottom]).call(context, animation, child);
  }

  static Widget _horizontalCombination(BuildContext context, animation, child) {
    return combine([fadeIn, slideInFromRight]).call(context, animation, child);
  }

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

  static ChildTransitionBuilder combine(List<ChildTransitionBuilder> builders) {
    return (context, animation, child) {
      Widget initial = child;
      for (var b in builders) {
        initial = b(context, animation, initial);
      }
      return initial;
    };
  }
}
