import 'dart:async';
import 'package:flutter/material.dart';
import 'package:psn_root/psn_root_page/psn_root_con.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';

class PsnRankTipsAnimatorDialogCon extends PsnRootCon with GetSingleTickerProviderStateMixin{
  Function()? callback;
  var showTips=false,pointNum=1,showFirstIcon=true;
  Timer? _timer;
  Timer? _pointTimer;

  late AnimationController _controller;
  late Animation<double> scale;

  @override
  void onInit() {
    super.onInit();
    _showTipsTimer();
    _startPointTimer();
    _initAnimator();
  }

  clickBtn(){
    PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
  }

  _showTipsTimer(){
    _timer=Timer(Duration(milliseconds: 3000), ()async{
      showTips=true;
      _stopPointTimer();
      update(["point"]);
      _controller.forward(from: 0);
      await Future.delayed(Duration(milliseconds: 1000));
      update(["tips"]);
      await Future.delayed(Duration(milliseconds: 1000));
      PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
      callback?.call();
    });
  }

  _startPointTimer(){
    _pointTimer=Timer.periodic(Duration(milliseconds: 400), (t){
      pointNum++;
      if(pointNum>4){
        pointNum=1;
      }
      update(["point"]);
    });
  }

  _stopPointTimer(){
    _pointTimer?.cancel();
    _pointTimer=null;
  }

  _initAnimator(){
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    scale = Tween<double>(begin: 1.0, end: 0.0).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          showFirstIcon = !showFirstIcon;
          update(["icon"]);
          _controller.reverse();
        }
      });
  }

  @override
  void onClose() {
    _timer?.cancel();
    _timer=null;
    _stopPointTimer();
    _controller.dispose();
    super.onClose();
  }
}