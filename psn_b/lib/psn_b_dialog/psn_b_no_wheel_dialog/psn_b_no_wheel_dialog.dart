import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_dialog/psn_b_no_wheel_dialog/psn_b_no_wheel_dialog_con.dart';
import 'package:psn_b/psn_b_widget/psn_b_btn_widget.dart';
import 'package:psn_root/psn_root_page/psn_root_dialog.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_widget/psn_click.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';
import 'package:psn_root/psn_root_widget/psn_text_widget.dart';

class PsnBNoWheelDialog extends PsnRootDialog<PsnBNoWheelDialogCon>{
  @override
  PsnBNoWheelDialogCon onCon() => PsnBNoWheelDialogCon();

  @override
  Widget onCreate() => Stack(
    children: [
      Container(
        width: double.infinity,
        height: 324.h,
        margin: EdgeInsets.only(left: 20.w,right: 20.w,top: 6.h),
        child: Stack(
          alignment: Alignment.center,
          children: [
            PsnImageWidget(name: "no_money3",width: double.infinity,height: double.infinity,),
            _contentWidget(),
          ],
        ),
      ),
      Positioned(
        right: 14.w,
        child: PsnClick(
          onTap: (){
            psnCon.clickClose();
          },
          child: PsnImageWidget(name: "icon_close",width: 32.w,height: 32.w,),
        ),
      ),
    ],
  );

  _contentWidget()=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      PsnTextWidget(
        text: "No More Chances",
        size: 24.sp,
        color: "#FFFFFF".toColor(),
        outlineColor: "#0D165B".toColor(),
        fontFamily: null,
        fontWeight: FontWeight.w900,
      ),
      SizedBox(height: 16.h,),
      PsnTextWidget(
        text: "You can get more chances by\nscratch cards",
        size: 16.sp,
        color: "#E5F9F9".toColor(),
        fontFamily: null,
        fontWeight: FontWeight.bold,
        textAlign: TextAlign.center,
      ),
      SizedBox(height: 16.h,),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PsnImageWidget(name: "no_money4",width: 82.w,height: 82.w,),
              SizedBox(height: 10.h,),
              PsnTextWidget(text: "X 3", size: 18.sp, color: "#FFD52C".toColor(),outlineColor: "#000000".toColor(),fontWeight: FontWeight.bold,),
            ],
          ),
          SizedBox(width: 12.w,),
          PsnImageWidget(name: "no_money5",width: 26.w,height: 16.h,),
          SizedBox(width: 12.w,),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PsnImageWidget(name: "no_money4",width: 82.w,height: 82.w,),
              SizedBox(height: 10.h,),
              PsnTextWidget(text: "X 1", size: 18.sp, color: "#FFD52C".toColor(),outlineColor: "#000000".toColor(),fontWeight: FontWeight.bold,),
            ],
          ),
        ],
      ),
      SizedBox(height: 40.h,),
      PsnBBtnWidget(
        text: "GO",
        bgName: "btn_green",
        onTap: (){
          psnCon.clickPlayNow();
        },
      ),
    ],
  );
}