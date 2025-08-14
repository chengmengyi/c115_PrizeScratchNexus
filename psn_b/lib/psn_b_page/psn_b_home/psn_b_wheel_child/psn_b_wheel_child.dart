import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_page/psn_b_home/psn_b_wheel_child/psn_b_wheel_child_con.dart';
import 'package:psn_root/psn_root_page/psn_root_child.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';
import 'package:psn_root/psn_root_widget/psn_text_widget.dart';

class PsnBWheelChild extends PsnRootChild<PsnBWheelChildCon>{
  @override
  PsnBWheelChildCon onCon() => PsnBWheelChildCon();

  @override
  Widget onCreate() => Column(
    children: [
      _topWidget(),
      SizedBox(height: 30.h,),
      _wheelWidget(),
    ],
  );

  _wheelWidget()=>Container(
    width: double.infinity,
    margin: EdgeInsets.only(left: 52.w,right: 52.w),
    child: AspectRatio(
      aspectRatio: 1,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PsnImageWidget(name: "wheel2",width: double.infinity,height: double.infinity,),
          Padding(
            padding: EdgeInsets.all(46.w),
            child: PsnImageWidget(name: "wheel3",width: double.infinity,height: double.infinity,),
          ),
          Stack(
            children: [
              PsnImageWidget(name: "wheel4",width: 163.w,height: 213.h,),

            ],
          ),
        ],
      ),
    ),
  );
  
  _topWidget()=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(height: 60.h,),
      PsnImageWidget(name: "wheel1",height: 90.h,boxFit: BoxFit.fitHeight,),
      SizedBox(height: 10.h,),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          PsnTextWidget(text: "Just ", size: 36.sp, color: "#F7FCFF".toColor(),outlineColor: "#000000".toColor(),),
          GetBuilder<PsnBWheelChildCon>(
            id: "top_text",
            builder: (_)=>PsnTextWidget(text: "${psnCon.getCashMoney()}", size: 36.sp, color: "#FFFA21".toColor(),outlineColor: "#000000".toColor()),
          ),
          PsnTextWidget(text: " to Pagbank withdrawal", size: 36.sp, color: "#F7FCFF".toColor(),outlineColor: "#000000".toColor()),
        ],
      ),
    ],
  );
}