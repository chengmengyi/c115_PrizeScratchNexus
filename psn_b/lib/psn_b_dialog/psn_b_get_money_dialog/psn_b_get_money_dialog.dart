import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_dialog/psn_b_get_money_dialog/psn_b_get_money_dialog_con.dart';
import 'package:psn_b/psn_b_utils/psn_b_value_utils.dart';
import 'package:psn_b/psn_b_widget/psn_b_btn_widget.dart';
import 'package:psn_root/psn_root_page/psn_root_dialog.dart';
import 'package:psn_root/psn_root_utils/psn_ad_event_enum.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_widget/psn_click.dart';
import 'package:psn_root/psn_root_widget/psn_gradient_text.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';
import 'package:psn_root/psn_root_widget/psn_spine_widget.dart';
import 'package:psn_root/psn_root_widget/psn_text_widget.dart';

class PsnBGetMoneyDialog extends PsnRootDialog<PsnBGetMoneyDialogCon>{
  double reward;
  PsnAdEventEnum adEventEnumDouble;
  PsnAdEventEnum adEventEnumClose;
  Function() dismissCallback;
  PsnBGetMoneyDialog({
    required this.reward,
    required this.adEventEnumDouble,
    required this.adEventEnumClose,
    required this.dismissCallback,
});

  @override
  PsnBGetMoneyDialogCon onCon() => PsnBGetMoneyDialogCon();

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
            child: reward>=PsnBValueUtils.instance.getBigWinValue()?
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                PsnImageWidget(name: "big1",width: 303.w,height: 209.h,),
                Container(
                  margin: EdgeInsets.only(bottom: 15.h),
                  child: PsnImageWidget(name: "big2",width: 163.w,height: 131.h,),
                ),
              ],
            ):
            PsnImageWidget(name: "get1",width: 209.w,height: 115.h,),
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
          reward>=50?
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PsnBBtnWidget(
                width: 185.w,
                text: "Claim \$${twoNumMul(reward, 2)}",
                bgName: "btn_green",
                showVideoIcon: true,
                onTap: (){
                  psnCon.clickDouble(adEventEnumDouble,reward,dismissCallback);
                },
              ),
              SizedBox(height: 18.h,),
              GetBuilder<PsnBGetMoneyDialogCon>(
                id: "single_btn",
                builder: (_)=>Visibility(
                  visible: psnCon.showSingleBtn,
                  child: PsnClick(
                    onTap: (){
                      psnCon.clickClaim(adEventEnumClose,reward,dismissCallback);
                    },
                    child: PsnTextWidget(
                      text: "Claim \$$reward",
                      size: 18.sp,
                      color: "#D4DEE2".toColor(),
                      textDecoration: TextDecoration.underline,
                      decorationColor: "#D4DEE2".toColor(),
                    ),
                  ),
                ),
              ),
            ],
          ):
          PsnBBtnWidget(
            width: 185.w,
            text: "Claim \$$reward",
            bgName: "btn_green",
            showVideoIcon: false,
            onTap: (){
              psnCon.clickClaim(adEventEnumClose,reward,dismissCallback);
            },
          ),
        ],
      ),
    ],
  );
}