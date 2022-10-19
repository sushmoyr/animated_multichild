import 'package:flutter/material.dart';

class AnimationStopper extends StatefulWidget {
  const AnimationStopper(
      {Key? key, required this.child, this.stopAnimation = true})
      : super(key: key);

  final Widget child;
  final bool stopAnimation;

  @override
  State<AnimationStopper> createState() => _AnimationStopperState();

  static bool shouldRunAnimation(BuildContext context) =>
      _AnimationLimiterProvider.of(context)?.shouldRunAnimation ?? true;
}

class _AnimationStopperState extends State<AnimationStopper> {
  bool _stopAnimation = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      if (!mounted) return;
      setState(() {
        _stopAnimation = widget.stopAnimation;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _AnimationLimiterProvider(
      shouldRunAnimation: !_stopAnimation,
      child: widget.child,
    );
  }
}

class _AnimationLimiterProvider extends InheritedWidget {
  final bool shouldRunAnimation;

  const _AnimationLimiterProvider({
    required this.shouldRunAnimation,
    required super.child,
  });

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }

  static _AnimationLimiterProvider? of(BuildContext context) {
    return context.findAncestorWidgetOfExactType<_AnimationLimiterProvider>();
  }
}
