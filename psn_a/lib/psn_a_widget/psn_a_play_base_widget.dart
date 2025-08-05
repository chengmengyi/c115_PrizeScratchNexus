import 'package:flutter/material.dart';
import 'package:psn_a/psn_a_utils/psn_a_play_utils.dart';
import 'package:psn_a/psn_a_widget/psn_a_bottom_btn_widget.dart';
import 'package:psn_a/psn_a_widget/psn_a_card_num_widget.dart';
import 'package:psn_a/psn_a_widget/psn_a_level_content_widget.dart';
import 'package:psn_a/psn_a_widget/psn_a_top_widget.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';

class PsnAPlayBaseWidget extends StatelessWidget{
  Widget child;
  PsnAPlayUtils playUtils;
  EdgeInsets? margin;
  PsnAPlayBaseWidget({
    required this.child,
    required this.playUtils,
    this.margin,
});
  @override
  Widget build(BuildContext context) => WillPopScope(
    child: Column(
      children: [
        PsnATopWidget(
          clickBack: (){
            playUtils.clickBack();
          },
        ),
        SizedBox(height: 20.h,),
        PsnALevelContentWidget(cardTypeEnum: playUtils.cardTypeEnum,),
        SizedBox(height: 30.h,),
        Expanded(
          child: Stack(
            children: [
              child,
              Container(
                margin: margin,
                child: PsnACardNumWidget(
                  cardTypeEnum: playUtils.cardTypeEnum,
                ),
              ),
            ],
          ),
        ),
        PsnABottomBtnWidget(
          playUtils: playUtils,
        ),
        SizedBox(height: 20.h,),
      ],
    ),
    onWillPop: ()async{
      playUtils.clickBack();
      return false;
    },
  );
}