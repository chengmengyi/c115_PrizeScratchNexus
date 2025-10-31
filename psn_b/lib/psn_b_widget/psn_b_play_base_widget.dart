import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_utils/psn_b_play_utils.dart';
import 'package:psn_b/psn_b_widget/psn_b_bottom_btn_widget.dart';
import 'package:psn_b/psn_b_widget/psn_b_card_num_widget.dart';
import 'package:psn_b/psn_b_widget/psn_b_level_content_widget.dart';
import 'package:psn_b/psn_b_widget/psn_b_top_widget.dart';
import 'package:psn_b/psn_b_widget/psn_bottom_left_card_animator_widget.dart';
import 'package:psn_b/psn_b_widget/psn_box_widget.dart';
import 'package:psn_b/psn_b_widget/psn_box_widget_copy.dart';
import 'package:psn_b/psn_b_widget/psn_wheel_animator_widget.dart';
import 'package:psn_b/psn_b_widget/psn_wheel_widget.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';

class PsnBPlayBaseWidget extends StatelessWidget{
  Widget child;
  PsnBPlayUtils playUtils;
  EdgeInsets? margin;

  GlobalKey globalKey=GlobalKey();

  PsnBPlayBaseWidget({
    required this.child,
    required this.playUtils,
    this.margin,
});
  @override
  Widget build(BuildContext context) => WillPopScope(
    child: Stack(
      children: [
        Column(
          children: [
            PsnBTopWidget(
              clickBack: (){
                playUtils.clickBack();
              },
            ),
            SizedBox(height: 10.h,),
            PsnBLevelContentWidget(cardTypeEnum: playUtils.cardTypeEnum,),
            SizedBox(height: 15.h,),
            Expanded(
              child: Stack(
                children: [
                  child,
                  Container(
                    margin: margin,
                    child: PsnBCardNumWidget(
                      cardTypeEnum: playUtils.cardTypeEnum,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        PsnBoxWidgetCopy(),
                        SizedBox(
                          key: globalKey,
                          child: PsnWheelWidget(),
                        ),
                      ],
                    ),
                  ),
                  PsnWheelAnimatorWidget(
                    endGlobalKey: globalKey,
                  ),
                ],
              ),
            ),
            PsnBBottomBtnWidget(
              playUtils: playUtils,
            ),
            SizedBox(height: 20.h,),
          ],
        ),
        PsnBottomLeftCardAnimatorWidget(),
      ],
    ),
    onWillPop: ()async{
      playUtils.clickBack();
      return false;
    },
  );
}