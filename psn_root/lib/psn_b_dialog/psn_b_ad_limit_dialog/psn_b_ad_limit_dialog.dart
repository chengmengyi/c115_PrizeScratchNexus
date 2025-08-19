import 'package:flutter/material.dart';
import 'package:psn_root/psn_b_dialog/psn_b_ad_limit_dialog/psn_b_ad_limit_dialog_con.dart';
import 'package:psn_root/psn_root_page/psn_root_dialog.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_widget/psn_click.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';
import 'package:psn_root/psn_root_widget/psn_text_widget.dart';

class PsnBAdLimitDialog extends PsnRootDialog<PsnBAdLimitDialogCon>{

  @override
  PsnBAdLimitDialogCon onCon() => PsnBAdLimitDialogCon();

  @override
  Widget onCreate() => Container(
    width: double.infinity,
    height: 660.h,
    margin: EdgeInsets.only(left: 58.w,right: 58.w),
    child: Stack(
      children: [
        PsnImageWidget(name: "limit1",width: double.infinity,height: double.infinity,),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 32.h),
            child: PsnTextWidget(text: "Ad limit reached", size: 48.sp, color: "#FFFFFF".toColor(),),
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
              PsnImageWidget(name: "limit2",width: 245.w,height: 226.h,),
              SizedBox(height: 30.h,),
              Container(
                margin: EdgeInsets.only(left: 35.w,right: 35.w),
                child: PsnTextWidget(text: "You've watched all  available ads for today.Try again tomorrow.", size: 34.sp, color: "#535F75".toColor(),),
              ),
              SizedBox(height: 56.h,),
              PsnClick(
                onTap: (){
                  psnCon.clickClose();
                },
                child: SizedBox(
                  width: 297.w,
                  height: 107.h,
                  child: Stack(
                    children: [
                      PsnImageWidget(name: "btn_blue",width: double.infinity,height: double.infinity,),
                      Align(
                        alignment: Alignment.center,
                        child: PsnTextWidget(text: "Confirm", size: 42.sp, color: "#F2F3F3".toColor(),outlineColor: "#090733".toColor(),),
                      ),
                    ],
                  ),
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