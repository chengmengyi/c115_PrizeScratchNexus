import 'package:flutter/material.dart';
import 'package:psn_root/psn_b_dialog/psn_b_ad_fail_dialog/psn_b_ad_fail_dialog_con.dart';
import 'package:psn_root/psn_root_page/psn_root_dialog.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_widget/psn_click.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';
import 'package:psn_root/psn_root_widget/psn_text_widget.dart';

class PsnBAdFailDialog extends PsnRootDialog<PsnBAdFailDialogCon>{
  Function() clickTryCallback;
  PsnBAdFailDialog({required this.clickTryCallback});

  @override
  PsnBAdFailDialogCon onCon() => PsnBAdFailDialogCon();

  @override
  Widget onCreate() => Container(
    width: double.infinity,
    height: 330.h,
    margin: EdgeInsets.only(left: 29.w,right: 29.w),
    child: Stack(
      children: [
        PsnImageWidget(name: "ad_fail1",width: double.infinity,height: double.infinity,),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 16.h),
            child: PsnTextWidget(text: "Ad loading reached", size: 24.sp, color: "#FFFFFF".toColor(),),
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
              PsnImageWidget(name: "ad_fail2",width: 137.w,height: 137.h,),
              SizedBox(height: 28.h,),
              PsnClick(
                onTap: (){
                  psnCon.clickTry(clickTryCallback);
                },
                child: SizedBox(
                  width: 137.w,
                  height: 53.h,
                  child: Stack(
                    children: [
                      PsnImageWidget(name: "btn_blue",width: double.infinity,height: double.infinity,),
                      Align(
                        alignment: Alignment.center,
                        child: PsnTextWidget(text: "Try Again", size: 21.sp, color: "#F2F3F3".toColor(),outlineColor: "#090733".toColor(),),
                      ),
                    ],
                  ),
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