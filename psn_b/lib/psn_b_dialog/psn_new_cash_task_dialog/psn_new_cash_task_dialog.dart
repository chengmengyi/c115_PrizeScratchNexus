import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_bean/psn_cash_task_bean.dart';
import 'package:psn_b/psn_b_dialog/psn_new_cash_task_dialog/psn_new_cash_task_dialog_con.dart';
import 'package:psn_root/psn_root_page/psn_root_dialog.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_utils/psn_tba/psn_b_tba_utils.dart';
import 'package:psn_root/psn_root_utils/psn_tba_point_enum.dart';
import 'package:psn_root/psn_root_widget/psn_click.dart';
import 'package:psn_root/psn_root_widget/psn_text_widget.dart';

class PsnNewCashTaskDialog extends PsnRootDialog<PsnNewCashTaskDialogCon>{
  PsnCashTaskBean bean;
  PsnNewCashTaskDialog({required this.bean});

  @override
  PsnNewCashTaskDialogCon onCon() => PsnNewCashTaskDialogCon();

  @override
  onStart() {
    PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.cash_task_pop,params: {"pop_from":psnCon.getPopFrom(bean)});
  }

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
      ],
    ),
  );

  _contentWidget()=>Container(
    margin: EdgeInsets.only(left: 35.w,right: 35.w),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 35.h,),
        PsnTextWidget(text: "Request", size: 38.sp, color: "#000000".toColor(),),
        SizedBox(height: 50.h,),
        _progressWidget(),
        PsnTextWidget(text: "Complete 3 tasks to verify you’re human.", size: 30.sp, color: "#000000".toColor()),
        SizedBox(height: 30.h,),
        _taskWidget(),
        SizedBox(height: 30.h,),
        _btnWidget(),
        SizedBox(height: 30.h,),
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
              color: "#EFEFEF".toColor(),
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
              child: PsnTextWidget(text: "Review", size: 25.sp, color: "#8D8D8D".toColor()),
            ),
            Align(
              alignment: Alignment.topRight,
              child: PsnTextWidget(text: "Funds\nreceived", size: 25.sp, color: "#8D8D8D".toColor(),textAlign: TextAlign.end,),
            ),
          ],
        ),
      ),
    ],
  );
  
  _taskWidget()=>Container(
    width: double.infinity,
    padding: EdgeInsets.all(20.w),
    decoration: BoxDecoration(
      color: "#FFF1E8".toColor(),
      borderRadius: BorderRadius.circular(12.w),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        PsnTextWidget(text: psnCon.getCaskTaskStr(bean), size: 30.sp, color: "#AB0000".toColor(),),
        SizedBox(height: 20.h,),
        Stack(
          alignment: Alignment.center,
          children: [
            LayoutBuilder(
              builder: (context,bc){
                var maxWidth = bc.maxWidth;
                return Container(
                  width: double.infinity,
                  height: 25.h,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: "#000000".toColor().withOpacity(0.4),
                    borderRadius: BorderRadius.circular(40.w),
                  ),
                  child: Container(
                    width: maxWidth*psnCon.getCashTaskPro(bean),
                    height: 25.h,
                    decoration: BoxDecoration(
                      color: "#008E0C".toColor().withOpacity(0.4),
                      borderRadius: BorderRadius.circular(40.w),
                    ),
                  ),
                );
              },
            ),
            PsnTextWidget(text: "${bean.currentProgress??0}/${bean.totalProgress??0}", size: 25.sp, color: "#FFFFFF".toColor()),
          ],
        ),
      ],
    ),
  );

  _btnWidget()=>PsnClick(
    onTap: (){
      psnCon.clickGo(bean);
    },
    child: Container(
      width: double.infinity,
      height: 95.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: "#356ECA".toColor(),
        borderRadius: BorderRadius.circular(25.w),
      ),
      child: PsnTextWidget(text: "Go", size: 33.sp, color: "#FFFFFF".toColor(),),
    ),
  );
}