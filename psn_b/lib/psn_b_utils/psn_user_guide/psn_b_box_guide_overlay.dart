import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_widget/psn_b_guide_text_widget.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_widget/psn_click.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';
import 'package:psn_root/psn_root_widget/psn_lottie_widget.dart';
import 'package:psn_root/psn_root_widget/psn_text_widget.dart';

class PsnBBoxGuideOverlay extends StatelessWidget{
  Offset offset;
  Function() dismissCallback;
  PsnBBoxGuideOverlay({
    required this.offset,
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
                width: 84.w,
                height: 70.h,
                child: Stack(
                  children: [
                    PsnImageWidget(name: "icon_box",width: double.infinity,height: double.infinity,),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 7.h),
                        child: PsnTextWidget(text: "Claim", size: 12.sp, color: "#FFFFFF".toColor()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: offset.dy+35.h,
              left: offset.dx+40.w,
              child: PsnLottieWidget(name: "finger",width: 50.w,height: 50.w,),
            ),
            Positioned(
              top: offset.dy+120.h,
              left: 0,
              right: 0,
              child: PsnBGuideTextWidget(text: "Free Chest – you’ll always win the big prize, right! "),
            ),
          ],
        ),
      ),
    ),
  );
}