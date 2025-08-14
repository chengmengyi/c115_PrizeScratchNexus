import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_bean/psb_cash_list_bean.dart';
import 'package:psn_b/psn_b_dialog/psn_b_cash_task_dialog/psn_b_cash_task_dialog_con.dart';
import 'package:psn_b/psn_b_utils/psn_b_utils.dart';
import 'package:psn_b/psn_b_widget/psn_b_btn_widget.dart';
import 'package:psn_root/psn_root_page/psn_root_dialog.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_widget/psn_click.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';
import 'package:psn_root/psn_root_widget/psn_text_widget.dart';

class PsnBCashTaskDialog extends PsnRootDialog<PsnBCashTaskDialogCon>{
  PsbCashListBean bean;
  PsnBCashTaskDialog({
    required this.bean,
});

  @override
  PsnBCashTaskDialogCon onCon() => PsnBCashTaskDialogCon();

  @override
  Widget onCreate() => Container(
    width: double.infinity,
    height: 780.h,
    margin: EdgeInsets.only(left: 58.w,right: 58.w),
    child: Stack(
      children: [
        PsnImageWidget(name: "task1",width: double.infinity,height: double.infinity,),
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
                  PsnImageWidget(name: getCashDialogImages(bean.cashTaskBean?.cashType??""),width: 496.w,height: 237.h,),
                  Container(
                    margin: EdgeInsets.only(bottom: 50.h),
                    child: PsnTextWidget(text: "\$${bean.money}", size: 70.sp, color: "#252525".toColor(),),
                  ),
                ],
              ),
              SizedBox(height: 20.h,),
              PsnTextWidget(text: "Cash out as soon as you complete", size: 36.sp, color: "#535F75".toColor(),),
              SizedBox(height: 20.h,),
              PsnTextWidget(text: "the following tasks.", size: 36.sp, color: "#535F75".toColor(),),
              SizedBox(height: 29.h,),
              PsnTextWidget(text: psnCon.getCaskTaskStr(bean.cashTaskBean), size: 34.sp, color: "#252525".toColor(),),
              SizedBox(height: 20.h,),
              SizedBox(
                width: 342.w,
                height: 30.h,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 30.h,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 5.w,right: 5.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.w),
                        color: "#042E53".toColor(),
                      ),
                      child: ClipRRect(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          widthFactor: psnCon.getCashTaskPro(bean.cashTaskBean),
                          child: PsnImageWidget(name: "cash1",width: double.infinity,height: 20.h,),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50.h,),
              PsnBBtnWidget(
                text: "Cash out",
                bgName: "btn_green",
                onTap: (){
                  psnCon.clickCashOut();
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}