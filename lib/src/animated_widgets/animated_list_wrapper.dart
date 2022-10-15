import 'package:animated_multichild/src/utils/extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../animated_multichild.dart';
import '../configurations/animation_container.dart';

import 'dart:math' as math;

class AnimatedListViewWrapper extends BoxScrollView {
  AnimatedListViewWrapper({
    super.key,
    super.scrollDirection,
    super.reverse,
    super.controller,
    super.primary,
    super.physics,
    super.shrinkWrap,
    super.padding,
    this.itemExtent,
    this.prototypeItem,
    bool addAutomaticKeepAlive = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    super.cacheExtent,
    List<Widget> children = const <Widget>[],
    int? semanticChildCount,
    super.dragStartBehavior,
    super.keyboardDismissBehavior,
    super.restorationId,
    super.clipBehavior,
    required this.duration,
    required this.delay,
    required this.curve,
    required this.transitionBuilder,
    this.indexedChildTransitionBuilder,
  })  : assert(
          itemExtent == null || prototypeItem == null,
          'You can only pass itemExtent or prototypeItem, not both.',
        ),
        childrenDelegate = SliverChildListDelegate(
          children
              .mapIndexed<Widget>(
                (e, index) => AnimationContainer(
                  builder: (BuildContext context, Animation<double> animation) {
                    return indexedChildTransitionBuilder?.call(
                            context, animation, children[index], index) ??
                        transitionBuilder(context, animation, children[index]);
                  },
                  delay: delay * index,
                  duration: duration,
                  curve: curve,
                ),
              )
              .toList(),
          addAutomaticKeepAlives: addAutomaticKeepAlive,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
        ),
        super(
          semanticChildCount: semanticChildCount ?? children.length,
        );

  AnimatedListViewWrapper.builder({
    super.key,
    super.scrollDirection,
    super.reverse,
    super.controller,
    super.primary,
    super.physics,
    super.shrinkWrap,
    super.padding,
    this.itemExtent,
    this.prototypeItem,
    required IndexedWidgetBuilder itemBuilder,
    ChildIndexGetter? findChildIndexCallback,
    int? itemCount,
    bool addAutomaticKeepAlive = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    super.cacheExtent,
    int? semanticChildCount,
    super.dragStartBehavior,
    super.keyboardDismissBehavior,
    super.restorationId,
    super.clipBehavior,
    required this.duration,
    required this.delay,
    required this.curve,
    required this.transitionBuilder,
    this.indexedChildTransitionBuilder,
  })  : assert(itemCount == null || itemCount >= 0),
        assert(semanticChildCount == null || semanticChildCount <= itemCount!),
        assert(
          itemExtent == null || prototypeItem == null,
          'You can only pass itemExtent or prototypeItem, not both.',
        ),
        childrenDelegate = SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            final Widget child = itemBuilder(context, index);
            return AnimationContainer(
              duration: duration,
              curve: curve,
              delay: delay * index,
              builder: (BuildContext context, Animation<double> animation) {
                return indexedChildTransitionBuilder?.call(
                        context, animation, child, index) ??
                    transitionBuilder(context, animation, child);
              },
            );
          },
          findChildIndexCallback: findChildIndexCallback,
          childCount: itemCount,
          addAutomaticKeepAlives: addAutomaticKeepAlive,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
        ),
        super(
          semanticChildCount: semanticChildCount ?? itemCount,
        );

  AnimatedListViewWrapper.separated({
    super.key,
    super.scrollDirection,
    super.reverse,
    super.controller,
    super.primary,
    super.physics,
    super.shrinkWrap,
    super.padding,
    required IndexedWidgetBuilder itemBuilder,
    ChildIndexGetter? findChildIndexCallback,
    required IndexedWidgetBuilder separatorBuilder,
    required int itemCount,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    super.cacheExtent,
    super.dragStartBehavior,
    super.keyboardDismissBehavior,
    super.restorationId,
    super.clipBehavior,
    required this.duration,
    required this.delay,
    required this.curve,
    required this.transitionBuilder,
    this.indexedChildTransitionBuilder,
  })  : assert(itemCount >= 0),
        itemExtent = null,
        prototypeItem = null,
        childrenDelegate = SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            final int itemIndex = index ~/ 2;
            final Widget child;
            if (index.isEven) {
              child = itemBuilder(context, itemIndex);
            } else {
              child = separatorBuilder(context, itemIndex);
            }
            return AnimationContainer(
              duration: duration,
              curve: curve,
              delay: delay * itemIndex,
              builder: (context, animation) =>
                  indexedChildTransitionBuilder?.call(
                      context, animation, child, index) ??
                  transitionBuilder(context, animation, child),
            );
          },
          findChildIndexCallback: findChildIndexCallback,
          childCount: _computeActualChildCount(itemCount),
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
          semanticIndexCallback: (Widget _, int index) {
            return index.isEven ? index ~/ 2 : null;
          },
        ),
        super(
          semanticChildCount: itemCount,
        );

  final double? itemExtent;

  final Widget? prototypeItem;

  final Duration duration;
  final Duration delay;
  final Curve curve;
  final ChildTransitionBuilder transitionBuilder;
  final IndexedChildTransitionBuilder? indexedChildTransitionBuilder;

  final SliverChildDelegate childrenDelegate;

  @override
  Widget buildChildLayout(BuildContext context) {
    if (itemExtent != null) {
      return SliverFixedExtentList(
        delegate: childrenDelegate,
        itemExtent: itemExtent!,
      );
    } else if (prototypeItem != null) {
      return SliverPrototypeExtentList(
        delegate: childrenDelegate,
        prototypeItem: prototypeItem!,
      );
    }
    return SliverList(delegate: childrenDelegate);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DoubleProperty('itemExtent', itemExtent, defaultValue: null));
  }

  // Helper method to compute the actual child count for the separated constructor.
  static int _computeActualChildCount(int itemCount) {
    return math.max(0, itemCount * 2 - 1);
  }
}
