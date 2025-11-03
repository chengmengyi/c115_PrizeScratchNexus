import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_bean/psn_b_card_bean.dart';
import 'package:psn_b/psn_b_utils/pns_b_card_type_enum.dart';
import 'package:psn_b/psn_b_utils/psn_b_utils.dart';
import 'package:psn_b/psn_b_widget/psn_b_card_num_widget.dart';
import 'package:psn_b/psn_b_widget/psn_b_guide_text_widget.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_widget/psn_click.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';
import 'package:psn_root/psn_root_widget/psn_lottie_widget.dart';

class PsnBGuide1Overlay extends StatelessWidget{
  Offset playBtnOffset;
  Offset firstPlayCardOffset;
  Size firstPlayCardSize;
  PsnBCardBean value;
  Function() clickCallback;
  PsnBGuide1Overlay({
    required this.playBtnOffset,
    required this.firstPlayCardOffset,
    required this.firstPlayCardSize,
    required this.value,
    required this.clickCallback,
});

  @override
  Widget build(BuildContext context) => Material(
    type: MaterialType.transparency,
    child: PsnClick(
      fromGuide: true,
      onTap: (){
        clickCallback.call();
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black.withOpacity(0.7),
        child: Stack(
          children: [
            Positioned(
              top: firstPlayCardOffset.dy,
              left: firstPlayCardOffset.dx,
              child: Stack(
                children: [
                  PsnImageWidget(name: getCardIcon(value),width: firstPlayCardSize.width,height: firstPlayCardSize.height,),
                  PsnBCardNumWidget(cardTypeEnum: PsnBCardTypeEnum.values.byName(value.cardType??"")),
                ],
              ),
            ),
            Positioned(
              top: playBtnOffset.dy,
              left: playBtnOffset.dx,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  PsnImageWidget(name: "home2",width: 178.w,height: 53.h,),
                  Container(
                    margin: EdgeInsets.only(top: 13.h),
                    child: PsnImageWidget(name: "home3",width: 95.w,height: 20.h,),
                  ),
                ],
              ),
            ),
            Positioned(
              top: playBtnOffset.dy+25.h,
              left: playBtnOffset.dx+85.w,
              child: PsnLottieWidget(name: "finger",width: 50.w,height: 50.w,),
            ),
            Positioned(
              top: playBtnOffset.dy+65.h,
              left: 0,
              right: 0,
              child: PsnBGuideTextWidget(text: "Ready? Mega jackpot gates are about to open!"),
            ),
          ],
        ),
      ),
    ),
  );
}