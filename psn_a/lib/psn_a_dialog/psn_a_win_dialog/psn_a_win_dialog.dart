import 'package:flutter/material.dart';
import 'package:psn_a/psn_a_dialog/psn_a_win_dialog/psn_a_win_dialog_con.dart';
import 'package:psn_a/psn_a_widget/psn_a_btn_widget.dart';
import 'package:psn_root/psn_root_page/psn_root_dialog.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_widget/psn_gradient_text.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';

class PsnAWinDialog extends PsnRootDialog<PsnAWinDialogCon>{
  int totalReward;
  Function() dismissCall;
  PsnAWinDialog({
    required this.totalReward,
    required this.dismissCall,
});

  @override
  PsnAWinDialogCon onCon() => PsnAWinDialogCon();

  @override
  Widget onCreate() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      _titleWidget(),
      _coinsWidget(),
      SizedBox(height: 90.h,),
      _btnWidget(),
    ],
  );

  _titleWidget()=>Container(
    width: double.infinity,
    height: 128.h,
    margin: EdgeInsets.only(left: 30.w,right: 30.w),
    child: Stack(
      alignment: Alignment.center,
      children: [
        PsnImageWidget(name: "win1",width: double.infinity,height: double.infinity,),
        PsnImageWidget(name: "win2",height: 60.h,boxFit: BoxFit.fitHeight,),
      ],
    ),
  );

  _coinsWidget()=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Stack(
        alignment: Alignment.center,
        children: [
          PsnImageWidget(name: "win3",width: double.infinity,height: 500.h,),
          PsnImageWidget(name: "win4",width: 380.w,height: 358.h,),
        ],
      ),
      PsnGradientText(
        data: "+$totalReward",
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: ["#FFFED5".toColor(),"#FDFC07".toColor(),],
        ),
        size: 60.sp,
        outlineColor: "#000000".toColor(),
      )
    ],
  );
  
  _btnWidget()=>PsnABtnWidget(
    text: "Claim",
    bgName: "btn_blue",
    onTap: (){
      psnCon.clickClaim(totalReward,dismissCall);
    },
  );
}