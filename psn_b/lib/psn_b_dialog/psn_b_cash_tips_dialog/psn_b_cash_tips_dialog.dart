import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_dialog/psn_b_cash_tips_dialog/psn_b_cash_tips_dialog_con.dart';
import 'package:psn_b/psn_b_utils/psn_b_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_dialog.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_widget/psn_click.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';
import 'package:psn_root/psn_root_widget/psn_text_widget.dart';

class PsnBCashTipsDialog extends PsnRootDialog<PsnBCashTipsDialogCon>{

  @override
  PsnBCashTipsDialogCon onCon() => PsnBCashTipsDialogCon();

  @override
  Widget onCreate() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      PsnTextWidget(text: "Congratulations!", size: 21.sp, color: "#FFFFFF".toColor(),),
      SizedBox(height: 10.h,),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          PsnTextWidget(text: "Account Reaches ", size: 15.sp, color: "#FFFFFF".toColor()),
          PsnTextWidget(text: "\$${psnCon.getFirstMoney()}", size: 15.sp, color: "#3DF329".toColor()),
        ],
      ),
      SizedBox(height: 35.h,),
      Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PsnImageWidget(name: getCashDialogImages(psnCon.cashType),width: 154.w,height: 82.h,),
          Container(
            margin: EdgeInsets.only(bottom: 25.h),
            child: PsnTextWidget(text: "\$${psnCon.getFirstMoney()}", size: 25.sp, color: "#252525".toColor(),),
          ),
        ],
      ),
      SizedBox(height: 50.h,),
      PsnClick(
        onTap: (){
          psnCon.clickCon();
        },
        child: Container(
          width: 200.w,
          height: 48.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: "#356ECA".toColor(),
            borderRadius: BorderRadius.circular(12.w),
          ),
          child: PsnTextWidget(text: "Cash Out", size: 16.sp, color: "#FFFFFF".toColor(),),
        ),
      )
    ],
  );
}