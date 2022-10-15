import 'package:flutter/material.dart';

class AnimationLimiter extends StatefulWidget {
  const AnimationLimiter({Key? key, required this.child, this.limit = true})
      : super(key: key);

  final Widget child;
  final bool limit;

  @override
  State<AnimationLimiter> createState() => _AnimationLimiterState();

  static bool shouldRunAnimation(BuildContext context) =>
      _AnimationLimiterProvider.of(context)?.shouldRunAnimation ?? true;
}

class _AnimationLimiterState extends State<AnimationLimiter> {
  bool _limitAnimation = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      if (!mounted) return;
      setState(() {
        _limitAnimation = widget.limit;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _AnimationLimiterProvider(
      shouldRunAnimation: !_limitAnimation,
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
