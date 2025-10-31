import 'package:flutter/material.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'dart:math';

import 'package:psn_root/psn_root_widget/psn_lottie_widget.dart';

class PsnBGuakaAnimatorWidget extends StatefulWidget {

  @override
  State<PsnBGuakaAnimatorWidget> createState() => _PsnBGuakaAnimatorWidgetState();
}

class _PsnBGuakaAnimatorWidgetState extends State<PsnBGuakaAnimatorWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double stepDown = 50; // 每次往返下降的高度

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(top: 50.h),
      child: LayoutBuilder(
        builder: (context,bc){
          var width = bc.maxWidth-55.w;
          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final t = _controller.value;

              double x, y;

              if (t < 0.25) {
                // 第一段: 往右 (水平直线)
                final progress = t / 0.25;
                x = progress * width;
                y = 0;
              } else if (t < 0.5) {
                // 第二段: 往左 + 往下
                final progress = (t - 0.25) / 0.25;
                x = (1 - progress) * width;
                y = progress * stepDown;
              } else if (t < 0.75) {
                // 第三段: 往右 + 往下
                final progress = (t - 0.5) / 0.25;
                x = progress * width;
                y = stepDown + progress * stepDown;
              } else {
                // 第四段: 往左 + 往下
                final progress = (t - 0.75) / 0.25;
                x = (1 - progress) * width;
                y = stepDown * 2 + progress * stepDown;
              }

              return Transform.translate(
                offset: Offset(x, y),
                child: child!,
              );
            },
            child: PsnLottieWidget(name: "finger",width: 55.w,height: 55.w,),
          );
        },
      ),
    );
  }
}