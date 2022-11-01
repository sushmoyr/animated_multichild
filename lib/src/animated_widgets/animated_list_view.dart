import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../configurations/animation_stopper.dart';
import '../configurations/animation_container.dart';
import '../utils/extensions.dart';
import '../utils/transition_builders.dart';

///
class AnimatedListView extends StatelessWidget {
  /// Creates a scrollable, linear array of widgets from an explicit [List] whose
  /// children are animated automatically.
  ///
  /// The children will animate only first time when the [AnimatedListView] was
  /// instantiated.
  ///
  /// This constructor is appropriate for list views with a small number of
  /// children because constructing the [List] requires doing work for every
  /// child that could possibly be displayed in the list view instead of just
  /// those children that are actually visible.
  ///
  /// Like other widgets in the framework, this widget expects that
  /// the [children] list will not be mutated after it has been passed in here.
  /// See the documentation at [SliverChildListDelegate.children] for more details.
  ///
  /// It is usually more efficient to create children on demand using
  /// [AnimatedListView.builder] because it will create the widget children lazily as necessary.
  ///
  /// The `addAutomaticKeepAlives` argument corresponds to the
  /// [SliverChildListDelegate.addAutomaticKeepAlives] property. The
  /// `addRepaintBoundaries` argument corresponds to the
  /// [SliverChildListDelegate.addRepaintBoundaries] property. The
  /// `addSemanticIndexes` argument corresponds to the
  /// [SliverChildListDelegate.addSemanticIndexes] property. None
  /// may be null.
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

  /// Creates a scrollable, linear array of widgets that are created on demand
  /// whose children are animated automatically.
  ///
  /// The child items that are rendered when the [AnimatedListView] was created
  /// will be animated. But the items which are created on demand later will not
  /// be animated.
  ///
  /// This constructor is appropriate for list views with a large (or infinite)
  /// number of children because the builder is called only for those children
  /// that are actually visible.
  ///
  /// Providing a non-null `itemCount` improves the ability of the [AnimatedListView] to
  /// estimate the maximum scroll extent.
  ///
  /// The `itemBuilder` callback will be called only with indices greater than
  /// or equal to zero and less than `itemCount`.
  ///
  /// The `itemBuilder` should always return a non-null widget, and actually
  /// create the widget instances when called. Avoid using a builder that
  /// returns a previously-constructed widget; if the list view's children are
  /// created in advance, or all at once when the [AnimatedListView] itself is created,
  /// it is more efficient to use the [AnimatedListView] constructor. Even more
  /// efficient, however, is to create the instances on demand using this
  /// constructor's `itemBuilder` callback.
  ///
  /// {@macro flutter.widgets.PageView.findChildIndexCallback}
  ///
  /// The `addAutomaticKeepAlives` argument corresponds to the
  /// [SliverChildBuilderDelegate.addAutomaticKeepAlives] property. The
  /// `addRepaintBoundaries` argument corresponds to the
  /// [SliverChildBuilderDelegate.addRepaintBoundaries] property. The
  /// `addSemanticIndexes` argument corresponds to the
  /// [SliverChildBuilderDelegate.addSemanticIndexes] property. None may be
  /// null.
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

  /// Creates a fixed-length scrollable linear array of list "items" separated
  /// by list item "separators" whose children are animated automatically.
  ///
  /// This constructor is appropriate for list views with a large number of
  /// item and separator children because the builders are only called for
  /// the children that are actually visible.
  ///
  /// The child items that are rendered when the [AnimatedListView] was created
  /// will be animated. But the items which are created on demand later will not
  /// be animated.
  ///
  /// The `itemBuilder` callback will be called with indices greater than
  /// or equal to zero and less than `itemCount`.
  ///
  /// Separators only appear between list items: separator 0 appears after item
  /// 0 and the last separator appears before the last item.
  ///
  /// The `separatorBuilder` callback will be called with indices greater than
  /// or equal to zero and less than `itemCount - 1`.
  ///
  /// The `itemBuilder` and `separatorBuilder` callbacks should always return a
  /// non-null widget, and actually create widget instances when called. Avoid
  /// using a builder that returns a previously-constructed widget; if the list
  /// view's children are created in advance, or all at once when the [AnimatedListView]
  /// itself is created, it is more efficient to use the [AnimatedListView] constructor.
  ///
  /// {@macro flutter.widgets.PageView.findChildIndexCallback}
  ///
  /// {@tool snippet}
  ///
  /// This example shows how to create [AnimatedListView] whose [ListTile] list items
  /// are separated by [Divider]s.
  ///
  /// ```dart
  /// AnimatedListView.separated(
  ///   itemCount: 25,
  ///   separatorBuilder: (BuildContext context, int index) => const Divider(),
  ///   itemBuilder: (BuildContext context, int index) {
  ///     return ListTile(
  ///       title: Text('item $index'),
  ///     );
  ///   },
  /// )
  /// ```
  /// {@end-tool}
  ///
  /// The `addAutomaticKeepAlives` argument corresponds to the
  /// [SliverChildBuilderDelegate.addAutomaticKeepAlives] property. The
  /// `addRepaintBoundaries` argument corresponds to the
  /// [SliverChildBuilderDelegate.addRepaintBoundaries] property. The
  /// `addSemanticIndexes` argument corresponds to the
  /// [SliverChildBuilderDelegate.addSemanticIndexes] property. None may be
  /// null.
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
