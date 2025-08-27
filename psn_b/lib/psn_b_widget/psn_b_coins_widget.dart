import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_storage/psn_b_storage.dart';
import 'package:psn_b/psn_b_utils/psn_b_event_code.dart';
import 'package:psn_root/psn_root_page/psn_root_statefull.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';
import 'package:psn_root/psn_root_widget/psn_text_widget.dart';

class PsnBCoinsWidget extends PsnRootStateful{
  @override
  State<StatefulWidget> createState() => PsnACoinsWidgetState();
}

class PsnACoinsWidgetState extends PsnRootStatefulState<PsnBCoinsWidget>{
  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    height: 85.h,
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
          child: PsnTextWidget(text: "\$${bUserCoins.getData()}", size: 36.sp, color: "#FFFFFF".toColor(),outlineColor: "#2B1E55".toColor(),),
        ),
        PsnImageWidget(name: "icon_money",width: 85.w,height: 85.w,),
      ],
    ),
  );

  @override
  bool initEvent() => true;

  @override
  receivedEventBus(int code, int? intValue, String? strValue, anyValue) {
    switch(code){
      case PsnBEventCode.updateCoins:
        setState(() {});
        break;
    }
  }
}