import 'package:flutter/material.dart';
import 'package:psn_a/psn_a_dialog/psn_a_level_up_dialog/psn_a_level_up_dialog_con.dart';
import 'package:psn_a/psn_a_widget/psn_a_btn_widget.dart';
import 'package:psn_root/psn_root_page/psn_root_dialog.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_widget/psn_gradient_text.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';
import 'package:psn_root/psn_root_widget/psn_text_widget.dart';

class PsnALevelUpDialog extends PsnRootDialog<PsnALevelUpDialogCon>{
  int totalReward;
  Function() dismissCallback;
  PsnALevelUpDialog({
    required this.totalReward,
    required this.dismissCallback,
  });
  @override
  PsnALevelUpDialogCon onCon() => PsnALevelUpDialogCon();

  @override
  Widget onCreate() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      _titleWidget(),
      SizedBox(height: 25.h,),
      _levelWidget(),
    ],
  );

  _levelWidget()=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      PsnGradientText(
        data: psnCon.getLevelStr(),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: ["#FFFED5".toColor(),"#FDFC07".toColor()],
        ),
        size: 60.sp,
        outlineColor: "#D44B01".toColor(),
      ),
      Stack(
        alignment: Alignment.center,
        children: [
          PsnImageWidget(name: "win3",width: double.infinity,height: 500.h,),
          PsnImageWidget(name: "level4",width: 425.w,height: 280.h,),
        ],
      ),
      PsnGradientText(
        data: "+$totalReward",
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: ["#FFFED5".toColor(),"#FDFC07".toColor()],
        ),
        size: 60.sp,
        outlineColor: "#D44B01".toColor(),
      ),
      SizedBox(height: 50.h,),
      PsnABtnWidget(
        text: "Claim",
        bgName: "btn_blue",
        onTap: (){
          psnCon.clickClaim(dismissCallback);
        },
      ),
    ],
  );

  _titleWidget()=>Container(
    margin: EdgeInsets.only(left: 30.w,right: 30.w),
    child: Stack(
      alignment: Alignment.center,
      children: [
        PsnImageWidget(name: "win1",width: double.infinity,height: 128.h,),
        PsnTextWidget(text: "Level Up", size: 60.sp, color: "#FDFC07".toColor(),outlineColor: "#D44B01".toColor(),)
      ],
    ),
  );
}