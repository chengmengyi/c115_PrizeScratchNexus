import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_bean/psn_cash_task_bean.dart';
import 'package:psn_b/psn_b_dialog/psn_b_cash_success_dialog/psn_b_cash_success_dialog_con.dart';
import 'package:psn_root/psn_root_page/psn_root_dialog.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_widget/psn_click.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';
import 'package:psn_root/psn_root_widget/psn_text_widget.dart';

class PsnBCashSuccessDialog extends PsnRootDialog<PsnBCashSuccessDialogCon>{
  PsnCashTaskBean? cashTaskBean;
  Function() callback;
  PsnBCashSuccessDialog({
    required this.cashTaskBean,
    required this.callback,
});

  @override
  PsnBCashSuccessDialogCon onCon() => PsnBCashSuccessDialogCon();

  @override
  Widget onCreate() => Container(
    width: double.infinity,
    margin: EdgeInsets.only(left: 49.w,right: 49.w),
    decoration: BoxDecoration(
      color: "#FFFFFF".toColor(),
      borderRadius: BorderRadius.circular(15.w),
    ),
    child: Stack(
      alignment: Alignment.topCenter,
      children: [
        _contentWidget(),
        Positioned(
          top: 10.h,
          right: 10.w,
          child: PsnClick(
            onTap: (){
              psnCon.clickSure(cashTaskBean,callback);
            },
            child: PsnImageWidget(name: "icon_close3",width: 25.w,height: 25.w,),
          ),
        ),
      ],
    ),
  );

  _contentWidget()=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(height: 17.h,),
      PsnTextWidget(text: "Congratulations!", size: 13.sp, color: "#000000".toColor()),
      PsnImageWidget(name: "success2",width: 162.w,height: 162.h,),
      Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 15.w,right: 15.w),
        child: PsnTextWidget(
          text: "Congratulations! Your withdrawal request has been successful",
          size: 15.sp,
          color: "#000000".toColor(),
          textAlign: TextAlign.center,
          fontFamily: null,
        ),
      ),
      SizedBox(height: 17.h,),
      PsnClick(
        onTap: (){
          psnCon.clickSure(cashTaskBean,callback);
        },
        child: Container(
          width: double.infinity,
          height: 47.h,
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 37.w,right: 37.w),
          decoration: BoxDecoration(
            color: "#356ECA".toColor(),
            borderRadius: BorderRadius.circular(12.w),
          ),
          child: PsnTextWidget(text: "Confirm", size: 16.sp, color: "#FFFFFF".toColor(),),
        ),
      ),
      SizedBox(height: 20.h,),
    ],
  );
}