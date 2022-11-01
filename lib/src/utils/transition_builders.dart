import 'package:flutter/material.dart';

/// Signature for a function that creates a widget for a given widget and animation
///
/// Used by [AnimatedList], [AnimatedGrid], [AnimatedColumn], [AnimatedRow] widgets
/// to build transition animations for their children.
typedef ChildTransitionBuilder = Widget Function(
    BuildContext context, Animation<double> animation, Widget child);

/// Signature for a function that creates a widget for a given index, widget and animation
///
/// Used by [AnimatedList], [AnimatedGrid], [AnimatedColumn], [AnimatedRow] widgets
/// to build transition animations for their children.
typedef IndexedChildTransitionBuilder = Widget Function(
    BuildContext context, Animation<double> animation, Widget child, int index);

/// Default animation duration duration for children.
///
/// Default is 255 milliseconds
const Duration kChildAnimationDuration = Duration(milliseconds: 255);

/// Default delay of a child to start animation. If a delay is 1 second, then a
/// child will start animating 1 second after the previous child started to animate.
///
/// Default value is 25 milliseconds.
const Duration kChildAnimationDelay = Duration(milliseconds: 25);

/// Curve used in the animation/transition of the child.
///
/// Default value is [Curves.linear]
const Curve kChildAnimationCurve = Curves.linear;

/// The transition class provides a set of predefined transitions and utility
/// functions to build transitions.
class Transitions {
  /// Default transition used in the animated widgets with vertical direction.
  static const ChildTransitionBuilder defaultTransitionVertical =
      _verticalCombination;

  /// Default transition used in the animated widgets with horizontal direction.
  static const ChildTransitionBuilder defaultTransitionHorizontal =
      _horizontalCombination;

  static Widget _verticalCombination(BuildContext context, animation, child) {
    return combine([fadeIn, slideInFromBottom]).call(context, animation, child);
  }

  static Widget _horizontalCombination(BuildContext context, animation, child) {
    return combine([fadeIn, slideInFromRight]).call(context, animation, child);
  }

  /// Predefined transitions which gives a fade in effect.
  static Widget fadeIn(
      BuildContext context, Animation<double> animation, Widget child) {
    return Opacity(
      opacity: animation.value,
      child: child,
    );
  }

  /// Predefined transitions which gives a scale in effect.
  static Widget scale(
      BuildContext context, Animation<double> animation, Widget child) {
    return Transform.scale(
      scale: animation.value,
      child: child,
    );
  }

  /// Predefined transitions which gives a slide in effect.
  static Widget slideInFromLeft(
      BuildContext context, Animation<double> animation, Widget child) {
    Animation<Offset> position =
        Tween(begin: const Offset(-1, 0), end: Offset.zero).animate(animation);
    return SlideTransition(
      position: position,
      child: child,
    );
  }

  /// Predefined transitions which gives a slide in effect.
  static Widget slideInFromRight(
      BuildContext context, Animation<double> animation, Widget child) {
    Animation<Offset> position =
        Tween(begin: const Offset(1, 0), end: Offset.zero).animate(animation);
    return SlideTransition(
      position: position,
      child: child,
    );
  }

  /// Predefined transitions which gives a slide in effect.
  static Widget slideInFromBottom(
      BuildContext context, Animation<double> animation, Widget child) {
    Animation<Offset> position =
        Tween(begin: const Offset(0, 1), end: Offset.zero).animate(animation);
    return SlideTransition(
      position: position,
      child: child,
    );
  }

  /// Combines multiple transition builders into one. Using this you can achieve
  /// a combination of multiple different transition effect.
  ///
  /// For example, combining a [Transition.scale] and [Transition.fadeIn] effect
  /// will result in a transition which adds both fade in and scale in effect on
  /// the child
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
