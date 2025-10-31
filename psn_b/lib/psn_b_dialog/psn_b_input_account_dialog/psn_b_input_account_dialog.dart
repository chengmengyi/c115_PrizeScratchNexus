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
    height: 320.h,
    margin: EdgeInsets.only(left: 29.w,right: 29.w),
    child: Stack(
      children: [
        PsnImageWidget(name: "input1",width: double.infinity,height: double.infinity,),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 16.h),
            child: PsnTextWidget(text: "Cash Out", size: 24.sp, color: "#FFFFFF".toColor(),),
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
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 65.h,),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  PsnImageWidget(name: getCashDialogImages(cashType),width: 248.w,height: 118.h,),
                  Container(
                    margin: EdgeInsets.only(bottom: 25.h),
                    child: PsnTextWidget(text: "\$$cashMoney", size: 35.sp, color: "#252525".toColor(),),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: 34.h,
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 22.w,right: 22.w,top: 20.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.w),
                  color: "#DADFEB".toColor(),
                ),
                child: TextField(
                  enabled: true,
                  maxLength: 30,
                  textAlign: TextAlign.center,
                  controller: psnCon.editingController,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: "#000000".toColor(),
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    counterText: '',
                    isCollapsed: true,
                    hintText: "Please enter your account ID",
                    hintStyle: TextStyle(
                      fontSize: 16.sp,
                      color: "#8E98AB".toColor(),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 15.h,),
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