import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_dialog/psn_b_no_money_dialog/psn_b_no_money_dialog_con.dart';
import 'package:psn_root/psn_root_page/psn_root_dialog.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_widget/psn_click.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';
import 'package:psn_root/psn_root_widget/psn_text_widget.dart';

class PsnBNoMoneyDialog extends PsnRootDialog<PsnBNoMoneyDialogCon>{
  @override
  PsnBNoMoneyDialogCon onCon() => PsnBNoMoneyDialogCon();

  @override
  Widget onCreate() => Container(
    width: double.infinity,
    height: 490.h,
    margin: EdgeInsets.only(left: 58.w,right: 58.w),
    child: Stack(
      children: [
        PsnImageWidget(name: "no_money1",width: double.infinity,height: double.infinity,),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 32.h),
            child: PsnTextWidget(text: "NOT ENOUGH", size: 48.sp, color: "#FFFFFF".toColor(),),
          ),
        ),
        Positioned(
          top: 29.h,
          right: 29.w,
          child: PsnClick(
            onTap: (){
              psnCon.clickClose();
            },
            child: PsnImageWidget(name: "icon_close2",width: 40.w,height: 40.w,),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PsnTextWidget(text: "Now you can spin the wheel", size: 36.sp, color: "#535F75".toColor(),),
              SizedBox(height: 20.h,),
              PsnTextWidget(text: "or smash golden eggs to", size: 36.sp, color: "#535F75".toColor(),),
              SizedBox(height: 20.h,),
              PsnTextWidget(text: "earn extra  cash!", size: 36.sp, color: "#535F75".toColor(),),
              SizedBox(height: 60.h,),
              PsnClick(
                onTap: (){
                  psnCon.clickPlayNow();
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    PsnImageWidget(name: "no_money2",width: 458.w,height: 88.h,),
                    PsnTextWidget(text: "Play Now", size: 36.sp, color: "#FFFFFF".toColor(),outlineColor: "#0A361C".toColor(),)
                  ],
                ),
              ),
              SizedBox(height: 40.h,),
            ],
          ),
        ),
      ],
    ),
  );
}