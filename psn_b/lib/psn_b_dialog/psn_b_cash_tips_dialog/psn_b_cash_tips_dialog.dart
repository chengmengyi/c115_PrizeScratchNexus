import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_dialog/psn_b_cash_tips_dialog/psn_b_cash_tips_dialog_con.dart';
import 'package:psn_b/psn_b_utils/psn_b_utils.dart';
import 'package:psn_b/psn_b_widget/psn_b_btn_widget.dart';
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
  Widget onCreate() => Container(
    width: double.infinity,
    height: 343.h,
    margin: EdgeInsets.only(left: 29.w,right: 29.w,bottom: 41.h,),
    child: Stack(
      children: [
        PsnImageWidget(name: "cash_tip1",width: double.infinity,height: double.infinity,),
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
            margin: EdgeInsets.only(top: 16.h),
            child: PsnTextWidget(text: "Congratulations!", size: 24.sp, color: "#FFFFFF".toColor(),),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PsnTextWidget(text: "Account Reaches ", size: 18.sp, color: "#262D3A".toColor()),
                  PsnTextWidget(text: "\$${psnCon.getFirstMoney()}", size: 24.sp, color: "#1CB310".toColor()),
                ],
              ),
              SizedBox(height: 28.h,),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  PsnImageWidget(name: getCashDialogImages(psnCon.cashType),width: 248.w,height: 118.h,),
                  Container(
                    margin: EdgeInsets.only(bottom: 25.h),
                    child: PsnTextWidget(text: "\$${psnCon.getFirstMoney()}", size: 35.sp, color: "#252525".toColor(),),
                  ),
                ],
              ),
              SizedBox(height: 28.h,),
              PsnBBtnWidget(
                text: "Cash out",
                bgName: "btn_green",
                onTap: (){
                  psnCon.clickCon();
                },
              ),
              SizedBox(height: 20.h,),
            ],
          ),
        ),
      ],
    ),
  );
}