import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_dialog/psn_b_level_up_dialog/psn_b_level_up_dialog_con.dart';
import 'package:psn_b/psn_b_widget/psn_b_btn_widget.dart';
import 'package:psn_root/psn_root_page/psn_root_dialog.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_widget/psn_gradient_text.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';
import 'package:psn_root/psn_root_widget/psn_text_widget.dart';

class PsnBLevelUpDialog extends PsnRootDialog<PsnBLevelUpDialogCon>{
  Function() dismissCallback;
  PsnBLevelUpDialog({
    required this.dismissCallback,
  });
  @override
  PsnBLevelUpDialogCon onCon() => PsnBLevelUpDialogCon();

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
          PsnImageWidget(name: "icon_money2",width: 300.w,height: 285.h,),
        ],
      ),
      PsnGradientText(
        data: "+\$${psnCon.upLevelReward}",
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: ["#FFFED5".toColor(),"#FDFC07".toColor()],
        ),
        size: 60.sp,
        outlineColor: "#D44B01".toColor(),
      ),
      SizedBox(height: 50.h,),
      PsnBBtnWidget(
        text: "Double",
        bgName: "btn_green",
        showVideoIcon: true,
        onTap: (){
          psnCon.clickDouble(dismissCallback);
        },
      ),
      SizedBox(height: 36.h,),
      PsnBBtnWidget(
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