import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_dialog/psn_b_cash_tips_dialog/psn_b_cash_tips_dialog_con.dart';
import 'package:psn_b/psn_b_utils/psn_b_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_dialog.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_widget/psn_click.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';
import 'package:psn_root/psn_root_widget/psn_text_widget.dart';

class PsnBCashTipsDialog extends PsnRootDialog<PsnBCashTipsDialogCon>{

  @override
  PsnBCashTipsDialogCon onCon() => PsnBCashTipsDialogCon();

  @override
  Widget onCreate() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      PsnTextWidget(text: "Congratulations!", size: 42.sp, color: "#FFFFFF".toColor(),),
      SizedBox(height: 20.h,),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          PsnTextWidget(text: "Account Reaches ", size: 31.sp, color: "#FFFFFF".toColor()),
          PsnTextWidget(text: "\$${psnCon.getFirstMoney()}", size: 31.sp, color: "#3DF329".toColor()),
        ],
      ),
      SizedBox(height: 70.h,),
      Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PsnImageWidget(name: getCashDialogImages(psnCon.cashType),width: 308.w,height: 165.h,),
          Container(
            margin: EdgeInsets.only(bottom: 50.h),
            child: PsnTextWidget(text: "\$${psnCon.getFirstMoney()}", size: 50.sp, color: "#252525".toColor(),),
          ),
        ],
      ),
      SizedBox(height: 100.h,),
      PsnClick(
        onTap: (){
          psnCon.clickCon();
        },
        child: Container(
          width: 400.w,
          height: 96.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: "#356ECA".toColor(),
            borderRadius: BorderRadius.circular(25.w),
          ),
          child: PsnTextWidget(text: "Cash Out", size: 33.sp, color: "#FFFFFF".toColor(),),
        ),
      )
      // PsnImageWidget(name: "tips1",width: double.infinity,height: double.infinity,),
      // Align(
      //   alignment: Alignment.topCenter,
      //   child: Container(
      //     margin: EdgeInsets.only(top: 32.h),
      //     child: PsnTextWidget(text: "Account Reaches \$${psnCon.getFirstMoney()}", size: 36.sp, color: "#FFFFFF".toColor(),),
      //   ),
      // ),
      // Positioned(
      //   top: 29.h,
      //   right: 29.w,
      //   child: PsnClick(
      //     onTap: (){
      //       psnCon.clickClose();
      //     },
      //     child: PsnImageWidget(name: "icon_close2",width: 40.w,height: 40.w,),
      //   ),
      // ),
      // Align(
      //   alignment: Alignment.bottomCenter,
      //   child: Column(
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       Stack(
      //         alignment: Alignment.bottomCenter,
      //         children: [
      //           PsnImageWidget(name: getCashDialogImages(psnCon.cashType),width: 496.w,height: 237.h,),
      //           Container(
      //             margin: EdgeInsets.only(bottom: 50.h),
      //             child: PsnTextWidget(text: "\$${psnCon.getFirstMoney()}", size: 70.sp, color: "#252525".toColor(),),
      //           ),
      //         ],
      //       ),
      //       SizedBox(height: 30.h,),
      //       Container(
      //         margin: EdgeInsets.only(left: 55.w,right: 55.w),
      //         child: PsnTextWidget(text: "Congrats! You're in the top 1%-persistence  pays off! Hurry up and withdraw your \$${psnCon.getFirstMoney()} now!", size: 34.sp, color: "#535F75".toColor()),
      //       ),
      //       SizedBox(height: 40.h,),
      //       PsnClick(
      //         onTap: (){
      //           psnCon.clickCon();
      //         },
      //         child: SizedBox(
      //           width: 297.w,
      //           height: 107.h,
      //           child: Stack(
      //             children: [
      //               PsnImageWidget(name: "btn_blue",width: double.infinity,height: double.infinity,),
      //               Align(
      //                 alignment: Alignment.center,
      //                 child: PsnTextWidget(text: "Confirm", size: 42.sp, color: "#F2F3F3".toColor(),outlineColor: "#090733".toColor(),),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //       SizedBox(height: 40.h,),
      //     ],
      //   ),
      // ),
    ],
  );
}