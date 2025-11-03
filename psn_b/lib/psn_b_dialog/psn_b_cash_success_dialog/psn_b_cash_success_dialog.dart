import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_bean/psn_cash_task_bean.dart';
import 'package:psn_b/psn_b_dialog/psn_b_cash_success_dialog/psn_b_cash_success_dialog_con.dart';
import 'package:psn_b/psn_b_widget/psn_b_btn_widget.dart';
import 'package:psn_root/psn_root_page/psn_root_dialog.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_widget/psn_click.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';
import 'package:psn_root/psn_root_widget/psn_text_widget.dart';

class PsnBCashSuccessDialog extends PsnRootDialog<PsnBCashSuccessDialogCon>{
  Function() callback;
  PsnBCashSuccessDialog({
    required this.callback,
});

  @override
  PsnBCashSuccessDialogCon onCon() => PsnBCashSuccessDialogCon();

  @override
  Widget onCreate() => Container(
    width: double.infinity,
    height: 398.h,
    margin: EdgeInsets.only(left: 29.w,right: 29.w),
    child: Stack(
      children: [
        PsnImageWidget(name: "con1",width: double.infinity,height: double.infinity,),
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
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 14.h),
            child: PsnTextWidget(text: "Congratulations!", size: 24.sp, color: "#FFFFFF".toColor(),),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(left: 16.w,right: 16.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 41.h),
                      child: PsnImageWidget(name: "con2",width: double.infinity,height: 138.h,),
                    ),
                    PsnImageWidget(name: "con3",width: 82.w,height: 82.h,),
                  ],
                ),
                SizedBox(height: 4.h,),
                PsnTextWidget(
                  text: "Congratulations!Your withdrawal request has been successful",
                  size: 18.sp,
                  color: "#042E53".toColor(),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.h,),
                PsnBBtnWidget(
                  text: "Confirm",
                  bgName: "btn_green",
                  onTap: (){
                    psnCon.clickSure(callback);
                  },
                ),
                SizedBox(height: 16.h,),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}