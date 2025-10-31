import 'dart:math';
import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_bean/psn_b_wheel_bean.dart';
import 'package:psn_b/psn_b_dialog/psn_b_get_money_dialog/psn_b_get_money_dialog.dart';
import 'package:psn_b/psn_b_dialog/psn_b_no_wheel_dialog/psn_b_no_wheel_dialog.dart';
import 'package:psn_b/psn_b_storage/psn_b_storage.dart';
import 'package:psn_b/psn_b_utils/psn_b_cash_utils.dart';
import 'package:psn_b/psn_b_utils/psn_b_event_code.dart';
import 'package:psn_b/psn_b_utils/psn_b_value_utils.dart';
import 'package:psn_b/psn_b_utils/psn_wheel_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_con.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';
import 'package:psn_root/psn_root_utils/psn_ad_event_enum.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_utils/psn_tba/psn_b_tba_utils.dart';
import 'package:psn_root/psn_root_utils/psn_tba_point_enum.dart';

class PsnBWheelChildCon extends PsnRootCon with GetSingleTickerProviderStateMixin{
  var canClick=true,wheelNum=0;
  List<PsnBWheelBean> wheelList=[];
  late AnimationController _wheelAnimationController;
  Animation<double>? wheelAnimation;
  late AnimationStatusListener _statusListener;

  @override
  void onInit() {
    super.onInit();
    _wheelAnimationController=AnimationController(vsync: this,duration: const Duration(milliseconds: 1000));
    _statusListener=(status){
      if(status==AnimationStatus.completed){
        _animatorCompleted();
      }
    };
    _wheelAnimationController.addStatusListener(_statusListener);
  }

  @override
  void onReady() {
    super.onReady();
    _initWheelList();
    _updateWheelNum();
  }

  clickStart(){
    if(!canClick){
      return;
    }
    if(wheelNum<=0){
      PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.dialog, content: PsnBNoWheelDialog());
      return;
    }
    canClick=false;
    PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.wheel_page_c);
    _wheelAnimationController..reset()..forward();
  }

  _animatorCompleted()async{
    await Future.delayed(Duration(milliseconds: 1000));
    canClick=true;
    PsnWheelUtils.instance.updateWheelNum(-1);
    var indexWhere = wheelList.indexWhere((value)=>value.win);
    if(indexWhere>=0){
      PsnRootRouters.instance.router(
        routersEnum: PsnRoutersEnum.dialog,
        content: PsnBGetMoneyDialog(
          reward: wheelList[indexWhere].reward,
          adEventEnumDouble: PsnAdEventEnum.apwxi_wheel_rv,
          adEventEnumClose: PsnAdEventEnum.apwxi_wheel_int,
          dismissCallback: (){
            _initWheelList();
          },
        ),
      );
      PsnBCashUtils.instance.updateCashTask(TaskType.wheel);
    }else{
      _initWheelList();
    }
  }

  _initWheelList(){
    wheelList.clear();
    wheelList.add(PsnBWheelBean(reward: 1000, win: false));
    wheelList.add(PsnBWheelBean(reward: PsnBValueUtils.instance.getWheelReward(), win: true));
    while(wheelList.length<8){
      wheelList.add(PsnBWheelBean(reward: _calcFluctuation().toDouble(), win: false));
    }
    wheelList.shuffle();
    var indexWhere = wheelList.indexWhere((value)=>value.win);
    if(indexWhere>=0){
      var angle = 360-indexWhere*45;
      wheelAnimation=Tween<double>(begin: 0,end: (720+angle)*(pi/180)).animate(_wheelAnimationController);
    }
    update(["wheel_list"]);
  }


  int _calcFluctuation() {
    var value = PsnBValueUtils.instance.getWheelReward();
    final random = Random();
    double factor = random.nextBool() ? 1.2 : 0.8;
    int intValue = (value * factor).round();
    return intValue == 0 ? 1 : intValue;
  }

  double getCashMoney(){
    var coins = bUserCoins.getData();
    var first = PsnBValueUtils.instance.getCashList().first;
    if(coins>=first){
      return 0;
    }
    return twoNumSub(first, coins);
  }

  @override
  bool initEvent() => true;

  @override
  receivedEventBus(int code, int? intValue, String? strValue, anyValue) {
    switch(code){
      case PsnBEventCode.updateCoins:
        update(["top_text"]);
        break;
      case PsnBEventCode.updateWheelNum:
        _updateWheelNum();
        break;
    }
  }

  _updateWheelNum()async{
    wheelNum=await PsnWheelUtils.instance.getWheelNum();
    update(["wheel_num"]);
  }

  @override
  void onClose() {
    _wheelAnimationController.removeStatusListener(_statusListener);
    _wheelAnimationController.dispose();
    super.onClose();
  }
}