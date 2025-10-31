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
      PsnTextWidget(text: "Request Submission in\nProgress", size: 22.sp, color: "#FFFFFF".toColor(),fontFamily: null,textAlign: TextAlign.center,),
      SizedBox(height: 25.h,),
      GetBuilder<PsnRankTipsAnimatorDialogCon>(
        id: "icon",
        builder: (_)=>ScaleTransition(
          scale: psnCon.scale,
          child: PsnImageWidget(
            name: psnCon.showFirstIcon?"rank2":"rank1",
            width: 91.w,
            height: 106.h,
          ),
        ),
      ),
      SizedBox(height: 15.h,),
      _pointProgressWidget(),
      GetBuilder<PsnRankTipsAnimatorDialogCon>(
        id: "tips",
        builder: (_)=>Visibility(
          visible: psnCon.showTips,
          child: Container(
            margin: EdgeInsets.only(left: 25.w,right: 25.w),
            child: PsnTextWidget(
              text: "Your request has been successfully submitted and is now queued for review.",
              size: 15.sp,
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
              width: 6.w,
              height: 6.w,
              margin: EdgeInsets.only(left: 2.w,right: 2.w),
              decoration: BoxDecoration(
                color: "#FFFFFF".toColor(),
                borderRadius: BorderRadius.circular(3.w),
              ),
            ),
          );
        }),
      ),
    ),
  );
}