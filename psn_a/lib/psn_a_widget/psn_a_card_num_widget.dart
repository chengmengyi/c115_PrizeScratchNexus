import 'dart:math';

import 'package:flutter/material.dart';
import 'package:psn_a/psn_a_utils/pns_a_card_type_enum.dart';
import 'package:psn_a/psn_a_utils/psn_a_event_code.dart';
import 'package:psn_a/psn_a_utils/psn_a_user_info_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_statefull.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';
import 'package:psn_root/psn_root_widget/psn_text_widget.dart';

class PsnACardNumWidget extends PsnRootStateful{
  PsnACardTypeEnum cardTypeEnum;
  PsnACardNumWidget({required this.cardTypeEnum});

  @override
  State<StatefulWidget> createState() => PsnACardNumWidgetState();
}

class PsnACardNumWidgetState extends PsnRootStatefulState<PsnACardNumWidget>{
  int cardNum=0;

  @override
  void initState() {
    super.initState();
    Future((){
      updateCardNum();
    });
  }

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      PsnImageWidget(name: "card_num",width: 162.w,height: 112.h,),
      Container(
        margin: EdgeInsets.only(left: 30.w,top: 32.h),
        child: Transform.rotate(
          angle: -30 * pi / 180,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              PsnTextWidget(text: "$cardNum", size: 24.sp, color: "#FDFF02".toColor(),outlineColor: "#000000".toColor(),),
              PsnTextWidget(text: "/10", size: 24.sp, color: "#FFFFFF".toColor(),outlineColor: "#000000".toColor(),),
            ],
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
      case PsnAEventCode.updateCardNum:
        updateCardNum();
        break;
    }
  }

  updateCardNum()async{
    cardNum = await PsnAUserInfoUtils.instance.getCardNumByType(widget.cardTypeEnum);
    setState(() {});
  }
}