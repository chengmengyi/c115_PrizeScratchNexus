import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_dialog/psn_cash_init_animator_dialog/psn_cash_init_animator_dialog_con.dart';
import 'package:psn_b/psn_b_utils/psn_b_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_dialog.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';
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
  PsnCashInitAnimatorDialogCon onCon() => PsnCashInitAnimatorDialogCon(clickCallback);

  @override
  Widget onCreate() => Stack(
    alignment: Alignment.bottomCenter,
    children: [
      Container(
        width: double.infinity,
        height: 440.h,
        margin: EdgeInsets.only(left: 29.w,right: 29.w,bottom: 41.h,),
        child: Stack(
          children: [
            PsnImageWidget(name: "cash_init1",width: double.infinity,height: double.infinity,),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: 16.h),
                child: PsnTextWidget(text: "Processing payment", size: 24.sp, color: "#FFFFFF".toColor(),),
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
                        child: PsnTextWidget(text: "\$$cashMoney", size: 25.sp, color: "#252525".toColor(),),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    width: double.infinity,
                    height: 84.h,
                    child: AnimatedBuilder(
                      animation: psnCon.animation,
                      builder: (_, child) {
                        return Transform.translate(
                          offset: Offset(0, psnCon.animation.value),
                          child: child,
                        );
                      },
                      child: PsnImageWidget(name: "cash_init2",width: 37.w,height: 42.w,),
                    ),
                  ),
                  PsnImageWidget(name: "cash_init3",width: 190.w,height: 108.h,),
                ],
              ),
            ),
          ],
        ),
      ),
      PsnImageWidget(name: "cash_init4",width: 82.w,height: 82.w,),
    ],
  );
}