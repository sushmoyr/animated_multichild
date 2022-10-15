import 'package:animated_multichild/src/configurations/animation_container.dart';
import 'package:animated_multichild/src/utils/constants.dart';

import '../configurations/animation_limiter.dart';
import '../utils/extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'dart:math' as math;

class AnimatedListView extends StatelessWidget {
  AnimatedListView({
    super.key,
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    ScrollController? controller,
    bool? primary,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    EdgeInsetsGeometry? padding,
    double? itemExtent,
    Widget? prototypeItem,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    double? cacheExtent,
    List<Widget> children = const <Widget>[],
    int? semanticChildCount,
    DragStartBehavior dragStartBehaviour = DragStartBehavior.start,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior =
        ScrollViewKeyboardDismissBehavior.manual,
    String? restorationId,
    Clip clipBehavior = Clip.hardEdge,
    Duration duration = kThemeAnimationDuration,
    Curve curve = Curves.linear,
    Duration delay = Duration.zero,
    Widget Function(
            BuildContext context, Animation<double> animation, Widget child)
        transitionBuilder = defaultTransitionBuilder,
  }) : _instance = _DefaultListViewData(
          scrollDirection: scrollDirection,
          reverse: reverse,
          controller: controller,
          primary: primary,
          physics: physics,
          padding: padding,
          itemExtent: itemExtent,
          prototypeItem: prototypeItem,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
          cacheExtent: cacheExtent,
          semanticChildCount: semanticChildCount,
          keyboardDismissBehavior: keyboardDismissBehavior,
          clipBehavior: clipBehavior,
          children: children,
          restorationId: restorationId,
          shrinkWrap: shrinkWrap,
          dragStartBehavior: dragStartBehaviour,
          duration: duration,
          delay: delay,
          curve: curve,
          transitionBuilder: transitionBuilder,
        );

  AnimatedListView.builder({
    super.key,
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    ScrollController? controller,
    bool? primary,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    EdgeInsetsGeometry? padding,
    double? itemExtent,
    Widget? prototypeItem,
    required IndexedWidgetBuilder itemBuilder,
    ChildIndexGetter? findChildIndexCallback,
    int? itemCount,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    double? cacheExtent,
    int? semanticChildCount,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior =
        ScrollViewKeyboardDismissBehavior.manual,
    String? restorationId,
    Clip clipBehavior = Clip.hardEdge,
    Duration duration = kThemeAnimationDuration,
    Curve curve = Curves.linear,
    Duration delay = Duration.zero,
    Widget Function(
            BuildContext context, Animation<double> animation, Widget child)
        transitionBuilder = defaultTransitionBuilder,
  }) : _instance = _BuilderListViewData(
          scrollDirection: scrollDirection,
          reverse: reverse,
          controller: controller,
          primary: primary,
          physics: physics,
          shrinkWrap: shrinkWrap,
          padding: padding,
          itemExtent: itemExtent,
          prototypeItem: prototypeItem,
          itemBuilder: itemBuilder,
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
          duration: duration,
          curve: curve,
          delay: delay,
          transitionBuilder: transitionBuilder,
        );

  AnimatedListView.separated({
    super.key,
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    ScrollController? controller,
    bool? primary,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    EdgeInsetsGeometry? padding,
    required IndexedWidgetBuilder itemBuilder,
    ChildIndexGetter? findChildIndexCallback,
    required IndexedWidgetBuilder separatorBuilder,
    required int itemCount,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    double? cacheExtent,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior =
        ScrollViewKeyboardDismissBehavior.manual,
    String? restorationId,
    Clip clipBehavior = Clip.hardEdge,
    Duration duration = kThemeAnimationDuration,
    Curve curve = Curves.linear,
    Duration delay = Duration.zero,
    Widget Function(
            BuildContext context, Animation<double> animation, Widget child)
        transitionBuilder = defaultTransitionBuilder,
  }) : _instance = _SeparatedListViewData(
          scrollDirection: scrollDirection,
          reverse: reverse,
          controller: controller,
          primary: primary,
          physics: physics,
          shrinkWrap: shrinkWrap,
          padding: padding,
          itemBuilder: itemBuilder,
          findChildIndexCallback: findChildIndexCallback,
          separatorBuilder: separatorBuilder,
          itemCount: itemCount,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
          cacheExtent: cacheExtent,
          dragStartBehavior: dragStartBehavior,
          keyboardDismissBehavior: keyboardDismissBehavior,
          restorationId: restorationId,
          clipBehavior: clipBehavior,
          duration: duration,
          curve: curve,
          delay: delay,
          transitionBuilder: transitionBuilder,
        );

  final AnimatedListViewData _instance;
  //TODO: Add option for animation limiter, animation configuration

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: _decideChild(context),
    );
  }

  Widget _decideChild(BuildContext context) {
    if (_instance is _SeparatedListViewData) {
      final data = _instance as _SeparatedListViewData;
      return AnimatedListViewWrapper.separated(
        key: key,
        scrollDirection: data.scrollDirection,
        reverse: data.reverse,
        controller: data.controller,
        primary: data.primary,
        physics: data.physics,
        shrinkWrap: data.shrinkWrap,
        padding: data.padding,
        itemBuilder: data.itemBuilder,
        findChildIndexCallback: data.findChildIndexCallback,
        separatorBuilder: data.separatorBuilder,
        itemCount: data.itemCount,
        addAutomaticKeepAlives: data.addAutomaticKeepAlives,
        addRepaintBoundaries: data.addRepaintBoundaries,
        addSemanticIndexes: data.addSemanticIndexes,
        cacheExtent: data.cacheExtent,
        dragStartBehavior: data.dragStartBehavior,
        keyboardDismissBehavior: data.keyboardDismissBehavior,
        restorationId: data.restorationId,
        clipBehavior: data.clipBehavior,
        duration: data.duration,
        delay: data.delay,
        curve: data.curve,
        transitionBuilder: data.transitionBuilder,
      );
    }

    if (_instance is _BuilderListViewData) {
      final data = _instance as _BuilderListViewData;
      return AnimatedListViewWrapper.builder(
        key: key,
        scrollDirection: data.scrollDirection,
        reverse: data.reverse,
        controller: data.controller,
        primary: data.primary,
        physics: data.physics,
        shrinkWrap: data.shrinkWrap,
        padding: data.padding,
        itemExtent: data.itemExtent,
        prototypeItem: data.prototypeItem,
        itemBuilder: data.itemBuilder,
        findChildIndexCallback: data.findChildIndexCallback,
        itemCount: data.itemCount,
        addAutomaticKeepAlive: data.addAutomaticKeepAlives,
        addRepaintBoundaries: data.addRepaintBoundaries,
        addSemanticIndexes: data.addSemanticIndexes,
        cacheExtent: data.cacheExtent,
        semanticChildCount: data.semanticChildCount,
        dragStartBehavior: data.dragStartBehavior,
        keyboardDismissBehavior: data.keyboardDismissBehavior,
        restorationId: data.restorationId,
        clipBehavior: data.clipBehavior,
        duration: data.duration,
        delay: data.delay,
        curve: data.curve,
        transitionBuilder: data.transitionBuilder,
      );
    }

    final data = _instance as _DefaultListViewData;
    return AnimatedListViewWrapper(
      key: key,
      scrollDirection: data.scrollDirection,
      reverse: data.reverse,
      controller: data.controller,
      primary: data.primary,
      physics: data.physics,
      shrinkWrap: data.shrinkWrap,
      padding: data.padding,
      itemExtent: data.itemExtent,
      prototypeItem: data.prototypeItem,
      addAutomaticKeepAlive: data.addAutomaticKeepAlives,
      addRepaintBoundaries: data.addRepaintBoundaries,
      addSemanticIndexes: data.addSemanticIndexes,
      cacheExtent: data.cacheExtent,
      semanticChildCount: data.semanticChildCount,
      dragStartBehavior: data.dragStartBehavior,
      keyboardDismissBehavior: data.keyboardDismissBehavior,
      restorationId: data.restorationId,
      clipBehavior: data.clipBehavior,
      duration: data.duration,
      delay: data.delay,
      curve: data.curve,
      transitionBuilder: data.transitionBuilder,
      children: data.children,
    );
  }
}

abstract class AnimatedListViewData {
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
  final Widget Function(
          BuildContext context, Animation<double> animation, Widget child)
      transitionBuilder;

  const AnimatedListViewData({
    required this.scrollDirection,
    required this.reverse,
    required this.controller,
    required this.primary,
    required this.physics,
    required this.shrinkWrap,
    required this.padding,
    required this.addAutomaticKeepAlives,
    required this.addRepaintBoundaries,
    required this.addSemanticIndexes,
    required this.cacheExtent,
    required this.dragStartBehavior,
    required this.keyboardDismissBehavior,
    required this.restorationId,
    required this.clipBehavior,
    required this.duration,
    required this.delay,
    required this.curve,
    required this.transitionBuilder,
  });
}

class _DefaultListViewData extends AnimatedListViewData {
  const _DefaultListViewData({
    required super.scrollDirection,
    required super.reverse,
    required super.controller,
    required super.primary,
    required super.physics,
    required super.shrinkWrap,
    required super.padding,
    required super.addSemanticIndexes,
    required super.addRepaintBoundaries,
    required super.addAutomaticKeepAlives,
    required super.cacheExtent,
    required super.dragStartBehavior,
    required super.keyboardDismissBehavior,
    required super.restorationId,
    required super.clipBehavior,
    required this.semanticChildCount,
    required this.itemExtent,
    required this.prototypeItem,
    required this.children,
    required super.duration,
    required super.curve,
    required super.delay,
    required super.transitionBuilder,
  });

  final double? itemExtent;
  final Widget? prototypeItem;
  final List<Widget> children;
  final int? semanticChildCount;
}

class _BuilderListViewData extends AnimatedListViewData {
  const _BuilderListViewData({
    required super.scrollDirection,
    required super.reverse,
    required super.controller,
    required super.primary,
    required super.physics,
    required super.shrinkWrap,
    required super.padding,
    required this.itemExtent,
    required this.prototypeItem,
    required this.itemBuilder,
    required this.findChildIndexCallback,
    required this.itemCount,
    required super.addAutomaticKeepAlives,
    required super.addRepaintBoundaries,
    required super.addSemanticIndexes,
    required super.cacheExtent,
    required this.semanticChildCount,
    required super.dragStartBehavior,
    required super.keyboardDismissBehavior,
    required super.restorationId,
    required super.clipBehavior,
    required super.duration,
    required super.curve,
    required super.delay,
    required super.transitionBuilder,
  });

  final double? itemExtent;
  final Widget? prototypeItem;
  final int? semanticChildCount;
  final IndexedWidgetBuilder itemBuilder;
  final ChildIndexGetter? findChildIndexCallback;
  final int? itemCount;
}

class _SeparatedListViewData extends AnimatedListViewData {
  const _SeparatedListViewData({
    required super.scrollDirection,
    required super.reverse,
    required super.controller,
    required super.primary,
    required super.physics,
    required super.shrinkWrap,
    required super.padding,
    required this.itemBuilder,
    required this.findChildIndexCallback,
    required this.separatorBuilder,
    required this.itemCount,
    required super.addAutomaticKeepAlives,
    required super.addRepaintBoundaries,
    required super.addSemanticIndexes,
    required super.cacheExtent,
    required super.dragStartBehavior,
    required super.keyboardDismissBehavior,
    required super.restorationId,
    required super.clipBehavior,
    required super.duration,
    required super.curve,
    required super.delay,
    required super.transitionBuilder,
  });

  final IndexedWidgetBuilder itemBuilder;
  final ChildIndexGetter? findChildIndexCallback;
  final IndexedWidgetBuilder separatorBuilder;
  final int itemCount;
}

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
  })  : assert(
          itemExtent == null || prototypeItem == null,
          'You can only pass itemExtent or prototypeItem, not both.',
        ),
        childrenDelegate = SliverChildListDelegate(
          children
              .mapIndexed(
                (e, index) => AnimationContainer(
                  builder: (BuildContext context, Animation<double> animation) {
                    return transitionBuilder(
                        context, animation, children[index]);
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
                return transitionBuilder(context, animation, child);
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
  })  : assert(itemCount >= 0),
        itemExtent = null,
        prototypeItem = null,
        childrenDelegate = SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            final int itemIndex = index ~/ 2;
            final Widget widget;
            if (index.isEven) {
              widget = itemBuilder(context, itemIndex);
            } else {
              widget = separatorBuilder(context, itemIndex);
              assert(() {
                if (widget == null) {
                  throw FlutterError('separatorBuilder cannot return null.');
                }
                return true;
              }());
            }
            return widget;
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
  final Widget Function(
          BuildContext context, Animation<double> animation, Widget child)
      transitionBuilder;

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
