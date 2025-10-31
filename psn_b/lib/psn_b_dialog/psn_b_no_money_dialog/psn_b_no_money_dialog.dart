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
    height: 245.h,
    margin: EdgeInsets.only(left: 29.w,right: 29.w),
    child: Stack(
      children: [
        PsnImageWidget(name: "no_money1",width: double.infinity,height: double.infinity,),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 16.h),
            child: PsnTextWidget(text: "NOT ENOUGH", size: 24.sp, color: "#FFFFFF".toColor(),),
          ),
        ),
        Positioned(
          top: 15.h,
          right: 15.w,
          child: PsnClick(
            onTap: (){
              psnCon.clickClose();
            },
            child: PsnImageWidget(name: "icon_close2",width: 20.w,height: 20.w,),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PsnTextWidget(text: "Now you can spin the wheel", size: 18.sp, color: "#535F75".toColor(),),
              SizedBox(height: 10.h,),
              PsnTextWidget(text: "or smash golden eggs to", size: 18.sp, color: "#535F75".toColor(),),
              SizedBox(height: 10.h,),
              PsnTextWidget(text: "earn extra  cash!", size: 18.sp, color: "#535F75".toColor(),),
              SizedBox(height: 30.h,),
              PsnClick(
                onTap: (){
                  psnCon.clickPlayNow();
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    PsnImageWidget(name: "no_money2",width: 229.w,height: 44.h,),
                    PsnTextWidget(text: "Play Now", size: 18.sp, color: "#FFFFFF".toColor(),outlineColor: "#0A361C".toColor(),)
                  ],
                ),
              ),
              SizedBox(height: 20.h,),
            ],
          ),
        ),
      ],
    ),
  );
}