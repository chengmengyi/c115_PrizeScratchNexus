import 'dart:math';

import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_bean/psn_b_wheel_bean.dart';
import 'package:psn_b/psn_b_page/psn_b_home/psn_b_wheel_child/psn_b_wheel_child_con.dart';
import 'package:psn_b/psn_b_widget/psn_b_btn_widget.dart';
import 'package:psn_root/psn_root_page/psn_root_child.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_widget/psn_click.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';
import 'package:psn_root/psn_root_widget/psn_text_widget.dart';

class PsnBWheelChild extends PsnRootChild<PsnBWheelChildCon>{
  @override
  PsnBWheelChildCon onCon() => PsnBWheelChildCon();

  @override
  Widget onCreate() => Column(
    children: [
      _topWidget(),
      SizedBox(height: 15.h,),
      _wheelWidget(),
      SizedBox(height: 15.h,),
      PsnBBtnWidget(
        text: "Spin",
        bgName: "btn_green",
        onTap: (){
          psnCon.clickStart();
        },
      ),
    ],
  );

  _wheelWidget()=>Container(
    width: double.infinity,
    margin: EdgeInsets.only(left: 26.w,right: 26.w),
    child: LayoutBuilder(
      builder: (context,bc){
        var size = bc.maxWidth;
        final radius = (size / 2 - 15)*0.7;
        return AspectRatio(
          aspectRatio: 1,
          child: Stack(
            alignment: Alignment.center,
            children: [
              PsnImageWidget(name: "wheel2",width: double.infinity,height: double.infinity,),
              GetBuilder<PsnBWheelChildCon>(
                id: "wheel_list",
                builder: (_){
                  if(null==psnCon.wheelAnimation){
                    return Container();
                  }
                  return AnimatedBuilder(
                    animation: psnCon.wheelAnimation!,
                    builder: (context,child)=>Transform.rotate(
                      angle: psnCon.wheelAnimation!.value,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(23.w),
                            child: PsnImageWidget(name: "wheel3",width: double.infinity,height: double.infinity,),
                          ),
                          ...List.generate(
                            psnCon.wheelList.length,
                                (i) => _wheelItemWidget(
                              bean: psnCon.wheelList[i],
                              angleDeg: i * 45.0 - 90,
                              radius: radius,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
              PsnClick(
                onTap: (){
                  psnCon.clickStart();
                },
                child: Stack(
                  children: [
                    PsnImageWidget(name: "wheel4",width: 82.w,height: 106.h,),
                    Positioned(
                      top: 30.h,
                      right: 0,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          PsnImageWidget(name: "wheel5",width: 23.w,height: 23.w,),
                          GetBuilder<PsnBWheelChildCon>(
                            id: "wheel_num",
                            builder: (_)=>PsnTextWidget(text: "${psnCon.wheelNum}", size: 15.sp, color: "#FFFFFF".toColor(),),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    ),
  );

  Widget _wheelItemWidget({
    required PsnBWheelBean bean,
    required double angleDeg,
    required double radius,
  }) {
    final angleRad = angleDeg * pi / 180;
    final offset = Offset(
      radius * cos(angleRad),
      radius * sin(angleRad),
    );

    final textRotation = angleRad + pi / 2;

    return Transform.translate(
      offset: offset,
      child: Transform.rotate(
        angle: textRotation,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PsnImageWidget(name: "icon_money3",width: 47.w,height: 32.h,),
            PsnTextWidget(text: "\$${bean.reward}", size: 14.sp, color: "#FFD52C".toColor(),outlineColor: "#000000".toColor(),)
          ],
        ),
      ),
    );
  }
  
  _topWidget()=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(height: 30.h,),
      PsnImageWidget(name: "wheel1",height: 45.h,boxFit: BoxFit.fitHeight,),
      SizedBox(height: 5.h,),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          PsnTextWidget(text: "Just ", size: 18.sp, color: "#F7FCFF".toColor(),outlineColor: "#000000".toColor(),),
          GetBuilder<PsnBWheelChildCon>(
            id: "top_text",
            builder: (_)=>PsnTextWidget(text: "${psnCon.getCashMoney()}", size: 18.sp, color: "#FFFA21".toColor(),outlineColor: "#000000".toColor()),
          ),
          PsnTextWidget(text: " to withdrawal", size: 18.sp, color: "#F7FCFF".toColor(),outlineColor: "#000000".toColor()),
        ],
      ),
    ],
  );
}