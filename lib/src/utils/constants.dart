import 'package:flutter/material.dart';

Widget defaultTransitionBuilder(
    BuildContext context, Animation<double> animation, Widget child) {
  return FadeTransition(
    opacity: animation,
    child: child,
  );
}
