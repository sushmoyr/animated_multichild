import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

typedef AnimatedChildBuilder = Widget Function(
    BuildContext context, int index, Animation<double> animation);

class AnimatedListView extends StatefulWidget {
  const AnimatedListView({
    Key? key,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
    this.primary,
    this.physics,
    this.padding,
    this.itemExtent,
    this.prototypeItem,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    required this.children,
    this.semanticChildCount,
    this.dragStartBehaviour = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
  }) : super(key: key);

  final Axis scrollDirection;
  final bool reverse;
  final ScrollController? controller;
  final bool? primary;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;
  final double? itemExtent;
  final Widget? prototypeItem;
  final bool? addAutomaticKeepAlives;
  final bool? addRepaintBoundaries;
  final bool? addSemanticIndexes;
  final double? cacheExtent;
  final List<Widget> children;
  final int? semanticChildCount;
  final DragStartBehavior dragStartBehaviour;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final String? restorationId;
  final Clip clipBehavior;

  @override
  State<AnimatedListView> createState() => _AnimatedListViewState();
}

class _AnimatedListViewState extends State<AnimatedListView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      key: widget.key,
      scrollDirection: widget.scrollDirection,
      reverse: widget.reverse,
      controller: widget.controller,
      primary: widget.primary,
      physics: widget.physics,
      padding: widget.padding,
      itemExtent: widget.itemExtent,
      prototypeItem: widget.prototypeItem,
      addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
      addRepaintBoundaries: widget.addRepaintBoundaries,
      addSemanticIndexes: widget.addSemanticIndexes,
      cacheExtent: widget.cacheExtent,
      semanticChildCount: widget.semanticChildCount,
      dragStartBehavior: widget.dragStartBehaviour,
      keyboardDismissBehavior: widget.keyboardDismissBehavior,
      restorationId: widget.restorationId,
      clipBehavior: widget.clipBehavior,
      children: widget.children,
    );
  }
}
