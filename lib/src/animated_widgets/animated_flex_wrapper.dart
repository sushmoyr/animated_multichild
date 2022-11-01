import 'package:animated_multichild/animated_multichild.dart';
import 'package:animated_multichild/src/utils/extensions.dart';
import 'package:flutter/material.dart';

import '../configurations/animation_container.dart';

class AnimatedFlexWrapper extends Flex {
  AnimatedFlexWrapper({
    super.key,
    super.mainAxisAlignment,
    super.mainAxisSize,
    super.crossAxisAlignment,
    super.textDirection,
    super.verticalDirection,
    super.textBaseline,
    required Axis direction,
    required Duration duration,
    required Curve curve,
    required Duration delay,
    required ChildTransitionBuilder transitionBuilder,
    IndexedChildTransitionBuilder? indexedChildTransitionBuilder,
    List<Widget> children = const <Widget>[],
  }) : super(
          direction: direction,
          children: children.mapIndexed<Widget>(
            (element, index) {
              Widget child = element;
              if (element is Flexible) {
                child = element.child;
              }

              Widget parent = AnimationContainer(
                duration: duration,
                curve: curve,
                delay: delay * index,
                builder: (context, animation) {
                  return indexedChildTransitionBuilder?.call(
                          context, animation, child, index) ??
                      transitionBuilder(context, animation, child);
                },
              );

              if (element is Flexible) {
                parent = Flexible(
                  key: element.key,
                  flex: element.flex,
                  fit: element.fit,
                  child: parent,
                );
              }
              return parent;
            },
          ).toList(),
        );
}
