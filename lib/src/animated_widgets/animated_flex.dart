import 'package:animated_multichild/animated_multichild.dart';
import 'package:animated_multichild/src/animated_widgets/animated_flex_wrapper.dart';
import 'package:flutter/material.dart';

class AnimatedColumn extends StatelessWidget {
  const AnimatedColumn({
    Key? key,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
    this.children = const [],
    this.duration = kChildAnimationDuration,
    this.curve = kChildAnimationCurve,
    this.delay = kChildAnimationDelay,
    this.transitionBuilder = Transitions.defaultTransitionVertical,
    this.indexedChildTransitionBuilder,
  }) : super(key: key);
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;
  final List<Widget> children;
  final Duration duration;
  final Curve curve;
  final Duration delay;
  final ChildTransitionBuilder transitionBuilder;
  final IndexedChildTransitionBuilder? indexedChildTransitionBuilder;

  @override
  Widget build(BuildContext context) {
    return AnimationStopper(
      child: AnimatedFlexWrapper(
        key: key,
        mainAxisAlignment: mainAxisAlignment,
        mainAxisSize: mainAxisSize,
        crossAxisAlignment: crossAxisAlignment,
        textDirection: textDirection,
        verticalDirection: verticalDirection,
        textBaseline: textBaseline,
        direction: Axis.vertical,
        duration: duration,
        curve: curve,
        delay: delay,
        transitionBuilder: transitionBuilder,
        indexedChildTransitionBuilder: indexedChildTransitionBuilder,
        children: children,
      ),
    );
  }
}

class AnimatedRow extends StatelessWidget {
  const AnimatedRow({
    Key? key,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
    this.children = const [],
    this.duration = kChildAnimationDuration,
    this.curve = kChildAnimationCurve,
    this.delay = kChildAnimationDelay,
    this.transitionBuilder = Transitions.defaultTransitionHorizontal,
    this.indexedChildTransitionBuilder,
  }) : super(key: key);
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;
  final List<Widget> children;
  final Duration duration;
  final Curve curve;
  final Duration delay;
  final ChildTransitionBuilder transitionBuilder;
  final IndexedChildTransitionBuilder? indexedChildTransitionBuilder;

  @override
  Widget build(BuildContext context) {
    return AnimationStopper(
      child: AnimatedFlexWrapper(
        key: key,
        mainAxisAlignment: mainAxisAlignment,
        mainAxisSize: mainAxisSize,
        crossAxisAlignment: crossAxisAlignment,
        textDirection: textDirection,
        verticalDirection: verticalDirection,
        textBaseline: textBaseline,
        direction: Axis.horizontal,
        duration: duration,
        curve: curve,
        delay: delay,
        transitionBuilder: transitionBuilder,
        indexedChildTransitionBuilder: indexedChildTransitionBuilder,
        children: children,
      ),
    );
  }
}
