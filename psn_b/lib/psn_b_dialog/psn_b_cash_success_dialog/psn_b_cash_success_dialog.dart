import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_bean/psn_cash_task_bean.dart';
import 'package:psn_b/psn_b_dialog/psn_b_cash_success_dialog/psn_b_cash_success_dialog_con.dart';
import 'package:psn_root/psn_root_page/psn_root_dialog.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_widget/psn_click.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';
import 'package:psn_root/psn_root_widget/psn_text_widget.dart';

class PsnBCashSuccessDialog extends PsnRootDialog<PsnBCashSuccessDialogCon>{
  PsnCashTaskBean? cashTaskBean;
  Function() callback;
  PsnBCashSuccessDialog({
    required this.cashTaskBean,
    required this.callback,
});

  @override
  PsnBCashSuccessDialogCon onCon() => PsnBCashSuccessDialogCon();

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
              psnCon.clickSure(cashTaskBean,callback);
            },
            child: PsnImageWidget(name: "icon_close3",width: 50.w,height: 50.w,),
          ),
        ),
      ],
    ),
  );

  _contentWidget()=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(height: 35.h,),
      PsnTextWidget(text: "Congratulations!", size: 36.sp, color: "#000000".toColor()),
      PsnImageWidget(name: "success2",width: 325.w,height: 325.h,),
      Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 30.w,right: 30.w),
        child: PsnTextWidget(
          text: "Congratulations! Your withdrawal request has been successful",
          size: 30.sp,
          color: "#000000".toColor(),
          textAlign: TextAlign.center,
          fontFamily: null,
        ),
      ),
      SizedBox(height: 35.h,),
      PsnClick(
        onTap: (){
          psnCon.clickSure(cashTaskBean,callback);
        },
        child: Container(
          width: double.infinity,
          height: 95.h,
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 75.w,right: 75.w),
          decoration: BoxDecoration(
            color: "#356ECA".toColor(),
            borderRadius: BorderRadius.circular(25.w),
          ),
          child: PsnTextWidget(text: "Confirm", size: 33.sp, color: "#FFFFFF".toColor(),),
        ),
      ),
      SizedBox(height: 40.h,),
    ],
  );
  //     Container(
  //   width: double.infinity,
  //   height: 560.h,
  //   margin: EdgeInsets.only(left: 58.w,right: 58.w),
  //   child: Stack(
  //     children: [
  //       PsnImageWidget(name: "success1",width: double.infinity,height: double.infinity,),
  //       Align(
  //         alignment: Alignment.topCenter,
  //         child: Container(
  //           margin: EdgeInsets.only(top: 32.h),
  //           child: PsnTextWidget(text: "Congratulations!", size: 48.sp, color: "#FFFFFF".toColor(),),
  //         ),
  //       ),
  //       Positioned(
  //         top: 29.h,
  //         right: 29.w,
  //         child: PsnClick(
  //           onTap: (){
  //             psnCon.clickClose();
  //           },
  //           child: PsnImageWidget(name: "icon_close2",width: 40.w,height: 40.w,),
  //         ),
  //       ),
  //       Align(
  //         alignment: Alignment.bottomCenter,
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             PsnTextWidget(text: "We have completed the", size: 36.sp, color: "#535F75".toColor(),),
  //             SizedBox(height: 20.h,),
  //             PsnTextWidget(text: "payment.And the funds will be", size: 36.sp, color: "#535F75".toColor(),),
  //             SizedBox(height: 20.h,),
  //             PsnTextWidget(text: "creadited to your bank account", size: 36.sp, color: "#535F75".toColor(),),
  //             SizedBox(height: 20.h,),
  //             PsnTextWidget(text: "within 7 business days.", size: 36.sp, color: "#535F75".toColor(),),
  //             SizedBox(height: 60.h,),
  //             PsnClick(
  //               onTap: (){
  //                 psnCon.clickSure(cashTaskBean);
  //               },
  //               child: Stack(
  //                 alignment: Alignment.center,
  //                 children: [
  //                   PsnImageWidget(name: "no_money2",width: 458.w,height: 88.h,),
  //                   PsnTextWidget(text: "Instantly Credited", size: 36.sp, color: "#FFFFFF".toColor(),outlineColor: "#0A361C".toColor(),)
  //                 ],
  //               ),
  //             ),
  //             SizedBox(height: 40.h,),
  //           ],
  //         ),
  //       ),
  //     ],
  //   ),
  // );
}