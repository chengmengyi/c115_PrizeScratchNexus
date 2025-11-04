import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_bean/psn_cash_task_bean.dart';
import 'package:psn_b/psn_b_dialog/psn_new_cash_task_dialog/psn_new_cash_task_dialog_con.dart';
import 'package:psn_b/psn_b_widget/psn_b_btn_widget.dart';
import 'package:psn_root/psn_root_page/psn_root_dialog.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_utils/psn_tba/psn_b_tba_utils.dart';
import 'package:psn_root/psn_root_utils/psn_tba_point_enum.dart';
import 'package:psn_root/psn_root_widget/psn_click.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';
import 'package:psn_root/psn_root_widget/psn_text_widget.dart';

class PsnNewCashTaskDialog extends PsnRootDialog<PsnNewCashTaskDialogCon>{
  PsnCashTaskBean bean;
  Function()? dismissDialog;
  PsnNewCashTaskDialog({required this.bean,this.dismissDialog});

  @override
  PsnNewCashTaskDialogCon onCon() => PsnNewCashTaskDialogCon();

  @override
  onStart() {
    PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.cash_task_pop,params: {"pop_from":psnCon.getPopFrom(bean)});
  }

  @override
  Widget onCreate() => Container(
    width: double.infinity,
    height: 398.h,
    margin: EdgeInsets.only(left: 30.w,right: 30.w),
    child: Stack(
      children: [
        PsnImageWidget(name: "task_dialog1",width: double.infinity,height: double.infinity,),
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
          child: Container(
            margin: EdgeInsets.only(top: 14.h),
            child: PsnTextWidget(text: "Verification", size: 24.sp, color: "#FFFFFF".toColor(),),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PsnImageWidget(name: "task_dialog2",width: 214.w,height: 144.h,),
              Container(
                margin: EdgeInsets.only(left: 16.w,right: 16.w),
                child: PsnImageWidget(name: "task_dialog3",width: double.infinity,height: 1.h,),
              ),
              SizedBox(height: 16.h,),
              Container(
                margin: EdgeInsets.only(left: 40.w,right: 40.w),
                child: PsnTextWidget(text: "Complete tasks to verify you’re human.", size: 15.sp, color: "#526171".toColor()),
              ),
              SizedBox(height: 16.h,),
              _taskWidget(),
              SizedBox(height: 16.h,),
              _btnWidget(),
              SizedBox(height: 16.h,),
            ],
          ),
        ),
      ],
    ),
  );
  //
  // _contentWidget()=>Container(
  //   margin: EdgeInsets.only(left: 17.w,right: 17.w),
  //   child: Column(
  //     mainAxisSize: MainAxisSize.min,
  //     children: [
  //       SizedBox(height: 17.h,),
  //       PsnTextWidget(text: "Review", size: 19.sp, color: "#000000".toColor(),),
  //       SizedBox(height: 25.h,),
  //       _progressWidget(),
  //       PsnTextWidget(text: "Complete 3 tasks to verify you’re human.", size: 15.sp, color: "#000000".toColor()),
  //       SizedBox(height: 15.h,),
  //       _taskWidget(),
  //       SizedBox(height: 15.h,),
  //       _btnWidget(),
  //       SizedBox(height: 15.h,),
  //     ],
  //   ),
  // );
  //
  // _progressWidget()=>Column(
  //   mainAxisSize: MainAxisSize.min,
  //   children: [
  //     SizedBox(
  //       width: double.infinity,
  //       height: 14.w,
  //       child: Stack(
  //         alignment: Alignment.centerLeft,
  //         children: [
  //           Container(
  //             width: double.infinity,
  //             height: 7.h,
  //             color: "#EFEFEF".toColor(),
  //             margin: EdgeInsets.only(left: 7.w,right: 7.w),
  //           ),
  //           Align(
  //             alignment: Alignment.centerLeft,
  //             child: Container(
  //               width: 14.w,
  //               height: 14.w,
  //               alignment: Alignment.center,
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(7.w),
  //                 color: "#EFEFEF".toColor(),
  //               ),
  //               child: Container(
  //                 width: 9.w,
  //                 height: 9.w,
  //                 decoration: BoxDecoration(
  //                   color: "#00C220".toColor(),
  //                   borderRadius: BorderRadius.circular(4.w),
  //                 ),
  //               ),
  //             ),
  //           ),
  //           Align(
  //             alignment: Alignment.center,
  //             child: Container(
  //               width: 14.w,
  //               height: 14.w,
  //               alignment: Alignment.center,
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(7.w),
  //                 color: "#EFEFEF".toColor(),
  //               ),
  //             ),
  //           ),
  //           Align(
  //             alignment: Alignment.centerRight,
  //             child: Container(
  //               width: 14.w,
  //               height: 14.w,
  //               alignment: Alignment.center,
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(7.w),
  //                 color: "#EFEFEF".toColor(),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //     SizedBox(
  //       width: double.infinity,
  //       height: 50.h,
  //       child: Stack(
  //         children: [
  //           Align(
  //             alignment: Alignment.topLeft,
  //             child: PsnTextWidget(text: "Review", size: 12.sp, color: "#067000".toColor()),
  //           ),
  //           Align(
  //             alignment: Alignment.topCenter,
  //             child: PsnTextWidget(text: "Queue", size: 12.sp, color: "#8D8D8D".toColor()),
  //           ),
  //           Align(
  //             alignment: Alignment.topRight,
  //             child: PsnTextWidget(text: "Funds\nreceived", size: 12.sp, color: "#8D8D8D".toColor(),textAlign: TextAlign.end,),
  //           ),
  //         ],
  //       ),
  //     ),
  //   ],
  // );
  
  _taskWidget()=>Container(
    width: double.infinity,
    padding: EdgeInsets.only(left: 40.w,right: 40.w),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        PsnTextWidget(text: psnCon.getCaskTaskStr(bean), size: 15.sp, color: "#252525".toColor(),),
        SizedBox(height: 10.h,),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 16.h,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: "#042E53".toColor(),
                borderRadius: BorderRadius.circular(20.w),
              ),
              child: Container(
                margin: EdgeInsets.only(left: 3.w,right: 3.w),
                child: ClipRRect(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    widthFactor: psnCon.getCashTaskPro(bean),
                    child: PsnImageWidget(name: "task_dialog4",width: double.infinity,height: 10.h,),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                PsnTextWidget(text: "${bean.currentProgress??0}", size: 14.sp, color: "#FFF600".toColor(),outlineColor: "#000000".toColor(),),
                PsnTextWidget(text: "/${bean.totalProgress??0}", size: 14.sp, color: "#FFFFFF".toColor(),outlineColor: "#000000".toColor(),),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  _btnWidget()=>PsnBBtnWidget(
    text: "Go",
    bgName: "btn_green",
    onTap: (){
      psnCon.clickGo(bean,dismissDialog);
    },
  );
}