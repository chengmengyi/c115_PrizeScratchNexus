import 'package:c115/psn_launch/psn_launch_con.dart';
import 'package:flutter/material.dart';
import 'package:psn_root/psn_root_page/psn_root_page.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_widget/psn_gradient_text.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';
import 'package:psn_root/psn_root_widget/psn_text_widget.dart';

class PsnLaunchPage extends PsnRootPage<PsnLaunchCon>{

  @override
  String bgName() => "launch1";

  @override
  PsnLaunchCon onCon() => PsnLaunchCon();

  @override
  Widget onCreate() => WillPopScope(
    child: Column(
      children: [
        SizedBox(height: 140.h,),
        _logoWidget(),
        Spacer(),
        _progressWidget(),
      ],
    ),
    onWillPop: ()async{
      return false;
    },
  );

  _progressWidget()=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      GetBuilder<PsnLaunchCon>(
        id: "pro_text",
        builder: (_)=>PsnTextWidget(text: "LOADING...${(psnCon.progressAnimationController.value*100).toInt()}%", size: 15.sp, color: "#FFFFFF".toColor(),outlineColor: "#1D2525".toColor(),),
      ),
      SizedBox(height: 10.h,),
      Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 18.w,right: 18.w),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            PsnImageWidget(name: "launch2",width: double.infinity,height: 24.h,),
            Container(
              margin: EdgeInsets.only(left: 2.w,right: 2.w),
              child: GetBuilder<PsnLaunchCon>(
                id: "pro",
                builder: (_)=>ClipRRect(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    widthFactor: psnCon.progressAnimationController.value,
                    child: PsnImageWidget(name: "launch3",width: double.infinity,height: 18.h,),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      SizedBox(height: 10.h,),
      PsnTextWidget(text: "Top winners are waiting for you...   ", size: 14.sp, color: "#FFFFFF".toColor(),outlineColor: "#1D2525".toColor(),),
      SizedBox(height: 170.h,),
    ],
  );

  _logoWidget()=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      PsnImageWidget(name: "logo",width: 128.w,height: 128.w,),
      SizedBox(height: 18.h,),
      PsnGradientText(
        data: "Prize Scratch Nexus",
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: ["#FFEF00".toColor(),"#FFFFFF".toColor()],
        ),
        size: 24.sp,
      ),
    ],
  );
}