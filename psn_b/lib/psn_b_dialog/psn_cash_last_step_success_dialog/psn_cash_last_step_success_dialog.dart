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
    margin: EdgeInsets.only(left: 49.w,right: 49.w),
    decoration: BoxDecoration(
      color: "#FFFFFF".toColor(),
      borderRadius: BorderRadius.circular(15.w),
    ),
    child: Stack(
      alignment: Alignment.topCenter,
      children: [
        _contentWidget(),
        Positioned(
          top: 10.h,
          right: 10.w,
          child: PsnClick(
            onTap: (){
              psnCon.clickSure(rankBean);
            },
            child: PsnImageWidget(name: "icon_close3",width: 25.w,height: 25.w,),
          ),
        ),
      ],
    ),
  );

  _contentWidget()=>Container(
    margin: EdgeInsets.only(left: 17.w,right: 17.w),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 17.h,),
        PsnTextWidget(text: "Funds received", size: 19.sp, color: "#000000".toColor(),fontFamily: null,),
        SizedBox(height: 25.h,),
        _progressWidget(),
        PsnTextWidget(text: "We have completed the payment.And the funds will be creadited to your bank account within 7 business days.", size: 15.sp, color: "#000000".toColor(),fontFamily: null,),
        SizedBox(height: 20.h,),
        PsnClick(
          onTap: (){
            psnCon.clickSure(rankBean);
          },
          child: Container(
            width: double.infinity,
            height: 48.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: "#356ECA".toColor(),
              borderRadius: BorderRadius.circular(12.w),
            ),
            child: PsnTextWidget(text: "Instantly Credited", size: 16.sp, color: "#FFFFFF".toColor(),fontFamily: null,),
          ),
        ),
        SizedBox(height: 20.h,),
      ],
    ),
  );

  _progressWidget()=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(
        width: double.infinity,
        height: 14.w,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              width: double.infinity,
              height: 7.h,
              color: "#00C220".toColor(),
              margin: EdgeInsets.only(left: 7.w,right: 7.w),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 14.w,
                height: 14.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.w),
                  color: "#EFEFEF".toColor(),
                ),
                child: Container(
                  width: 9.w,
                  height: 9.w,
                  decoration: BoxDecoration(
                    color: "#00C220".toColor(),
                    borderRadius: BorderRadius.circular(4.w),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 14.w,
                height: 14.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.w),
                  color: "#EFEFEF".toColor(),
                ),
                child: Container(
                  width: 9.w,
                  height: 9.w,
                  decoration: BoxDecoration(
                    color: "#00C220".toColor(),
                    borderRadius: BorderRadius.circular(4.w),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 14.w,
                height: 14.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.w),
                  color: "#EFEFEF".toColor(),
                ),
                child: Container(
                  width: 9.w,
                  height: 9.w,
                  decoration: BoxDecoration(
                    color: "#00C220".toColor(),
                    borderRadius: BorderRadius.circular(4.w),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        width: double.infinity,
        height: 50.h,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: PsnTextWidget(text: "Review", size: 12.sp, color: "#067000".toColor()),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: PsnTextWidget(text: "Queue", size: 12.sp, color: "#067000".toColor()),
            ),
            Align(
              alignment: Alignment.topRight,
              child: PsnTextWidget(text: "Funds\nreceived", size: 12.sp, color: "#067000".toColor(),textAlign: TextAlign.end,),
            ),
          ],
        ),
      ),
    ],
  );
}