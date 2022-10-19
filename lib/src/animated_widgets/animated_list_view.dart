import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../configurations/animation_limiter.dart';
import '../configurations/animation_container.dart';
import '../utils/extensions.dart';
import '../utils/transition_builders.dart';

class AnimatedListView extends StatelessWidget {
  AnimatedListView({
    super.key,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    this.itemExtent,
    this.prototypeItem,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    List<Widget> children = const <Widget>[],
    int? semanticChildCount,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
    this.duration = kChildAnimationDuration,
    this.curve = kChildAnimationCurve,
    this.delay = kChildAnimationDelay,
    this.transitionBuilder = Transitions.defaultTransitionVertical,
    this.indexedChildTransitionBuilder,
  }) {
    _child = ListView(
      scrollDirection: scrollDirection,
      reverse: reverse,
      controller: controller,
      primary: primary,
      physics: physics,
      shrinkWrap: shrinkWrap,
      padding: padding,
      itemExtent: itemExtent,
      prototypeItem: prototypeItem,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: addRepaintBoundaries,
      addSemanticIndexes: addSemanticIndexes,
      cacheExtent: cacheExtent,
      semanticChildCount: semanticChildCount,
      dragStartBehavior: dragStartBehavior,
      keyboardDismissBehavior: keyboardDismissBehavior,
      restorationId: restorationId,
      clipBehavior: clipBehavior,
      children: _mapChildren(children),
    );
  }

  AnimatedListView.builder({
    super.key,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    this.itemExtent,
    this.prototypeItem,
    required IndexedWidgetBuilder itemBuilder,
    ChildIndexGetter? findChildIndexCallback,
    int? itemCount,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    int? semanticChildCount,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
    this.duration = kChildAnimationDuration,
    this.curve = kChildAnimationCurve,
    this.delay = kChildAnimationDelay,
    this.transitionBuilder = Transitions.defaultTransitionVertical,
    this.indexedChildTransitionBuilder,
  }) {
    _child = ListView.builder(
      scrollDirection: scrollDirection,
      reverse: reverse,
      controller: controller,
      primary: primary,
      physics: physics,
      shrinkWrap: shrinkWrap,
      padding: padding,
      itemExtent: itemExtent,
      prototypeItem: prototypeItem,
      itemBuilder: (ctx, index) =>
          _wrapWithAnimationContainer(itemBuilder(ctx, index), index),
      findChildIndexCallback: findChildIndexCallback,
      itemCount: itemCount,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: addRepaintBoundaries,
      addSemanticIndexes: addSemanticIndexes,
      cacheExtent: cacheExtent,
      semanticChildCount: semanticChildCount,
      dragStartBehavior: dragStartBehavior,
      keyboardDismissBehavior: keyboardDismissBehavior,
      restorationId: restorationId,
      clipBehavior: clipBehavior,
    );
  }

  AnimatedListView.separated({
    super.key,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    required IndexedWidgetBuilder itemBuilder,
    ChildIndexGetter? findChildIndexCallback,
    required IndexedWidgetBuilder separatorBuilder,
    required int itemCount,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
    this.duration = kChildAnimationDuration,
    this.curve = kChildAnimationCurve,
    this.delay = kChildAnimationDelay,
    this.transitionBuilder = Transitions.defaultTransitionVertical,
    this.indexedChildTransitionBuilder,
  }) {
    itemExtent = null;
    prototypeItem = null;
    _child = ListView.separated(
      scrollDirection: scrollDirection,
      reverse: reverse,
      controller: controller,
      primary: primary,
      physics: physics,
      shrinkWrap: shrinkWrap,
      padding: padding,
      itemBuilder: (ctx, index) =>
          _wrapWithAnimationContainer(itemBuilder(ctx, index), index),
      findChildIndexCallback: findChildIndexCallback,
      itemCount: itemCount,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: addRepaintBoundaries,
      addSemanticIndexes: addSemanticIndexes,
      cacheExtent: cacheExtent,
      dragStartBehavior: dragStartBehavior,
      keyboardDismissBehavior: keyboardDismissBehavior,
      restorationId: restorationId,
      clipBehavior: clipBehavior,
      separatorBuilder: (ctx, index) =>
          _wrapWithAnimationContainer(separatorBuilder(ctx, index), index),
    );
  }

  late final Widget _child;

  final Axis scrollDirection;
  final bool reverse;
  final ScrollController? controller;
  final bool? primary;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;
  late final double? itemExtent;
  late final Widget? prototypeItem;
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

  @override
  Widget build(BuildContext context) {
    return AnimationStopper(child: _child);
  }

  List<Widget> _mapChildren(List<Widget> children) {
    return children
        .mapIndexed<Widget>(
          (e, index) => _wrapWithAnimationContainer(e, index),
        )
        .toList();
  }

  Widget _wrapWithAnimationContainer(Widget child, int index) {
    return AnimationContainer(
      builder: (BuildContext context, Animation<double> animation) {
        return indexedChildTransitionBuilder?.call(
                context, animation, child, index) ??
            transitionBuilder(context, animation, child);
      },
      delay: delay * index,
      duration: duration,
      curve: curve,
    );
  }
}

// class AnimatedListView extends StatelessWidget {
//   AnimatedListView({
//     super.key,
//     Axis scrollDirection = Axis.vertical,
//     bool reverse = false,
//     ScrollController? controller,
//     bool? primary,
//     ScrollPhysics? physics,
//     bool shrinkWrap = false,
//     EdgeInsetsGeometry? padding,
//     double? itemExtent,
//     Widget? prototypeItem,
//     bool addAutomaticKeepAlives = true,
//     bool addRepaintBoundaries = true,
//     bool addSemanticIndexes = true,
//     double? cacheExtent,
//     List<Widget> children = const <Widget>[],
//     int? semanticChildCount,
//     DragStartBehavior dragStartBehaviour = DragStartBehavior.start,
//     ScrollViewKeyboardDismissBehavior keyboardDismissBehavior =
//         ScrollViewKeyboardDismissBehavior.manual,
//     String? restorationId,
//     Clip clipBehavior = Clip.hardEdge,
//     Duration duration = kThemeAnimationDuration,
//     Curve curve = Curves.linear,
//     Duration delay = Duration.zero,
//     ChildTransitionBuilder transitionBuilder = defaultTransitionBuilder,
//     IndexedChildTransitionBuilder? indexedChildTransitionBuilder,
//   }) : _instance = _DefaultListViewData(
//           scrollDirection: scrollDirection,
//           reverse: reverse,
//           controller: controller,
//           primary: primary,
//           physics: physics,
//           padding: padding,
//           itemExtent: itemExtent,
//           prototypeItem: prototypeItem,
//           addAutomaticKeepAlives: addAutomaticKeepAlives,
//           addRepaintBoundaries: addRepaintBoundaries,
//           addSemanticIndexes: addSemanticIndexes,
//           cacheExtent: cacheExtent,
//           semanticChildCount: semanticChildCount,
//           keyboardDismissBehavior: keyboardDismissBehavior,
//           clipBehavior: clipBehavior,
//           children: children,
//           restorationId: restorationId,
//           shrinkWrap: shrinkWrap,
//           dragStartBehavior: dragStartBehaviour,
//           duration: duration,
//           delay: delay,
//           curve: curve,
//           transitionBuilder: transitionBuilder,
//           indexedChildTransitionBuilder: indexedChildTransitionBuilder,
//         );
//
//   AnimatedListView.builder({
//     super.key,
//     Axis scrollDirection = Axis.vertical,
//     bool reverse = false,
//     ScrollController? controller,
//     bool? primary,
//     ScrollPhysics? physics,
//     bool shrinkWrap = false,
//     EdgeInsetsGeometry? padding,
//     double? itemExtent,
//     Widget? prototypeItem,
//     required IndexedWidgetBuilder itemBuilder,
//     ChildIndexGetter? findChildIndexCallback,
//     int? itemCount,
//     bool addAutomaticKeepAlives = true,
//     bool addRepaintBoundaries = true,
//     bool addSemanticIndexes = true,
//     double? cacheExtent,
//     int? semanticChildCount,
//     DragStartBehavior dragStartBehavior = DragStartBehavior.start,
//     ScrollViewKeyboardDismissBehavior keyboardDismissBehavior =
//         ScrollViewKeyboardDismissBehavior.manual,
//     String? restorationId,
//     Clip clipBehavior = Clip.hardEdge,
//     Duration duration = kThemeAnimationDuration,
//     Curve curve = Curves.linear,
//     Duration delay = Duration.zero,
//     ChildTransitionBuilder transitionBuilder = defaultTransitionBuilder,
//     IndexedChildTransitionBuilder? indexedChildTransitionBuilder,
//   }) : _instance = _BuilderListViewData(
//           scrollDirection: scrollDirection,
//           reverse: reverse,
//           controller: controller,
//           primary: primary,
//           physics: physics,
//           shrinkWrap: shrinkWrap,
//           padding: padding,
//           itemExtent: itemExtent,
//           prototypeItem: prototypeItem,
//           itemBuilder: itemBuilder,
//           findChildIndexCallback: findChildIndexCallback,
//           itemCount: itemCount,
//           addAutomaticKeepAlives: addAutomaticKeepAlives,
//           addRepaintBoundaries: addRepaintBoundaries,
//           addSemanticIndexes: addSemanticIndexes,
//           cacheExtent: cacheExtent,
//           semanticChildCount: semanticChildCount,
//           dragStartBehavior: dragStartBehavior,
//           keyboardDismissBehavior: keyboardDismissBehavior,
//           restorationId: restorationId,
//           clipBehavior: clipBehavior,
//           duration: duration,
//           curve: curve,
//           delay: delay,
//           transitionBuilder: transitionBuilder,
//           indexedChildTransitionBuilder: indexedChildTransitionBuilder,
//         );
//
//   AnimatedListView.separated({
//     super.key,
//     Axis scrollDirection = Axis.vertical,
//     bool reverse = false,
//     ScrollController? controller,
//     bool? primary,
//     ScrollPhysics? physics,
//     bool shrinkWrap = false,
//     EdgeInsetsGeometry? padding,
//     required IndexedWidgetBuilder itemBuilder,
//     ChildIndexGetter? findChildIndexCallback,
//     required IndexedWidgetBuilder separatorBuilder,
//     required int itemCount,
//     bool addAutomaticKeepAlives = true,
//     bool addRepaintBoundaries = true,
//     bool addSemanticIndexes = true,
//     double? cacheExtent,
//     DragStartBehavior dragStartBehavior = DragStartBehavior.start,
//     ScrollViewKeyboardDismissBehavior keyboardDismissBehavior =
//         ScrollViewKeyboardDismissBehavior.manual,
//     String? restorationId,
//     Clip clipBehavior = Clip.hardEdge,
//     Duration duration = kThemeAnimationDuration,
//     Curve curve = Curves.linear,
//     Duration delay = Duration.zero,
//     ChildTransitionBuilder transitionBuilder = defaultTransitionBuilder,
//     IndexedChildTransitionBuilder? indexedChildTransitionBuilder,
//   }) : _instance = _SeparatedListViewData(
//           scrollDirection: scrollDirection,
//           reverse: reverse,
//           controller: controller,
//           primary: primary,
//           physics: physics,
//           shrinkWrap: shrinkWrap,
//           padding: padding,
//           itemBuilder: itemBuilder,
//           findChildIndexCallback: findChildIndexCallback,
//           separatorBuilder: separatorBuilder,
//           itemCount: itemCount,
//           addAutomaticKeepAlives: addAutomaticKeepAlives,
//           addRepaintBoundaries: addRepaintBoundaries,
//           addSemanticIndexes: addSemanticIndexes,
//           cacheExtent: cacheExtent,
//           dragStartBehavior: dragStartBehavior,
//           keyboardDismissBehavior: keyboardDismissBehavior,
//           restorationId: restorationId,
//           clipBehavior: clipBehavior,
//           duration: duration,
//           curve: curve,
//           delay: delay,
//           transitionBuilder: transitionBuilder,
//           indexedChildTransitionBuilder: indexedChildTransitionBuilder,
//         );
//
//   final AnimatedListViewData _instance;
//   //TODO: Add option for animation limiter
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimationLimiter(
//       child: _decideChild(context),
//     );
//   }
//
//   Widget _decideChild(BuildContext context) {
//     if (_instance is _SeparatedListViewData) {
//       final data = _instance as _SeparatedListViewData;
//       return AnimatedListViewWrapper.separated(
//         key: key,
//         scrollDirection: data.scrollDirection,
//         reverse: data.reverse,
//         controller: data.controller,
//         primary: data.primary,
//         physics: data.physics,
//         shrinkWrap: data.shrinkWrap,
//         padding: data.padding,
//         itemBuilder: data.itemBuilder,
//         findChildIndexCallback: data.findChildIndexCallback,
//         separatorBuilder: data.separatorBuilder,
//         itemCount: data.itemCount,
//         addAutomaticKeepAlives: data.addAutomaticKeepAlives,
//         addRepaintBoundaries: data.addRepaintBoundaries,
//         addSemanticIndexes: data.addSemanticIndexes,
//         cacheExtent: data.cacheExtent,
//         dragStartBehavior: data.dragStartBehavior,
//         keyboardDismissBehavior: data.keyboardDismissBehavior,
//         restorationId: data.restorationId,
//         clipBehavior: data.clipBehavior,
//         duration: data.duration,
//         delay: data.delay,
//         curve: data.curve,
//         transitionBuilder: data.transitionBuilder,
//         indexedChildTransitionBuilder: data.indexedChildTransitionBuilder,
//       );
//     }
//
//     if (_instance is _BuilderListViewData) {
//       final data = _instance as _BuilderListViewData;
//       return AnimatedListViewWrapper.builder(
//         key: key,
//         scrollDirection: data.scrollDirection,
//         reverse: data.reverse,
//         controller: data.controller,
//         primary: data.primary,
//         physics: data.physics,
//         shrinkWrap: data.shrinkWrap,
//         padding: data.padding,
//         itemExtent: data.itemExtent,
//         prototypeItem: data.prototypeItem,
//         itemBuilder: data.itemBuilder,
//         findChildIndexCallback: data.findChildIndexCallback,
//         itemCount: data.itemCount,
//         addAutomaticKeepAlive: data.addAutomaticKeepAlives,
//         addRepaintBoundaries: data.addRepaintBoundaries,
//         addSemanticIndexes: data.addSemanticIndexes,
//         cacheExtent: data.cacheExtent,
//         semanticChildCount: data.semanticChildCount,
//         dragStartBehavior: data.dragStartBehavior,
//         keyboardDismissBehavior: data.keyboardDismissBehavior,
//         restorationId: data.restorationId,
//         clipBehavior: data.clipBehavior,
//         duration: data.duration,
//         delay: data.delay,
//         curve: data.curve,
//         transitionBuilder: data.transitionBuilder,
//         indexedChildTransitionBuilder: data.indexedChildTransitionBuilder,
//       );
//     }
//
//     final data = _instance as _DefaultListViewData;
//     return AnimatedListViewWrapper(
//       key: key,
//       scrollDirection: data.scrollDirection,
//       reverse: data.reverse,
//       controller: data.controller,
//       primary: data.primary,
//       physics: data.physics,
//       shrinkWrap: data.shrinkWrap,
//       padding: data.padding,
//       itemExtent: data.itemExtent,
//       prototypeItem: data.prototypeItem,
//       addAutomaticKeepAlive: data.addAutomaticKeepAlives,
//       addRepaintBoundaries: data.addRepaintBoundaries,
//       addSemanticIndexes: data.addSemanticIndexes,
//       cacheExtent: data.cacheExtent,
//       semanticChildCount: data.semanticChildCount,
//       dragStartBehavior: data.dragStartBehavior,
//       keyboardDismissBehavior: data.keyboardDismissBehavior,
//       restorationId: data.restorationId,
//       clipBehavior: data.clipBehavior,
//       duration: data.duration,
//       delay: data.delay,
//       curve: data.curve,
//       transitionBuilder: data.transitionBuilder,
//       indexedChildTransitionBuilder: data.indexedChildTransitionBuilder,
//       children: data.children,
//     );
//   }
// }

// abstract class AnimatedListViewData {
//   final Axis scrollDirection;
//   final bool reverse;
//   final ScrollController? controller;
//   final bool? primary;
//   final ScrollPhysics? physics;
//   final bool shrinkWrap;
//   final EdgeInsetsGeometry? padding;
//   final bool addAutomaticKeepAlives;
//   final bool addRepaintBoundaries;
//   final bool addSemanticIndexes;
//   final double? cacheExtent;
//   final DragStartBehavior dragStartBehavior;
//   final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
//   final String? restorationId;
//   final Clip clipBehavior;
//
//   final Duration duration;
//   final Duration delay;
//   final Curve curve;
//   final ChildTransitionBuilder transitionBuilder;
//   final IndexedChildTransitionBuilder? indexedChildTransitionBuilder;
//
//   const AnimatedListViewData({
//     required this.scrollDirection,
//     required this.reverse,
//     required this.controller,
//     required this.primary,
//     required this.physics,
//     required this.shrinkWrap,
//     required this.padding,
//     required this.addAutomaticKeepAlives,
//     required this.addRepaintBoundaries,
//     required this.addSemanticIndexes,
//     required this.cacheExtent,
//     required this.dragStartBehavior,
//     required this.keyboardDismissBehavior,
//     required this.restorationId,
//     required this.clipBehavior,
//     required this.duration,
//     required this.delay,
//     required this.curve,
//     required this.transitionBuilder,
//     this.indexedChildTransitionBuilder,
//   });
// }

//
//
// class _DefaultListViewData extends AnimatedListViewData {
//   const _DefaultListViewData({
//     required super.scrollDirection,
//     required super.reverse,
//     required super.controller,
//     required super.primary,
//     required super.physics,
//     required super.shrinkWrap,
//     required super.padding,
//     required super.addSemanticIndexes,
//     required super.addRepaintBoundaries,
//     required super.addAutomaticKeepAlives,
//     required super.cacheExtent,
//     required super.dragStartBehavior,
//     required super.keyboardDismissBehavior,
//     required super.restorationId,
//     required super.clipBehavior,
//     required this.semanticChildCount,
//     required this.itemExtent,
//     required this.prototypeItem,
//     required this.children,
//     required super.duration,
//     required super.curve,
//     required super.delay,
//     required super.transitionBuilder,
//     super.indexedChildTransitionBuilder,
//   });
//
//   final double? itemExtent;
//   final Widget? prototypeItem;
//   final List<Widget> children;
//   final int? semanticChildCount;
// }
//
// class _BuilderListViewData extends AnimatedListViewData {
//   const _BuilderListViewData({
//     required super.scrollDirection,
//     required super.reverse,
//     required super.controller,
//     required super.primary,
//     required super.physics,
//     required super.shrinkWrap,
//     required super.padding,
//     required this.itemExtent,
//     required this.prototypeItem,
//     required this.itemBuilder,
//     required this.findChildIndexCallback,
//     required this.itemCount,
//     required super.addAutomaticKeepAlives,
//     required super.addRepaintBoundaries,
//     required super.addSemanticIndexes,
//     required super.cacheExtent,
//     required this.semanticChildCount,
//     required super.dragStartBehavior,
//     required super.keyboardDismissBehavior,
//     required super.restorationId,
//     required super.clipBehavior,
//     required super.duration,
//     required super.curve,
//     required super.delay,
//     required super.transitionBuilder,
//     super.indexedChildTransitionBuilder,
//   });
//
//   final double? itemExtent;
//   final Widget? prototypeItem;
//   final int? semanticChildCount;
//   final IndexedWidgetBuilder itemBuilder;
//   final ChildIndexGetter? findChildIndexCallback;
//   final int? itemCount;
// }
//
// class _SeparatedListViewData extends AnimatedListViewData {
//   const _SeparatedListViewData({
//     required super.scrollDirection,
//     required super.reverse,
//     required super.controller,
//     required super.primary,
//     required super.physics,
//     required super.shrinkWrap,
//     required super.padding,
//     required this.itemBuilder,
//     required this.findChildIndexCallback,
//     required this.separatorBuilder,
//     required this.itemCount,
//     required super.addAutomaticKeepAlives,
//     required super.addRepaintBoundaries,
//     required super.addSemanticIndexes,
//     required super.cacheExtent,
//     required super.dragStartBehavior,
//     required super.keyboardDismissBehavior,
//     required super.restorationId,
//     required super.clipBehavior,
//     required super.duration,
//     required super.curve,
//     required super.delay,
//     required super.transitionBuilder,
//     super.indexedChildTransitionBuilder,
//   });
//
//   final IndexedWidgetBuilder itemBuilder;
//   final ChildIndexGetter? findChildIndexCallback;
//   final IndexedWidgetBuilder separatorBuilder;
//   final int itemCount;
// }
