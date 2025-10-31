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
    height: 490.h,
    margin: EdgeInsets.only(left: 29.w,right: 29.w),
    child: Stack(
      children: [
        PsnImageWidget(name: "pix",width: double.infinity,height: double.infinity,),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 16.h),
            child: PsnTextWidget(text: "Withdraw", size: 23.sp, color: "#FFFFFF".toColor(),),
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
              _cpfInputWidget(),
              _accountTypeWidget(),
              _nameInputWidget(),
              SizedBox(height: 25.h,),
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
    height: 34.h,
    alignment: Alignment.centerLeft,
    margin: EdgeInsets.only(left: 22.w,right: 22.w,top: 10.h),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(6.w),
      color: "#DADFEB".toColor(),
    ),
    child: Row(
      children: [
        SizedBox(width: 6.w,),
        PsnTextWidget(text: "CPF", size: 16.sp, color: "#535F75".toColor()),
        SizedBox(width: 6.w,),
        Expanded(
          child: TextField(
            enabled: true,
            maxLength: 30,
            textAlign: TextAlign.right,
            controller: psnCon.cpfEditingController,
            textInputAction: TextInputAction.done,
            style: TextStyle(
              fontSize: 16.sp,
              color: "#000000".toColor(),
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              counterText: '',
              isCollapsed: true,
              hintText: "e.g.99999999999999",
              hintStyle: TextStyle(
                fontSize: 16.sp,
                color: "#8E98AB".toColor(),
              ),
              border: InputBorder.none,
            ),
          ),
        ),
        SizedBox(width: 6.w,),
      ],
    ),
  );

  _accountTypeWidget()=>Container(
    width: double.infinity,
    height: 114.h,
    alignment: Alignment.centerLeft,
    padding: EdgeInsets.only(left: 9.w,right: 9.w),
    margin: EdgeInsets.only(left: 22.w,right: 22.w,top: 8.h),
    decoration: BoxDecoration(
      color: "#FFFFFF".toColor(),
      borderRadius: BorderRadius.circular(12.w),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PsnTextWidget(text: "Account Type", size: 16.sp, color: "#474A50".toColor(),),
        SizedBox(height: 10.h,),
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
                height: 22.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11.w),
                  color: psnCon.chooseAccountTypeIndex==index?"#FF8813".toColor():"#DADFEB".toColor(),
                ),
                child: PsnTextWidget(text: psnCon.accountTypeList[index], size: 16.sp, color: psnCon.chooseAccountTypeIndex==index?"#FFFFFF".toColor():"#474A50".toColor()),
              ),
            ),
          ),
        ),
        SizedBox(height: 10.h,),
        Container(
          width: double.infinity,
          height: 34.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.w),
            color: "#DADFEB".toColor(),
          ),
          child: TextField(
            enabled: true,
            maxLength: 30,
            textAlign: TextAlign.center,
            controller: psnCon.accountEditingController,
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
      ],
    ),
  );

  _nameInputWidget()=>Container(
    width: double.infinity,
    height: 34.h,
    alignment: Alignment.centerLeft,
    margin: EdgeInsets.only(left: 22.w,right: 22.w,top: 10.h),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(6.w),
      color: "#DADFEB".toColor(),
    ),
    child: Row(
      children: [
        SizedBox(width: 6.w,),
        PsnTextWidget(text: "Name", size: 16.sp, color: "#535F75".toColor()),
        SizedBox(width: 6.w,),
        Expanded(
          child: TextField(
            enabled: true,
            maxLength: 30,
            textAlign: TextAlign.right,
            controller: psnCon.nameEditingController,
            textInputAction: TextInputAction.done,
            style: TextStyle(
              fontSize: 16.sp,
              color: "#000000".toColor(),
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              counterText: '',
              isCollapsed: true,
              hintText: "Please enter your name",
              hintStyle: TextStyle(
                fontSize: 16.sp,
                color: "#8E98AB".toColor(),
              ),
              border: InputBorder.none,
            ),
          ),
        ),
        SizedBox(width: 6.w,),
      ],
    ),
  );
}