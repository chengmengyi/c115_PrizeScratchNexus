import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_bean/psb_cash_list_bean.dart';
import 'package:psn_b/psn_b_dialog/psn_b_cash_task_dialog/psn_b_cash_task_dialog_con.dart';
import 'package:psn_b/psn_b_utils/psn_b_utils.dart';
import 'package:psn_b/psn_b_widget/psn_b_btn_widget.dart';
import 'package:psn_root/psn_root_page/psn_root_dialog.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_utils/psn_tba/psn_b_tba_utils.dart';
import 'package:psn_root/psn_root_utils/psn_tba_point_enum.dart';
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
  onStart() {
    PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.cash_task_pop,params: {"task_step":psnCon.getPopFrom(bean.cashTaskBean)});
  }

  @override
  Widget onCreate() => Container(
    width: double.infinity,
    height: 390.h,
    margin: EdgeInsets.only(left: 29.w,right: 29.w),
    child: Stack(
      children: [
        PsnImageWidget(name: "task1",width: double.infinity,height: double.infinity,),
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
                  PsnImageWidget(name: getCashDialogImages(bean.cashTaskBean?.cashType??""),width: 248.w,height: 118.h,),
                  Container(
                    margin: EdgeInsets.only(bottom: 25.h),
                    child: PsnTextWidget(text: "\$${bean.money}", size: 35.sp, color: "#252525".toColor(),),
                  ),
                ],
              ),
              SizedBox(height: 10.h,),
              PsnTextWidget(text: "Cash out as soon as you complete", size: 18.sp, color: "#535F75".toColor(),),
              SizedBox(height: 10.h,),
              PsnTextWidget(text: "the following tasks.", size: 18.sp, color: "#535F75".toColor(),),
              SizedBox(height: 15.h,),
              PsnTextWidget(text: psnCon.getCaskTaskStr(bean.cashTaskBean), size: 17.sp, color: "#252525".toColor(),),
              SizedBox(height: 10.h,),
              SizedBox(
                width: 171.w,
                height: 15.h,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 15.h,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 2.w,right: 2.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.w),
                        color: "#042E53".toColor(),
                      ),
                      child: ClipRRect(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          widthFactor: psnCon.getCashTaskPro(bean.cashTaskBean),
                          child: PsnImageWidget(name: "cash1",width: double.infinity,height: 10.h,),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25.h,),
              PsnBBtnWidget(
                text: "Cash out",
                bgName: "btn_green",
                onTap: (){
                  psnCon.clickCashOut(bean);
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}