import 'dart:async';

import 'package:animated_multichild/src/configurations/animation_limiter.dart';
import 'package:flutter/material.dart';

class AnimationContainer extends StatefulWidget {
  const AnimationContainer({
    Key? key,
    required this.duration,
    required this.curve,
    required this.delay,
    required this.builder,
  }) : super(key: key);

  final Widget Function(BuildContext context, Animation<double> animation)
      builder;
  final Duration duration;
  final Curve curve;
  final Duration delay;

  @override
  State<AnimationContainer> createState() => _AnimationContainerState();
}

class _AnimationContainerState extends State<AnimationContainer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: widget.duration);

    bool shouldRunAnimation = AnimationStopper.shouldRunAnimation(context);

    // print(
    //     'Run animation of duration ${widget.duration} with delay: ${widget.delay}');

    if (shouldRunAnimation) {
      timer = Timer(widget.delay, _animationController.forward);
    } else {
      _animationController.value = 1;
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: _animatedChildBuilder,
    );
  }

  Widget _animatedChildBuilder(BuildContext context, Widget? child) {
    return widget.builder(context,
        CurvedAnimation(parent: _animationController, curve: widget.curve));
  }
}
