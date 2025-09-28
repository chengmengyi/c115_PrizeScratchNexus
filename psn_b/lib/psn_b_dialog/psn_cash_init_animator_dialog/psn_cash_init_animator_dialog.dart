import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_dialog/psn_cash_init_animator_dialog/psn_cash_init_animator_dialog_con.dart';
import 'package:psn_b/psn_b_utils/psn_b_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_dialog.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_widget/psn_click.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';
import 'package:psn_root/psn_root_widget/psn_text_widget.dart';

class PsnCashInitAnimatorDialog extends PsnRootDialog<PsnCashInitAnimatorDialogCon>{
  String cashType;
  int cashMoney;
  Function() clickCallback;
  PsnCashInitAnimatorDialog({
    required this.cashType,
    required this.cashMoney,
    required this.clickCallback,
});
  @override
  PsnCashInitAnimatorDialogCon onCon() => PsnCashInitAnimatorDialogCon();

  @override
  Widget onCreate() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      PsnTextWidget(text: "Processing payment", size: 46.sp, color: "#FFFFFF".toColor()),
      SizedBox(height: 120.h,),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              PsnImageWidget(name: getCashDialogImages(cashType),width: 220.w,height: 120.h,),
              Container(
                margin: EdgeInsets.only(bottom: 12.h),
                child: PsnTextWidget(text: "\$$cashMoney", size: 38.sp, color: "#252525".toColor(),),
              ),
            ],
          ),
          GetBuilder<PsnCashInitAnimatorDialogCon>(
            id: "icon",
            builder: (_){
              if(psnCon.showFail){
                return Container(
                  width: 160.w,
                  height: 110.w,
                  alignment: Alignment.center,
                  child: PsnImageWidget(name: "cash4",width: 68.w,height: 68.w,),
                );
              }
              return Container(
                width: 160.w,
                height: 110.w,
                alignment: Alignment.centerLeft,
                child: AnimatedBuilder(
                  animation: psnCon.animation,
                  builder: (_, child) {
                    return Transform.translate(
                      offset: Offset(psnCon.animation.value, 0),
                      child: child,
                    );
                  },
                  child: PsnImageWidget(name: "cash2",width: 110.w,height: 110.w,),
                ),
              );
            },
          ),
          PsnImageWidget(name: "cash3",width: 208.w,height: 208.w,),
        ],
      ),
      SizedBox(height: 60.h,),
      GetBuilder<PsnCashInitAnimatorDialogCon>(
        id: "text",
        builder: (_)=>Visibility(
          visible: psnCon.showFail,
          child: Container(
            margin: EdgeInsets.only(left: 66.w,right: 66.w),
            child: PsnTextWidget(
              text: "The bank requires you to verify that you are not a robot",
              size: 32.sp,
              color: "#FFFFFF".toColor(),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      SizedBox(height: 60.h,),
      GetBuilder<PsnCashInitAnimatorDialogCon>(
        id: "btn",
        builder: (_)=>Visibility(
          visible: psnCon.showFail,
          child:  PsnClick(
            onTap: (){
              psnCon.clickConfirm(clickCallback);
            },
            child: Container(
              width: 400.w,
              height: 96.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: "#356ECA".toColor(),
                borderRadius: BorderRadius.circular(25.w),
              ),
              child: PsnTextWidget(text: "Confirm", size: 33.sp, color: "#FFFFFF".toColor(),),
            ),
          ),
        ),
      ),
    ],
  );
}