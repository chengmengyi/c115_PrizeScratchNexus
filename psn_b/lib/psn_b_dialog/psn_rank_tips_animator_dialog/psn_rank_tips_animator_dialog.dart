import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_dialog/psn_rank_tips_animator_dialog/psn_rank_tips_animator_dialog_con.dart';
import 'package:psn_root/psn_root_page/psn_root_dialog.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';
import 'package:psn_root/psn_root_widget/psn_text_widget.dart';

class PsnRankTipsAnimatorDialog extends PsnRootDialog<PsnRankTipsAnimatorDialogCon>{
  Function() callback;
  PsnRankTipsAnimatorDialog({required this.callback,});

  @override
  PsnRankTipsAnimatorDialogCon onCon() => PsnRankTipsAnimatorDialogCon();

  @override
  onStart() {
    psnCon.callback=callback;
  }

  @override
  Widget onCreate() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      PsnTextWidget(text: "Request Submission in\nProgress", size: 45.sp, color: "#FFFFFF".toColor(),fontFamily: null,textAlign: TextAlign.center,),
      SizedBox(height: 50.h,),
      GetBuilder<PsnRankTipsAnimatorDialogCon>(
        id: "icon",
        builder: (_)=>ScaleTransition(
          scale: psnCon.scale,
          child: PsnImageWidget(
            name: psnCon.showFirstIcon?"rank2":"rank1",
            width: 183.w,
            height: 212.h,
          ),
        ),
      ),
      SizedBox(height: 30.h,),
      _pointProgressWidget(),
      GetBuilder<PsnRankTipsAnimatorDialogCon>(
        id: "tips",
        builder: (_)=>Visibility(
          visible: psnCon.showTips,
          child: Container(
            margin: EdgeInsets.only(left: 50.w,right: 50.w),
            child: PsnTextWidget(
              text: "Your request has been successfully submitted and is now queued for review.",
              size: 30.sp,
              color: "#FFFFFF".toColor(),
              fontFamily: null,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    ],
  );

  _pointProgressWidget()=>GetBuilder<PsnRankTipsAnimatorDialogCon>(
    id: "point",
    builder: (_)=>Visibility(
      visible: !psnCon.showTips,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(4, (value){
          return Visibility(
            visible: psnCon.pointNum>value,
            maintainAnimation: true,
            maintainState: true,
            maintainSize: true,
            child: Container(
              width: 12.w,
              height: 12.w,
              margin: EdgeInsets.only(left: 5.w,right: 5.w),
              decoration: BoxDecoration(
                color: "#FFFFFF".toColor(),
                borderRadius: BorderRadius.circular(6.w),
              ),
            ),
          );
        }),
      ),
    ),
  );
}