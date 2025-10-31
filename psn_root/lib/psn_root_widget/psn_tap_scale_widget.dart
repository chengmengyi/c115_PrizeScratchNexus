import 'package:flutter/material.dart';

class PsnTapScaleWidget extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double scale;
  final Duration duration;
  final bool enable;

  const PsnTapScaleWidget({
    Key? key,
    required this.child,
    this.onTap,
    this.scale = 0.95,
    this.duration = const Duration(milliseconds: 100),
    this.enable = true,
  }) : super(key: key);

  @override
  State<PsnTapScaleWidget> createState() => _TapScaleWidgetState();
}

class _TapScaleWidgetState extends State<PsnTapScaleWidget> with SingleTickerProviderStateMixin {
  double _currentScale = 1.0;

  void _onTapDown(TapDownDetails details) {
    if (!widget.enable) return;
    setState(() => _currentScale = widget.scale);
  }

  void _onTapUp(TapUpDetails details) {
    if (!widget.enable) return;
    setState(() => _currentScale = 1.0);
  }

  void _onTapCancel() {
    if (!widget.enable) return;
    setState(() => _currentScale = 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      behavior: HitTestBehavior.translucent,
      child: AnimatedScale(
        scale: _currentScale,
        duration: widget.duration,
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}