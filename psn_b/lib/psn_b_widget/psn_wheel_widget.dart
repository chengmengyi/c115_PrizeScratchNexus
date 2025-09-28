import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_utils/psn_b_event_code.dart';
import 'package:psn_b/psn_b_utils/psn_wheel_utils.dart';
import 'package:psn_root/psn_root_event/psn_root_event_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_statefull.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_widget/psn_click.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';
import 'package:psn_root/psn_root_widget/psn_text_widget.dart';

class PsnWheelWidget extends PsnRootStateful{
  @override
  State<StatefulWidget> createState() => _PsnWheelWidgetState();
}

class _PsnWheelWidgetState extends PsnRootStatefulState<PsnWheelWidget>{
  var wheelNum=0;

  @override
  void initState() {
    super.initState();
    _getWheelNum();
  }

  @override
  Widget build(BuildContext context) => PsnClick(
    onTap: (){
      PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
      PsnRootEventUtils.instance.sendEvent(code: PsnBEventCode.showHomeIndex,intValue: 1);
    },
    child: Stack(
      alignment: Alignment.topRight,
      children: [
        PsnImageWidget(name: "icon_wheel",width: 143.w,height: 134.h,),
        Stack(
          alignment: Alignment.center,
          children: [
            PsnImageWidget(name: "icon_yuan",width: 46.w,height: 46.w,),
            PsnTextWidget(text: "$wheelNum", size: 30.sp, color: "#FFFFFF".toColor(),),
          ],
        ),
      ],
    ),
  );

  _getWheelNum()async{
    wheelNum=await PsnWheelUtils.instance.getWheelNum();
    setState(() {});
  }

  @override
  bool initEvent() => true;

  @override
  receivedEventBus(int code, int? intValue, String? strValue, anyValue) {
    switch(code){
      case PsnBEventCode.updateWheelNum:
        _getWheelNum();
        break;
    }
  }
}