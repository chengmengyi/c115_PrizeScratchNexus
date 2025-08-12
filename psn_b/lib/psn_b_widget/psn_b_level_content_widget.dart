import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_bean/psn_level_result_bean.dart';
import 'package:psn_b/psn_b_storage/psn_b_storage.dart';
import 'package:psn_b/psn_b_utils/pns_b_card_type_enum.dart';
import 'package:psn_b/psn_b_utils/psn_b_event_code.dart';
import 'package:psn_b/psn_b_utils/psn_b_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_statefull.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';
import 'package:psn_root/psn_root_widget/psn_text_widget.dart';

class PsnBLevelContentWidget extends PsnRootStateful{
  PsnBCardTypeEnum cardTypeEnum;
  PsnBLevelContentWidget({required this.cardTypeEnum});

  @override
  State<StatefulWidget> createState() => PsnALevelContentWidgetState();
}
class PsnALevelContentWidgetState extends PsnRootStatefulState<PsnBLevelContentWidget>{
  @override
  Widget build(BuildContext context){
    var bean = calculateLevel();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        PsnTextWidget(text: "Level ${getLevelByCardType(widget.cardTypeEnum)}", size: 48.sp, color: "#FFFFFF".toColor(),outlineColor: "#030200".toColor(),),
        SizedBox(height: 20.h,),
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(left: 32.w,right: 32.w),
          child: Stack(
            alignment: Alignment.center,
            children: [
              PsnImageWidget(name: "level_bg",width: double.infinity,height: 51.h,),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PsnImageWidget(name: "level2",width: 42.w,height: 34.h,),
                  SizedBox(width: 16.w,),
                  //Scratch  3  more cards to level up!
                  PsnTextWidget(text: "Scratch  ", size: 30.sp, color: "#FFFFFF".toColor(),outlineColor: "#000000".toColor(),),
                  PsnTextWidget(text: "${bean.need-bean.currentProgress}", size: 30.sp, color: "#FFED00".toColor(),outlineColor: "#000000".toColor(),),
                  PsnTextWidget(text: "  more cards to level up!", size: 30.sp, color: "#FFFFFF".toColor(),outlineColor: "#000000".toColor(),),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  bool initEvent() => true;

  @override
  receivedEventBus(int code, int? intValue, String? strValue, anyValue) {
    switch(code){
      case PsnBEventCode.updatePlayNum:
        setState(() {});
        break;
    }
  }

  PsnLevelResultBean calculateLevel() {
    List<int> levelCosts = [5, 10, 10, 10, 10];
    int level = 1;
    int remaining = bUserPlayNum.getData();

    for (int cost in levelCosts) {
      if (remaining >= cost) {
        remaining -= cost;
        level++;
      } else {
        return PsnLevelResultBean(level, remaining, cost);
      }
    }
    // 如果超出 LV6，直接返回满级
    return PsnLevelResultBean(level, 0, 0);
  }
}