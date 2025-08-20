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
import 'package:psn_root/psn_root_widget/psn_gradient_text.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';

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
    PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.coin_pop,params: {"source_from":cardTypeEnum.name});
  }

  @override
  Widget onCreate() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      PsnImageWidget(name: "get1",width: 418.w,height: 230.h,),
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
          text: "Double",
          bgName: "btn_green",
          showVideoIcon: true,
          onTap: (){
            psnCon.clickDouble(cardTypeEnum,reward,dismissCallback);
          },
        ),
      ),
      SizedBox(height: 36.h,),
      PsnBBtnWidget(
        text: "Claim",
        bgName: "btn_blue",
        onTap: (){
          psnCon.clickClaim(cardTypeEnum,reward,dismissCallback);
        },
      ),
    ],
  );
}