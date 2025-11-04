import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_utils/psn_b_event_code.dart';
import 'package:psn_b/psn_b_utils/psn_wheel_utils.dart';
import 'package:psn_b/psn_b_widget/psn_guang_spine_widget.dart';
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

class _PsnWheelWidgetState extends PsnRootStatefulState<PsnWheelWidget> with SingleTickerProviderStateMixin{
  var wheelNum=0;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _initAnimator();
    _getWheelNum(initAnimator: true);
  }

  @override
  Widget build(BuildContext context) => PsnClick(
    onTap: (){
      PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
      PsnRootEventUtils.instance.sendEvent(code: PsnBEventCode.showHomeIndex,intValue: 1);
    },
    child: SizedBox(
      width: 71.w,
      height: 67.h,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          ScaleTransition(
            scale: _animation,
            child: PsnImageWidget(name: "icon_wheel",width: 71.w,height: 67.h,),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              PsnImageWidget(name: "icon_yuan",width: 23.w,height: 23.w,),
              PsnTextWidget(text: "$wheelNum", size: 15.sp, color: "#FFFFFF".toColor(),),
            ],
          ),
          Visibility(
            visible: wheelNum>0,
            child: PsnGuangSpineWidget(width: 71.w, height: 67.h),
          ),
        ],
      ),
    ),
  );

  _getWheelNum({bool initAnimator=false})async{
    wheelNum=await PsnWheelUtils.instance.getWheelNum();
    setState(() {});
    if(wheelNum>0){
      _controller..reset()..repeat(reverse: true);
    }else{
      _controller.stop();
    }
  }


  _initAnimator()async{
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _animation = Tween<double>(begin: 0.8, end: 1.0)
        .animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}