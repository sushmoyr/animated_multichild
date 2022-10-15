import 'package:flutter/material.dart';

class Column extends Flex {
  Column({
    super.key,
    required super.direction,
    required List<Widget> children,
  }) : super(children: doSomethingWithChildren(children));
}

List<Widget> doSomethingWithChildren(List<Widget> children) => children;

class AnimatedColumn extends Column {
  AnimatedColumn(
      {super.key, required super.direction, required super.children});
}
