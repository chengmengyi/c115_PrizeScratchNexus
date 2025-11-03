import 'dart:async';

import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_dialog/psn_box_dialog/psn_box_dialog.dart';
import 'package:psn_b/psn_b_storage/psn_b_storage.dart';
import 'package:psn_b/psn_b_utils/psn_b_event_code.dart';
import 'package:psn_b/psn_b_widget/psn_guang_spine_widget.dart';
import 'package:psn_root/psn_root_page/psn_root_statefull.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_utils/psn_tba/psn_b_tba_utils.dart';
import 'package:psn_root/psn_root_utils/psn_tba_point_enum.dart';
import 'package:psn_root/psn_root_widget/psn_click.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';
import 'package:psn_root/psn_root_widget/psn_lottie_widget.dart';
import 'package:psn_root/psn_root_widget/psn_text_widget.dart';

class PsnBoxWidget extends PsnRootStateful{
  GlobalKey globalKey;
  PsnBoxWidget({
    required this.globalKey,
});
  @override
  State<StatefulWidget> createState() => PsnBoxWidgetState();
}

class PsnBoxWidgetState extends PsnRootStatefulState<PsnBoxWidget> with SingleTickerProviderStateMixin{
  Timer? _timer;
  int currentTimer=0;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _initAnimator();
    _startTimerCount();
  }

  @override
  Widget build(BuildContext context) => PsnClick(
    onTap: (){
      _clickBox();
    },
    child: Stack(
      children: [
        ScaleTransition(
          scale: _animation,
          child: SizedBox(
            width: 84.w,
            height: 70.h,
            key: widget.globalKey,
            child: Stack(
              children: [
                PsnImageWidget(name: "icon_box",width: double.infinity,height: double.infinity,),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 7.h),
                    child: PsnTextWidget(text: formatMsToMinSec(currentTimer), size: 12.sp, color: "#FFFFFF".toColor()),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Visibility(
                    visible: currentTimer<=0,
                    child: PsnClick(
                      onTap: (){
                        _clickBox();
                      },
                      child: PsnLottieWidget(name: "finger",width: 45.w,height: 45.w,),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        PsnGuangSpineWidget(width: 84.w, height: 70.h),
      ],
    ),
  );

  _clickBox(){
    PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.treasure_icon_c);
    if(currentTimer>0){
      "Cooling down—wait a few mins.".showToast();
      return;
    }
    PsnRootRouters.instance.router(
      routersEnum: PsnRoutersEnum.dialog,
      content: PsnBoxDialog(
        dismissCallback: (){
          bLastBoxTimer.saveData(DateTime.now().millisecondsSinceEpoch);
          _startTimerCount();
        },
      ),
    );
  }

  _startTimerCount(){
    _controller.stop();
    var timer = bLastBoxTimer.getData();
    if(timer<=0){
      bLastBoxTimer.saveData(DateTime.now().millisecondsSinceEpoch);
    }
    timer = bLastBoxTimer.getData();
    var endTimer=timer+300000;
    if(null!=_timer){
      _timer?.cancel();
    }
    _timer=Timer.periodic(Duration(milliseconds: 1000), (timer){
      var i = endTimer-DateTime.now().millisecondsSinceEpoch;
      if(i<=0){
        _timer?.cancel();
        setState(() {
          currentTimer=0;
        });
        _controller..reset()..repeat(reverse: true);
        return;
      }
      setState(() {
        currentTimer=i;
      });
    });
  }

  String formatMsToMinSec(int milliseconds) {
    if(milliseconds<=0){
      return "Claim";
    }
    int totalSeconds = (milliseconds / 1000).floor();
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
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
      case PsnBEventCode.clickBox:
        _clickBox();
        break;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    _timer=null;
    super.dispose();
  }
}