import 'animation_limiter.dart';
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
  });

  final IndexedWidgetBuilder itemBuilder;
  final ChildIndexGetter? findChildIndexCallback;
  final IndexedWidgetBuilder separatorBuilder;
  final int itemCount;
}

class AnimatedListViewWrapper extends BoxScrollView {
  /// Creates a scrollable, linear array of widgets from an explicit [List].
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
  /// [ListView.builder] because it will create the widget children lazily as necessary.
  ///
  /// The `addAutomaticKeepAlives` argument corresponds to the
  /// [SliverChildListDelegate.addAutomaticKeepAlives] property. The
  /// `addRepaintBoundaries` argument corresponds to the
  /// [SliverChildListDelegate.addRepaintBoundaries] property. The
  /// `addSemanticIndexes` argument corresponds to the
  /// [SliverChildListDelegate.addSemanticIndexes] property. None
  /// may be null.
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
  })  : assert(
          itemExtent == null || prototypeItem == null,
          'You can only pass itemExtent or prototypeItem, not both.',
        ),
        childrenDelegate = SliverChildListDelegate(
          children
              .map((e) => Container(
                    color: Colors.grey,
                    padding: const EdgeInsets.all(20),
                    child: e,
                  ))
              .toList(),
          addAutomaticKeepAlives: addAutomaticKeepAlive,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
        ),
        super(
          semanticChildCount: semanticChildCount ?? children.length,
        );

  /// Creates a scrollable, linear array of widgets that are created on demand.
  ///
  /// This constructor is appropriate for list views with a large (or infinite)
  /// number of children because the builder is called only for those children
  /// that are actually visible.
  ///
  /// Providing a non-null `itemCount` improves the ability of the [ListView] to
  /// estimate the maximum scroll extent.
  ///
  /// The `itemBuilder` callback will be called only with indices greater than
  /// or equal to zero and less than `itemCount`.
  ///
  /// The `itemBuilder` should always return a non-null widget, and actually
  /// create the widget instances when called. Avoid using a builder that
  /// returns a previously-constructed widget; if the list view's children are
  /// created in advance, or all at once when the [ListView] itself is created,
  /// it is more efficient to use the [ListView] constructor. Even more
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
  })  : assert(itemCount == null || itemCount >= 0),
        assert(semanticChildCount == null || semanticChildCount <= itemCount!),
        assert(
          itemExtent == null || prototypeItem == null,
          'You can only pass itemExtent or prototypeItem, not both.',
        ),
        childrenDelegate = SliverChildBuilderDelegate(
          itemBuilder,
          findChildIndexCallback: findChildIndexCallback,
          childCount: itemCount,
          addAutomaticKeepAlives: addAutomaticKeepAlive,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
        ),
        super(
          semanticChildCount: semanticChildCount ?? itemCount,
        );

  /// Creates a fixed-length scrollable linear array of list "items" separated
  /// by list item "separators".
  ///
  /// This constructor is appropriate for list views with a large number of
  /// item and separator children because the builders are only called for
  /// the children that are actually visible.
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
  /// view's children are created in advance, or all at once when the [ListView]
  /// itself is created, it is more efficient to use the [ListView] constructor.
  ///
  /// {@macro flutter.widgets.PageView.findChildIndexCallback}
  ///
  /// {@tool snippet}
  ///
  /// This example shows how to create [ListView] whose [ListTile] list items
  /// are separated by [Divider]s.
  ///
  /// ```dart
  /// ListView.separated(
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

  /// Creates a scrollable, linear array of widgets with a custom child model.
  ///
  /// For example, a custom child model can control the algorithm used to
  /// estimate the size of children that are not actually visible.
  ///
  /// {@tool snippet}
  ///
  /// This [ListView] uses a custom [SliverChildBuilderDelegate] to support child
  /// reordering.
  ///
  /// ```dart
  /// class MyListView extends StatefulWidget {
  ///   const MyListView({super.key});
  ///
  ///   @override
  ///   State<MyListView> createState() => _MyListViewState();
  /// }
  ///
  /// class _MyListViewState extends State<MyListView> {
  ///   List<String> items = <String>['1', '2', '3', '4', '5'];
  ///
  ///   void _reverse() {
  ///     setState(() {
  ///       items = items.reversed.toList();
  ///     });
  ///   }
  ///
  ///   @override
  ///   Widget build(BuildContext context) {
  ///     return Scaffold(
  ///       body: SafeArea(
  ///         child: ListView.custom(
  ///           childrenDelegate: SliverChildBuilderDelegate(
  ///             (BuildContext context, int index) {
  ///               return KeepAlive(
  ///                 data: items[index],
  ///                 key: ValueKey<String>(items[index]),
  ///               );
  ///             },
  ///             childCount: items.length,
  ///             findChildIndexCallback: (Key key) {
  ///               final ValueKey<String> valueKey = key as ValueKey<String>;
  ///               final String data = valueKey.value;
  ///               return items.indexOf(data);
  ///             }
  ///           ),
  ///         ),
  ///       ),
  ///       bottomNavigationBar: BottomAppBar(
  ///         child: Row(
  ///           mainAxisAlignment: MainAxisAlignment.center,
  ///           children: <Widget>[
  ///             TextButton(
  ///               onPressed: () => _reverse(),
  ///               child: const Text('Reverse items'),
  ///             ),
  ///           ],
  ///         ),
  ///       ),
  ///     );
  ///   }
  /// }
  ///
  /// class KeepAlive extends StatefulWidget {
  ///   const KeepAlive({
  ///     required Key key,
  ///     required this.data,
  ///   }) : super(key: key);
  ///
  ///   final String data;
  ///
  ///   @override
  ///   State<KeepAlive> createState() => _KeepAliveState();
  /// }
  ///
  /// class _KeepAliveState extends State<KeepAlive> with AutomaticKeepAliveClientMixin{
  ///   @override
  ///   bool get wantKeepAlive => true;
  ///
  ///   @override
  ///   Widget build(BuildContext context) {
  ///     super.build(context);
  ///     return Text(widget.data);
  ///   }
  /// }
  /// ```
  /// {@end-tool}
  // const AnimatedListView.custom({
  //   super.key,
  //   super.scrollDirection,
  //   super.reverse,
  //   super.controller,
  //   super.primary,
  //   super.physics,
  //   super.shrinkWrap,
  //   super.padding,
  //   this.itemExtent,
  //   this.prototypeItem,
  //   required this.childrenDelegate,
  //   super.cacheExtent,
  //   super.semanticChildCount,
  //   super.dragStartBehavior,
  //   super.keyboardDismissBehavior,
  //   super.restorationId,
  //   super.clipBehavior,
  // }) : assert(
  //       itemExtent == null || prototypeItem == null,
  //       'You can only pass itemExtent or prototypeItem, not both',
  //       );

  /// {@template flutter.widgets.list_view.itemExtent}
  /// If non-null, forces the children to have the given extent in the scroll
  /// direction.
  ///
  /// Specifying an [itemExtent] is more efficient than letting the children
  /// determine their own extent because the scrolling machinery can make use of
  /// the foreknowledge of the children's extent to save work, for example when
  /// the scroll position changes drastically.
  ///
  /// See also:
  ///
  ///  * [SliverFixedExtentList], the sliver used internally when this property
  ///    is provided. It constrains its box children to have a specific given
  ///    extent along the main axis.
  ///  * The [prototypeItem] property, which allows forcing the children's
  ///    extent to be the same as the given widget.
  /// {@endtemplate}
  final double? itemExtent;

  /// {@template flutter.widgets.list_view.prototypeItem}
  /// If non-null, forces the children to have the same extent as the given
  /// widget in the scroll direction.
  ///
  /// Specifying an [prototypeItem] is more efficient than letting the children
  /// determine their own extent because the scrolling machinery can make use of
  /// the foreknowledge of the children's extent to save work, for example when
  /// the scroll position changes drastically.
  ///
  /// See also:
  ///
  ///  * [SliverPrototypeExtentList], the sliver used internally when this
  ///    property is provided. It constrains its box children to have the same
  ///    extent as a prototype item along the main axis.
  ///  * The [itemExtent] property, which allows forcing the children's extent
  ///    to a given value.
  /// {@endtemplate}
  final Widget? prototypeItem;

  /// A delegate that provides the children for the [ListView].
  ///
  /// The [ListView.custom] constructor lets you specify this delegate
  /// explicitly. The [ListView] and [ListView.builder] constructors create a
  /// [childrenDelegate] that wraps the given [List] and [IndexedWidgetBuilder],
  /// respectively.
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
