import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_widget/psn_b_guide_text_widget.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_widget/psn_click.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';
import 'package:psn_root/psn_root_widget/psn_lottie_widget.dart';
import 'package:psn_root/psn_root_widget/psn_text_widget.dart';

import '../../psn_b_storage/psn_b_storage.dart';

class PsnBGuide4Overlay extends StatelessWidget{
  Offset offset;
  Size size;
  Function() dismissCallback;
  PsnBGuide4Overlay({
    required this.offset,
    required this.size,
    required this.dismissCallback,
});

  @override
  Widget build(BuildContext context) => Material(
    type: MaterialType.transparency,
    child: PsnClick(
      fromGuide: true,
      onTap: (){
        dismissCallback.call();
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black.withOpacity(0.7),
        child: Stack(
          children: [
            Positioned(
              top: offset.dy,
              left: offset.dx,
              child: SizedBox(
                width: size.width,
                height: size.height,
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 32.h,
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(left: 35.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.w),
                        color: "#2B2F51".toColor(),
                        border: Border.all(
                          width: 1.w,
                          color: "#000000".toColor(),
                        ),
                      ),
                      child: PsnTextWidget(text: "\$${bUserCoins.getData()}", size: 14.sp, color: "#FFFFFF".toColor(),outlineColor: "#2B1E55".toColor(),),
                    ),
                    PsnImageWidget(name: "icon_money",width: 42.w,height: 42.w,),
                  ],
                ),
              ),
            ),
            Positioned(
              top: offset.dy+25.h,
              left: offset.dx+85.w,
              child: PsnLottieWidget(name: "finger",width: 50.w,height: 50.w,),
            ),
            Positioned(
              top: offset.dy+100.h,
              left: 0,
              right: 0,
              child: PsnBGuideTextWidget(text: "Keep stacking! Your first \$1000 is waiting to cash out!"),
            ),
          ],
        ),
      ),
    ),
  );
}