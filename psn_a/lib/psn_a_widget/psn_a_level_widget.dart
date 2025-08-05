import 'package:flutter/material.dart';
import 'package:psn_a/psn_a_bean/psn_level_result_bean.dart';
import 'package:psn_a/psn_a_storage/psn_a_storage.dart';
import 'package:psn_a/psn_a_utils/psn_a_event_code.dart';
import 'package:psn_a/psn_a_utils/psn_a_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_statefull.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';
import 'package:psn_root/psn_root_widget/psn_text_widget.dart';

class PsnALevelWidget extends PsnRootStateful{
  @override
  State<StatefulWidget> createState() => PsnALevelWidgetState();
}

class PsnALevelWidgetState extends PsnRootStatefulState<PsnALevelWidget>{
  @override
  Widget build(BuildContext context) {
    var bean = calculateLevel();
    return SizedBox(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 64.h,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.w),
                  color: "#2B2F51".toColor(),
                  border: Border.all(
                      width: 1.w,
                      color: "#000000".toColor()
                  ),
                ),
                child: ClipRRect(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    widthFactor: getPro(bean),
                    child: PsnImageWidget(name: "level3",width: double.infinity,height: 64.h,),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 80.w),
                child: PsnTextWidget(text: "lv.${bean.level}", size: 36.sp, color: "#FFFFFF".toColor(),outlineColor: "#2B1E55".toColor(),),
              ),
            ],
          ),
          PsnImageWidget(name: "level1",width: 94.w,height: 85.w,),
        ],
      ),
    );
  }

  @override
  bool initEvent() => true;

  @override
  receivedEventBus(int code, int? intValue, String? strValue, anyValue) {
    switch(code){
      case PsnAEventCode.updatePlayNum:
        setState(() {});
        break;
    }
  }

  double getPro(PsnLevelResultBean bean){
    if(bean.level>=6){
      return 1;
    }
    if(bean.need<=0){
      return 0;
    }
    var d = bean.currentProgress/bean.need;
    if(d<=0){
      return 0;
    }else if(d>=1){
      return 1;
    }else{}
    return d;
  }
}