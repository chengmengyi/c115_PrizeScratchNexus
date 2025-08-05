import 'package:flutter/material.dart';
import 'package:psn_root/psn_root_page/psn_root_statefull.dart';

class PsnBreathingWidget extends PsnRootStateful {
  final Widget child;
  final bool startAnimator;
  final double minScale;
  final double maxScale;
  final Duration duration;

  PsnBreathingWidget({
    required this.child,
    required this.startAnimator,
    this.minScale = 1.0,
    this.maxScale = 1.2,
    this.duration = const Duration(milliseconds: 600),
  });

  @override
  State<PsnBreathingWidget> createState() => _BreathingWidgetState();
}

class _BreathingWidgetState extends PsnRootStatefulState<PsnBreathingWidget> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _animation = Tween<double>(
      begin: widget.minScale,
      end: widget.maxScale,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.startAnimator) {
        _controller.reset();
        _controller.repeat(reverse: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _animation,
    builder: (context, child) {
      return Transform.scale(
        scale: _animation.value,
        filterQuality: FilterQuality.high,
        child: child,
      );
    },
    child: widget.child,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}