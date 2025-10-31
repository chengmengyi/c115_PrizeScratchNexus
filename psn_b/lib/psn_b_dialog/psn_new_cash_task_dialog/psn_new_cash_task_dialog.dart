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
    margin: EdgeInsets.only(left: 49.w,right: 49.w),
    decoration: BoxDecoration(
      color: "#FFFFFF".toColor(),
      borderRadius: BorderRadius.circular(15.w),
    ),
    child: _contentWidget(),
  );

  _contentWidget()=>Container(
    margin: EdgeInsets.only(left: 17.w,right: 17.w),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 17.h,),
        PsnTextWidget(text: "Review", size: 19.sp, color: "#000000".toColor(),),
        SizedBox(height: 25.h,),
        _progressWidget(),
        PsnTextWidget(text: "Complete 3 tasks to verify you’re human.", size: 15.sp, color: "#000000".toColor()),
        SizedBox(height: 15.h,),
        _taskWidget(),
        SizedBox(height: 15.h,),
        _btnWidget(),
        SizedBox(height: 15.h,),
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
              color: "#EFEFEF".toColor(),
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
              child: PsnTextWidget(text: "Queue", size: 12.sp, color: "#8D8D8D".toColor()),
            ),
            Align(
              alignment: Alignment.topRight,
              child: PsnTextWidget(text: "Funds\nreceived", size: 12.sp, color: "#8D8D8D".toColor(),textAlign: TextAlign.end,),
            ),
          ],
        ),
      ),
    ],
  );
  
  _taskWidget()=>Container(
    width: double.infinity,
    padding: EdgeInsets.all(10.w),
    decoration: BoxDecoration(
      color: "#FFF1E8".toColor(),
      borderRadius: BorderRadius.circular(6.w),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        PsnTextWidget(text: psnCon.getCaskTaskStr(bean), size: 15.sp, color: "#AB0000".toColor(),),
        SizedBox(height: 10.h,),
        Stack(
          alignment: Alignment.center,
          children: [
            LayoutBuilder(
              builder: (context,bc){
                var maxWidth = bc.maxWidth;
                return Container(
                  width: double.infinity,
                  height: 13.h,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: "#000000".toColor().withOpacity(0.4),
                    borderRadius: BorderRadius.circular(20.w),
                  ),
                  child: Container(
                    width: maxWidth*psnCon.getCashTaskPro(bean),
                    height: 13.h,
                    decoration: BoxDecoration(
                      color: "#008E0C".toColor().withOpacity(0.4),
                      borderRadius: BorderRadius.circular(20.w),
                    ),
                  ),
                );
              },
            ),
            PsnTextWidget(text: "${bean.currentProgress??0}/${bean.totalProgress??0}", size: 12.sp, color: "#FFFFFF".toColor()),
          ],
        ),
      ],
    ),
  );

  _btnWidget()=>PsnClick(
    onTap: (){
      psnCon.clickGo(bean,dismissDialog);
    },
    child: Container(
      width: double.infinity,
      height: 49.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: "#356ECA".toColor(),
        borderRadius: BorderRadius.circular(12.w),
      ),
      child: PsnTextWidget(text: "Go", size: 16.sp, color: "#FFFFFF".toColor(),),
    ),
  );
}