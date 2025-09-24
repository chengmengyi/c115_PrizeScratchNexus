import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_dialog/psn_b_big_win_dialog/psn_b_big_win_dialog_con.dart';
import 'package:psn_b/psn_b_utils/pns_b_card_type_enum.dart';
import 'package:psn_b/psn_b_utils/psn_user_guide/psn_b_user_guide_utils.dart';
import 'package:psn_b/psn_b_widget/psn_b_btn_widget.dart';
import 'package:psn_root/psn_root_page/psn_root_dialog.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_utils/psn_tba/psn_b_tba_utils.dart';
import 'package:psn_root/psn_root_utils/psn_tba_point_enum.dart';
import 'package:psn_root/psn_root_widget/psn_click.dart';
import 'package:psn_root/psn_root_widget/psn_gradient_text.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';
import 'package:psn_root/psn_root_widget/psn_text_widget.dart';

class PsnBBigWinDialog extends PsnRootDialog<PsnBBigWinDialogCon>{
  double reward;
  PsnBCardTypeEnum cardTypeEnum;
  Function() dismissCallback;
  PsnBBigWinDialog({
    required this.reward,
    required this.cardTypeEnum,
    required this.dismissCallback,
});

  @override
  PsnBBigWinDialogCon onCon() => PsnBBigWinDialogCon();

  @override
  onStart() {
    PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.coin_pop,params: {"source_from":cardTypeEnum.name});
  }

  @override
  Widget onCreate() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      ScaleTransition(
        scale: psnCon.animation,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            PsnImageWidget(name: "big1",width: 474.w,height: 260.h,),
            PsnImageWidget(name: "big2",width: 326.w,height: 263.h,),
          ],
        ),
      ),
      Stack(
        alignment: Alignment.center,
        children: [
          PsnImageWidget(name: "win3",width: double.infinity,height: 500.h,),
          PsnImageWidget(name: "icon_money2",width: 300.w,height: 285.h,),
        ],
      ),
      PsnGradientText(
        data: "+$reward",
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: ["#FFFED5".toColor(),"#FDFC07".toColor()],
        ),
        size: 60.sp,
        outlineColor: "#D44B01".toColor(),
      ),
      SizedBox(height: 50.h,),
      Visibility(
        visible: !PsnBUserGuideUtils.instance.checkShowStep3(),
        child: PsnBBtnWidget(
          width: 370.w,
          text: "Claim \$${twoNumMul(reward, 2)}",
          bgName: "btn_green",
          showVideoIcon: true,
          onTap: (){
            psnCon.clickDouble(cardTypeEnum,reward,dismissCallback);
          },
        ),
      ),
      SizedBox(height: 36.h,),
      GetBuilder<PsnBBigWinDialogCon>(
        id: "single_btn",
        builder: (_)=>Visibility(
          visible: psnCon.showSingleBtn,
          child: PsnClick(
            onTap: (){
              psnCon.clickClaim(cardTypeEnum,reward,dismissCallback);
            },
            child: PsnTextWidget(
              text: "Claim \$$reward",
              size: 36.sp,
              color: "#D4DEE2".toColor(),
              textDecoration: TextDecoration.underline,
              decorationColor: "#D4DEE2".toColor(),
            ),
          ),
        ),
      ),
    ],
  );
}