import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_dialog/psn_b_input_pix_account_dialog/psn_b_input_pix_account_dialog_con.dart';
import 'package:psn_b/psn_b_utils/psn_b_utils.dart';
import 'package:psn_b/psn_b_widget/psn_b_btn_widget.dart';
import 'package:psn_root/psn_root_page/psn_root_dialog.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_widget/psn_click.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';
import 'package:psn_root/psn_root_widget/psn_text_widget.dart';

class PsnBInputPixAccountDialog extends PsnRootDialog<PsnBInputPixAccountDialogCon>{
  String cashType;
  int cashMoney;
  Function(String account) inputCallback;

  PsnBInputPixAccountDialog({
    required this.cashType,
    required this.cashMoney,
    required this.inputCallback,
});

  @override
  PsnBInputPixAccountDialogCon onCon() => PsnBInputPixAccountDialogCon();

  @override
  Widget onCreate() => Container(
    width: double.infinity,
    height: 980.h,
    margin: EdgeInsets.only(left: 58.w,right: 58.w),
    child: Stack(
      children: [
        PsnImageWidget(name: "pix",width: double.infinity,height: double.infinity,),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 32.h),
            child: PsnTextWidget(text: "Withdraw", size: 48.sp, color: "#FFFFFF".toColor(),),
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
              _cpfInputWidget(),
              _accountTypeWidget(),
              _nameInputWidget(),
              SizedBox(height: 50.h,),
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

  _cpfInputWidget()=>Container(
    width: double.infinity,
    height: 68.h,
    alignment: Alignment.centerLeft,
    margin: EdgeInsets.only(left: 44.w,right: 44.w,top: 20.h),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.w),
      color: "#DADFEB".toColor(),
    ),
    child: Row(
      children: [
        SizedBox(width: 12.w,),
        PsnTextWidget(text: "CPF", size: 32.sp, color: "#535F75".toColor()),
        SizedBox(width: 12.w,),
        Expanded(
          child: TextField(
            enabled: true,
            maxLength: 30,
            textAlign: TextAlign.right,
            controller: psnCon.cpfEditingController,
            textInputAction: TextInputAction.done,
            style: TextStyle(
              fontSize: 32.sp,
              color: "#000000".toColor(),
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              counterText: '',
              isCollapsed: true,
              hintText: "e.g.99999999999999",
              hintStyle: TextStyle(
                fontSize: 32.sp,
                color: "#8E98AB".toColor(),
              ),
              border: InputBorder.none,
            ),
          ),
        ),
        SizedBox(width: 12.w,),
      ],
    ),
  );

  _accountTypeWidget()=>Container(
    width: double.infinity,
    height: 228.h,
    alignment: Alignment.centerLeft,
    padding: EdgeInsets.only(left: 18.w,right: 18.w),
    margin: EdgeInsets.only(left: 44.w,right: 44.w,top: 16.h),
    decoration: BoxDecoration(
      color: "#FFFFFF".toColor(),
      borderRadius: BorderRadius.circular(24.w),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PsnTextWidget(text: "Account Type", size: 32.sp, color: "#474A50".toColor(),),
        SizedBox(height: 20.h,),
        GetBuilder<PsnBInputPixAccountDialogCon>(
          id: "account_type",
          builder: (_)=>MasonryGridView.count(
            padding: const EdgeInsets.all(0),
            itemCount: psnCon.accountTypeList.length,
            shrinkWrap: true,
            crossAxisCount: 4,
            mainAxisSpacing: 0,
            crossAxisSpacing: 6.w,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context,index) => PsnClick(
              onTap: (){
                psnCon.clickAccountType(index);
              },
              child: Container(
                width: double.infinity,
                height: 44.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22.w),
                  color: psnCon.chooseAccountTypeIndex==index?"#FF8813".toColor():"#DADFEB".toColor(),
                ),
                child: PsnTextWidget(text: psnCon.accountTypeList[index], size: 32.sp, color: psnCon.chooseAccountTypeIndex==index?"#FFFFFF".toColor():"#474A50".toColor()),
              ),
            ),
          ),
        ),
        SizedBox(height: 20.h,),
        Container(
          width: double.infinity,
          height: 68.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.w),
            color: "#DADFEB".toColor(),
          ),
          child: TextField(
            enabled: true,
            maxLength: 30,
            textAlign: TextAlign.center,
            controller: psnCon.accountEditingController,
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
      ],
    ),
  );

  _nameInputWidget()=>Container(
    width: double.infinity,
    height: 68.h,
    alignment: Alignment.centerLeft,
    margin: EdgeInsets.only(left: 44.w,right: 44.w,top: 20.h),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.w),
      color: "#DADFEB".toColor(),
    ),
    child: Row(
      children: [
        SizedBox(width: 12.w,),
        PsnTextWidget(text: "Name", size: 32.sp, color: "#535F75".toColor()),
        SizedBox(width: 12.w,),
        Expanded(
          child: TextField(
            enabled: true,
            maxLength: 30,
            textAlign: TextAlign.right,
            controller: psnCon.nameEditingController,
            textInputAction: TextInputAction.done,
            style: TextStyle(
              fontSize: 32.sp,
              color: "#000000".toColor(),
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              counterText: '',
              isCollapsed: true,
              hintText: "Please enter your name",
              hintStyle: TextStyle(
                fontSize: 32.sp,
                color: "#8E98AB".toColor(),
              ),
              border: InputBorder.none,
            ),
          ),
        ),
        SizedBox(width: 12.w,),
      ],
    ),
  );
}