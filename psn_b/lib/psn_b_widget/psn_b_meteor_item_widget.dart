import 'dart:math';

import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_bean/psn_b_content_bean.dart';
import 'package:psn_root/psn_root_page/psn_root_statefull.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';

class PsnBMeteorItemWidget extends PsnRootStateful{
  PsnBContentBean bean;
  GlobalKey bottomLeftGlobalKey;
  PsnBMeteorItemWidget({
    Key? key,
    required this.bean,
    required this.bottomLeftGlobalKey,
}): super(key: key);
  @override
  State<StatefulWidget> createState() => _PsnBMeteorItemWidgetState();
}

class _PsnBMeteorItemWidgetState extends PsnRootStatefulState<PsnBMeteorItemWidget> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<Offset> _animation;

  Offset startOffset=Offset.zero;
  Offset endOffset=Offset.zero;

  @override
  void initState() {
    super.initState();
    _initAnimator();
  }

  @override
  Widget build(BuildContext context) {
    var angle = _calculateAngle();
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Stack(
          children: [
            Positioned(
              left: _animation.value.dx,
              top: _animation.value.dy,
              child: Transform.rotate(
                angle: angle,
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/meteor.png',
                  width: 80.w,
                  height: 80.w,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  double _calculateAngle() {
    final dx = endOffset.dx - startOffset.dx;
    final dy = endOffset.dy - startOffset.dy;
    return atan2(dy, dx);
  }

  _initAnimator(){
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 800))..forward();

    var startRenderBox = widget.bean.globalKey?.currentContext?.findRenderObject() as RenderBox;
    startOffset = startRenderBox.localToGlobal(Offset.zero);

    var endRenderBox = widget.bottomLeftGlobalKey.currentContext?.findRenderObject() as RenderBox;
    endOffset = endRenderBox.localToGlobal(Offset.zero);

    _animation = Tween<Offset>(
      begin: startOffset,
      end: endOffset,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}