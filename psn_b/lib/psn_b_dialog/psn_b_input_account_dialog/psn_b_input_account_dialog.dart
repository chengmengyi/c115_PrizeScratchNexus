import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_dialog/psn_b_input_account_dialog/psn_b_input_account_dialog_con.dart';
import 'package:psn_b/psn_b_utils/psn_b_utils.dart';
import 'package:psn_b/psn_b_widget/psn_b_btn_widget.dart';
import 'package:psn_root/psn_root_page/psn_root_dialog.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_widget/psn_click.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';
import 'package:psn_root/psn_root_widget/psn_text_widget.dart';

class PsnBInputAccountDialog extends PsnRootDialog<PsnBInputAccountDialogCon>{
  String cashType;
  int cashMoney;
  Function(String account) inputCallback;

  PsnBInputAccountDialog({
    required this.cashType,
    required this.cashMoney,
    required this.inputCallback,
});

  @override
  PsnBInputAccountDialogCon onCon() => PsnBInputAccountDialogCon();

  @override
  Widget onCreate() => Container(
    width: double.infinity,
    height: 640.h,
    margin: EdgeInsets.only(left: 58.w,right: 58.w),
    child: Stack(
      children: [
        PsnImageWidget(name: "input1",width: double.infinity,height: double.infinity,),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 32.h),
            child: PsnTextWidget(text: "Cash Out", size: 48.sp, color: "#FFFFFF".toColor(),),
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
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 130.h,),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  PsnImageWidget(name: getCashDialogImages(cashType),width: 496.w,height: 237.h,),
                  Container(
                    margin: EdgeInsets.only(bottom: 50.h),
                    child: PsnTextWidget(text: "\$$cashMoney", size: 70.sp, color: "#252525".toColor(),),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: 68.h,
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 44.w,right: 44.w,top: 40.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.w),
                  color: "#DADFEB".toColor(),
                ),
                child: TextField(
                  enabled: true,
                  maxLength: 30,
                  textAlign: TextAlign.center,
                  controller: psnCon.editingController,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(
                    fontSize: 32.sp,
                    color: "#000000".toColor(),
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    counterText: '',
                    isCollapsed: true,
                    hintText: "Please enter your account ID",
                    hintStyle: TextStyle(
                      fontSize: 32.sp,
                      color: "#8E98AB".toColor(),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 29.h,),
              PsnBBtnWidget(
                text: "Submit",
                bgName: "btn_green",
                onTap: (){
                  psnCon.clickSubmit(cashType, cashMoney,inputCallback);
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}