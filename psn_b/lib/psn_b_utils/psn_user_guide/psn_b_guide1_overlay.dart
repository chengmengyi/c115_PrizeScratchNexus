import 'package:flutter/material.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_widget/psn_click.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';
import 'package:psn_root/psn_root_widget/psn_lottie_widget.dart';

class PsnBGuide1Overlay extends StatelessWidget{
  Offset offset;
  Function() clickCallback;
  PsnBGuide1Overlay({
    required this.offset,
    required this.clickCallback,
});

  @override
  Widget build(BuildContext context) => Material(
    type: MaterialType.transparency,
    child: PsnClick(
      onTap: (){
        clickCallback.call();
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
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  PsnImageWidget(name: "home2",width: 357.w,height: 107.h,),
                  Container(
                    margin: EdgeInsets.only(top: 26.h),
                    child: PsnImageWidget(name: "home3",width: 191.w,height: 40.h,),
                  ),
                ],
              ),
            ),
            Positioned(
              top: offset.dy+50.h,
              left: offset.dx+170.w,
              child: PsnLottieWidget(name: "finger",width: 100.w,height: 100.w,),
            )
          ],
        ),
      ),
    ),
  );
}