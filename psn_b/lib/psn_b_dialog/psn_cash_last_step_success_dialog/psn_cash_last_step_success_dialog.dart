import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_bean/psn_rank_bean.dart';
import 'package:psn_b/psn_b_dialog/psn_cash_last_step_success_dialog/psn_cash_last_step_success_dialog_con.dart';
import 'package:psn_root/psn_root_page/psn_root_dialog.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_widget/psn_click.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';
import 'package:psn_root/psn_root_widget/psn_text_widget.dart';

class PsnCashLastStepSuccessDialog extends PsnRootDialog<PsnCashLastStepSuccessDialogCon>{
  PsnRankBean rankBean;
  PsnCashLastStepSuccessDialog({required this.rankBean});

  @override
  PsnCashLastStepSuccessDialogCon onCon() => PsnCashLastStepSuccessDialogCon();

  @override
  Widget onCreate() => Container(
    width: double.infinity,
    margin: EdgeInsets.only(left: 98.w,right: 98.w),
    decoration: BoxDecoration(
      color: "#FFFFFF".toColor(),
      borderRadius: BorderRadius.circular(30.w),
    ),
    child: Stack(
      alignment: Alignment.topCenter,
      children: [
        _contentWidget(),
        Positioned(
          top: 20.h,
          right: 20.w,
          child: PsnClick(
            onTap: (){
              psnCon.clickSure(rankBean);
            },
            child: PsnImageWidget(name: "icon_close3",width: 50.w,height: 50.w,),
          ),
        ),
      ],
    ),
  );

  _contentWidget()=>Container(
    margin: EdgeInsets.only(left: 35.w,right: 35.w),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 35.h,),
        PsnTextWidget(text: "Funds received", size: 38.sp, color: "#000000".toColor(),fontFamily: null,),
        SizedBox(height: 50.h,),
        _progressWidget(),
        PsnTextWidget(text: "We have completed the payment.And the funds will be creadited to your bank account within 7 business days.", size: 30.sp, color: "#000000".toColor(),fontFamily: null,),
        SizedBox(height: 40.h,),
        PsnClick(
          onTap: (){
            psnCon.clickSure(rankBean);
          },
          child: Container(
            width: double.infinity,
            height: 96.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: "#356ECA".toColor(),
              borderRadius: BorderRadius.circular(25.w),
            ),
            child: PsnTextWidget(text: "Instantly Credited", size: 33.sp, color: "#FFFFFF".toColor(),fontFamily: null,),
          ),
        ),
        SizedBox(height: 40.h,),
      ],
    ),
  );

  _progressWidget()=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(
        width: double.infinity,
        height: 28.w,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              width: double.infinity,
              height: 14.h,
              color: "#00C220".toColor(),
              margin: EdgeInsets.only(left: 14.w,right: 14.w),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 28.w,
                height: 28.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.w),
                  color: "#EFEFEF".toColor(),
                ),
                child: Container(
                  width: 18.w,
                  height: 18.w,
                  decoration: BoxDecoration(
                    color: "#00C220".toColor(),
                    borderRadius: BorderRadius.circular(9.w),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 28.w,
                height: 28.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.w),
                  color: "#EFEFEF".toColor(),
                ),
                child: Container(
                  width: 18.w,
                  height: 18.w,
                  decoration: BoxDecoration(
                    color: "#00C220".toColor(),
                    borderRadius: BorderRadius.circular(9.w),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 28.w,
                height: 28.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.w),
                  color: "#EFEFEF".toColor(),
                ),
                child: Container(
                  width: 18.w,
                  height: 18.w,
                  decoration: BoxDecoration(
                    color: "#00C220".toColor(),
                    borderRadius: BorderRadius.circular(9.w),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        width: double.infinity,
        height: 100.h,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: PsnTextWidget(text: "Request", size: 25.sp, color: "#067000".toColor()),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: PsnTextWidget(text: "Review", size: 25.sp, color: "#067000".toColor()),
            ),
            Align(
              alignment: Alignment.topRight,
              child: PsnTextWidget(text: "Funds\nreceived", size: 25.sp, color: "#067000".toColor(),textAlign: TextAlign.end,),
            ),
          ],
        ),
      ),
    ],
  );
}