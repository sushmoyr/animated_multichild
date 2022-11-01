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
      _AnimationStopperProvider.of(context)?.shouldRunAnimation ?? true;
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
    return _AnimationStopperProvider(
      shouldRunAnimation: !_stopAnimation,
      child: widget.child,
    );
  }
}

class _AnimationStopperProvider extends InheritedWidget {
  final bool shouldRunAnimation;

  const _AnimationStopperProvider({
    required this.shouldRunAnimation,
    required super.child,
  });

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }

  static _AnimationStopperProvider? of(BuildContext context) {
    return context.findAncestorWidgetOfExactType<_AnimationStopperProvider>();
  }
}
