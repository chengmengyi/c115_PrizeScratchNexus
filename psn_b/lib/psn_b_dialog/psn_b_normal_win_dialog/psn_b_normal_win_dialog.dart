import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_dialog/psn_b_normal_win_dialog/psn_b_normal_win_dialog_con.dart';
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

class PsnBNormalWinDialog extends PsnRootDialog<PsnBNormalWinDialogCon>{
  double reward;
  PsnBCardTypeEnum cardTypeEnum;
  Function() dismissCallback;
  PsnBNormalWinDialog({
    required this.reward,
    required this.cardTypeEnum,
    required this.dismissCallback,
});

  @override
  PsnBNormalWinDialogCon onCon() => PsnBNormalWinDialogCon();
  
  @override
  onStart() {
    PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.coin_pop_s,params: {"source_from":cardTypeEnum.name});
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
            child: PsnImageWidget(name: "get1",width: 209.w,height: 115.h,),
          ),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  PsnImageWidget(name: "win3",height: 250.h,boxFit: BoxFit.fitHeight,),
                  PsnImageWidget(name: "icon_money2",width: 106.w,height: 101.h,),
                ],
              ),
              Container(
                margin: EdgeInsets.only(bottom: 50.h),
                child: PsnGradientText(
                  data: "+\$$reward",
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: ["#FFFED5".toColor(),"#FDFC07".toColor()],
                  ),
                  size: 30.sp,
                  outlineColor: "#D44B01".toColor(),
                ),
              ),
            ],
          ),
          SizedBox(height: 25.h,),
          PsnBBtnWidget(
            width: 185.w,
            text: "Claim \$$reward",
            bgName: "btn_green",
            showVideoIcon: false,
            onTap: (){
              psnCon.clickClaim(cardTypeEnum,reward,dismissCallback);
            },
          )
        ],
      ),
    ],
  );
}