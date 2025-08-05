import 'package:flutter/material.dart';
import 'package:psn_a/psn_a_storage/psn_a_storage.dart';
import 'package:psn_a/psn_a_utils/psn_a_event_code.dart';
import 'package:psn_root/psn_root_page/psn_root_statefull.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';
import 'package:psn_root/psn_root_widget/psn_text_widget.dart';

class PsnACoinsWidget extends PsnRootStateful{
  @override
  State<StatefulWidget> createState() => PsnACoinsWidgetState();
}

class PsnACoinsWidgetState extends PsnRootStatefulState<PsnACoinsWidget>{
  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    child: Stack(
      alignment: Alignment.centerLeft,
      children: [
        Container(
          width: double.infinity,
          height: 64.h,
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 70.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.w),
            color: "#2B2F51".toColor(),
            border: Border.all(
              width: 1.w,
              color: "#000000".toColor()
            ),
          ),
          child: PsnTextWidget(text: "${aUserCoins.getData()}", size: 36.sp, color: "#FFFFFF".toColor(),outlineColor: "#2B1E55".toColor(),),
        ),
        PsnImageWidget(name: "icon_coins",width: 85.w,height: 85.w,),
      ],
    ),
  );

  @override
  bool initEvent() => true;

  @override
  receivedEventBus(int code, int? intValue, String? strValue, anyValue) {
    switch(code){
      case PsnAEventCode.updateCoins:
        setState(() {});
        break;
    }
  }
}