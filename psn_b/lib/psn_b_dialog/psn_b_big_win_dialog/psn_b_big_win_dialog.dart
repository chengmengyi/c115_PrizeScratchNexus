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
import 'package:psn_root/psn_root_widget/psn_spine_widget.dart';
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
  Widget onCreate() => Stack(
    alignment: Alignment.center,
    children: [
      PsnSpineWidget(
        atlasFile: "fly_poker",
        skeletonFile: "fly_poker",
        animatorName: "cddh",
        folder: "caidai",
        width: double.infinity,
        height: double.infinity,
      ),
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ScaleTransition(
            scale: psnCon.animation,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                PsnImageWidget(name: "big1",width: 606.w,height: 418.h,),
                Container(
                  margin: EdgeInsets.only(bottom: 30.h),
                  child: PsnImageWidget(name: "big2",width: 326.w,height: 263.h,),
                ),
              ],
            ),
          ),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  PsnImageWidget(name: "win3",height: 500.h,boxFit: BoxFit.fitHeight,),
                  PsnImageWidget(name: "icon_money2",width: 213.w,height: 202.h,),
                ],
              ),
              Container(
                margin: EdgeInsets.only(bottom: 100.h),
                child: PsnGradientText(
                  data: "+\$$reward",
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: ["#FFFED5".toColor(),"#FDFC07".toColor()],
                  ),
                  size: 60.sp,
                  outlineColor: "#D44B01".toColor(),
                ),
              ),
            ],
          ),
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
      )
    ],
  );
}