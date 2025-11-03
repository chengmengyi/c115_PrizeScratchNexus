import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_utils/psn_b_event_code.dart';
import 'package:psn_b/psn_b_utils/psn_b_play_utils.dart';
import 'package:psn_b/psn_b_utils/psn_b_user_info_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_statefull.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';

class PsnBottomLeftCardWidget extends PsnRootStateful{
  PsnBPlayUtils playUtils;
  PsnBottomLeftCardWidget({
    required this.playUtils,
});
  @override
  State<StatefulWidget> createState() => _PsnBottomLeftCardWidgetState();
}

class _PsnBottomLeftCardWidgetState extends PsnRootStatefulState<PsnBottomLeftCardWidget>{

  @override
  Widget build(BuildContext context) => Stack(
    alignment: Alignment.bottomCenter,
    key: widget.playUtils.bottomLeftGlobalKey,
    children: [
      PsnImageWidget(name: "card10",width: 72.w,height: 68.h,),
      Container(
        width: 58.w,
        height: 10.h,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 2.w,right: 2.w),
        decoration: BoxDecoration(
          color: "#17171F".toColor(),
          borderRadius: BorderRadius.circular(6.w),
          border: Border.all(
            width: 1.w,
            color: "#20CE93".toColor(),
          ),
        ),
        child: ClipRRect(
          child: Align(
            alignment: Alignment.centerLeft,
            widthFactor: PsnBUserInfoUtils.instance.getBottomLeftCardProgress(),
            child: PsnImageWidget(name: "cash11",width: double.infinity,height: 6.h,),
          ),
        ),
      ),
    ],
  );

  @override
  bool initEvent() => true;

  @override
  receivedEventBus(int code, int? intValue, String? strValue, anyValue) {
    switch(code){
      case PsnBEventCode.updateCardProgress:
        setState(() {});
        break;
    }
  }
}