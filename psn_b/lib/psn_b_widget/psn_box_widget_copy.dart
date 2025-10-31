import 'dart:async';

import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_dialog/psn_box_dialog/psn_box_dialog.dart';
import 'package:psn_b/psn_b_storage/psn_b_storage.dart';
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

class PsnBoxWidgetCopy extends PsnRootStateful{
  @override
  State<StatefulWidget> createState() => _PsnBoxWidgetState();
}

class _PsnBoxWidgetState extends PsnRootStatefulState<PsnBoxWidgetCopy>{
  Timer? _timer;
  int currentTimer=0;

  @override
  void initState() {
    super.initState();
    _startTimerCount();
  }

  @override
  Widget build(BuildContext context) => PsnClick(
    onTap: (){
      _clickBox();
    },
    child: SizedBox(
      width: 72.w,
      height: 72.h,
      child: Stack(
        children: [
          PsnImageWidget(name: "icon_box2",width: double.infinity,height: double.infinity,),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 7.h),
              child: PsnTextWidget(text: formatMsToMinSec(currentTimer), size: 12.sp, color: "#FFFFFF".toColor(),outlineColor: "#A71A1A".toColor(),),
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

  @override
  void dispose() {
    _timer?.cancel();
    _timer=null;
    super.dispose();
  }
}