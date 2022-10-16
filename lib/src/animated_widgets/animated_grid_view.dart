import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../configurations/animation_container.dart';
import '../utils/extensions.dart';
import '../utils/transition_builders.dart';
import '../configurations/animation_limiter.dart';

class AnimatedGridView extends StatelessWidget {
  AnimatedGridView({
    super.key,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    required SliverGridDelegate gridDelegate,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    List<Widget> children = const <Widget>[],
    int? semanticChildCount,
    this.dragStartBehavior = DragStartBehavior.down,
    this.clipBehavior = Clip.hardEdge,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.duration = kChildAnimationDuration,
    this.delay = kChildAnimationDelay,
    this.curve = kChildAnimationCurve,
    this.transitionBuilder = Transitions.defaultTransitionVertical,
    this.indexedChildTransitionBuilder,
  }) {
    _child = GridView(
      scrollDirection: scrollDirection,
      reverse: reverse,
      controller: controller,
      primary: primary,
      physics: physics,
      shrinkWrap: shrinkWrap,
      padding: padding,
      gridDelegate: gridDelegate,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: addRepaintBoundaries,
      addSemanticIndexes: addSemanticIndexes,
      cacheExtent: cacheExtent,
      semanticChildCount: semanticChildCount,
      children: _mapChildren(children, gridDelegate),
    );
  }

  AnimatedGridView.builder({
    super.key,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    required SliverGridDelegate gridDelegate,
    required IndexedWidgetBuilder itemBuilder,
    ChildIndexGetter? findChildIndexCallback,
    int? itemCount,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    int? semanticChildCount,
    this.dragStartBehavior = DragStartBehavior.down,
    this.clipBehavior = Clip.hardEdge,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.duration = kChildAnimationDuration,
    this.delay = kChildAnimationDelay,
    this.curve = kChildAnimationCurve,
    this.transitionBuilder = Transitions.defaultTransitionVertical,
    this.indexedChildTransitionBuilder,
  }) {
    _child = GridView.builder(
      scrollDirection: scrollDirection,
      reverse: reverse,
      controller: controller,
      primary: primary,
      physics: physics,
      shrinkWrap: shrinkWrap,
      padding: padding,
      gridDelegate: gridDelegate,
      findChildIndexCallback: findChildIndexCallback,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: addRepaintBoundaries,
      addSemanticIndexes: addSemanticIndexes,
      cacheExtent: cacheExtent,
      semanticChildCount: semanticChildCount,
      dragStartBehavior: dragStartBehavior,
      keyboardDismissBehavior: keyboardDismissBehavior,
      restorationId: restorationId,
      clipBehavior: clipBehavior,
      itemCount: itemCount,
      itemBuilder: (BuildContext context, int index) {
        final Widget child = itemBuilder(context, index);
        return AnimationContainer(
          duration: duration,
          curve: curve,
          delay: delay * _calculateDelayOffsetFor(index, gridDelegate),
          builder: (BuildContext context, Animation<double> animation) {
            return indexedChildTransitionBuilder?.call(
                    context, animation, child, index) ??
                transitionBuilder(context, animation, child);
          },
        );
      },
    );
  }

  AnimatedGridView.count({
    super.key,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    required int crossAxisCount,
    double mainAxisSpacing = 0.0,
    double crossAxisSpacing = 0.0,
    double childAspectRatio = 1.0,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    List<Widget> children = const <Widget>[],
    int? semanticChildCount,
    this.dragStartBehavior = DragStartBehavior.down,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
    this.duration = kChildAnimationDuration,
    this.delay = kChildAnimationDelay,
    this.curve = kChildAnimationCurve,
    this.transitionBuilder = Transitions.defaultTransitionVertical,
    this.indexedChildTransitionBuilder,
  }) {
    SliverGridDelegate delegate = SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: mainAxisSpacing,
      crossAxisSpacing: crossAxisSpacing,
      childAspectRatio: childAspectRatio,
    );
    _child = GridView.count(
      scrollDirection: scrollDirection,
      reverse: reverse,
      controller: controller,
      primary: primary,
      physics: physics,
      shrinkWrap: shrinkWrap,
      padding: padding,
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: mainAxisSpacing,
      childAspectRatio: childAspectRatio,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: addRepaintBoundaries,
      addSemanticIndexes: addSemanticIndexes,
      cacheExtent: cacheExtent,
      semanticChildCount: semanticChildCount,
      dragStartBehavior: dragStartBehavior,
      keyboardDismissBehavior: keyboardDismissBehavior,
      restorationId: restorationId,
      clipBehavior: clipBehavior,
      children: _mapChildren(children, delegate),
    );
  }

  AnimatedGridView.extent({
    super.key,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    required double maxCrossAxisExtent,
    double mainAxisSpacing = 0.0,
    double crossAxisSpacing = 0.0,
    double childAspectRatio = 1.0,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    List<Widget> children = const <Widget>[],
    int? semanticChildCount,
    this.dragStartBehavior = DragStartBehavior.down,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
    this.duration = kChildAnimationDuration,
    this.delay = kChildAnimationDelay,
    this.curve = kChildAnimationCurve,
    this.transitionBuilder = Transitions.defaultTransitionVertical,
    this.indexedChildTransitionBuilder,
  }) {
    SliverGridDelegate delegate = SliverGridDelegateWithMaxCrossAxisExtent(
      mainAxisSpacing: mainAxisSpacing,
      crossAxisSpacing: crossAxisSpacing,
      childAspectRatio: childAspectRatio,
      maxCrossAxisExtent: maxCrossAxisExtent,
    );
    _child = GridView.extent(
      scrollDirection: scrollDirection,
      reverse: reverse,
      controller: controller,
      primary: primary,
      physics: physics,
      shrinkWrap: shrinkWrap,
      padding: padding,
      maxCrossAxisExtent: maxCrossAxisExtent,
      mainAxisSpacing: mainAxisSpacing,
      childAspectRatio: childAspectRatio,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: addRepaintBoundaries,
      addSemanticIndexes: addSemanticIndexes,
      cacheExtent: cacheExtent,
      semanticChildCount: semanticChildCount,
      dragStartBehavior: dragStartBehavior,
      keyboardDismissBehavior: keyboardDismissBehavior,
      restorationId: restorationId,
      clipBehavior: clipBehavior,
      children: _mapChildren(children, delegate),
    );
  }

  final Axis scrollDirection;
  final bool reverse;
  final ScrollController? controller;
  final bool? primary;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final double? cacheExtent;
  final DragStartBehavior dragStartBehavior;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final String? restorationId;
  final Clip clipBehavior;

  final Duration duration;
  final Duration delay;
  final Curve curve;
  final ChildTransitionBuilder transitionBuilder;
  final IndexedChildTransitionBuilder? indexedChildTransitionBuilder;

  late final Widget _child;

  int _calculateDelayOffsetFor(int index, SliverGridDelegate gridDelegate) {
    int delayOffset = index;
    if (gridDelegate is SliverGridDelegateWithFixedCrossAxisCount) {
      int totalColumn = gridDelegate.crossAxisCount;
      delayOffset = ((index ~/ totalColumn) + (index % totalColumn));
    }

    // if (gridDelegate is SliverGridDelegateWithMaxCrossAxisExtent) {
    //   int totalColumn = gridDelegate.maxCrossAxisExtent;
    // }
    return delayOffset;
  }

  List<Widget> _mapChildren(
      List<Widget> children, SliverGridDelegate delegate) {
    return children.mapIndexed<Widget>((e, index) {
      return AnimationContainer(
        duration: duration,
        curve: curve,
        delay: delay * _calculateDelayOffsetFor(index, delegate),
        builder: (BuildContext context, Animation<double> animation) {
          return indexedChildTransitionBuilder?.call(
                  context, animation, children[index], index) ??
              transitionBuilder(context, animation, children[index]);
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: _child,
    );
  }
}
