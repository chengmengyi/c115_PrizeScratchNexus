import 'dart:math';

import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_bean/psn_b_content_bean.dart';
import 'package:psn_b/psn_b_utils/pns_b_card_type_enum.dart';
import 'package:psn_b/psn_b_utils/psn_b_event_code.dart';
import 'package:psn_b/psn_b_utils/psn_b_play_utils.dart';
import 'package:psn_b/psn_b_utils/psn_b_value_utils.dart';
import 'package:psn_b/psn_b_utils/psn_user_guide/psn_b_user_guide_utils.dart';
import 'package:psn_root/psn_root_event/psn_root_event_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_con.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';
import 'package:psn_root/psn_root_utils/psn_tba/psn_b_tba_utils.dart';
import 'package:psn_root/psn_root_utils/psn_tba_point_enum.dart';

class PsnBLucky7Con extends PsnRootCon implements PlayListener{
  late PsnBPlayUtils playUtils;
  var showGuaKaAnimator=false,showTopFinger=false;

  @override
  void onInit() {
    super.onInit();
    playUtils=PsnBPlayUtils(
      cardTypeEnum: PsnBCardTypeEnum.lucky7,
      playListener: this,
    );
  }

  @override
  void onReady() {
    super.onReady();
    _initList();
    playUtils.initScratchWidthHeight();
    _checkShowGuaKaAnimator();
  }

  _initList(){
    List<PsnBContentBean> list=[];
    for(var index=0;index<15;index++){
      var lucky7point = PsnBValueUtils.instance.getLucky7Point();
      if(lucky7point){
        list.add(PsnBContentBean(content: "lucky4", reward: PsnBValueUtils.instance.getCardReward(playUtils.cardTypeEnum),win: true));
      }else{
        list.add(PsnBContentBean(content: "${Random().nextInt(100)}", reward: PsnBValueUtils.instance.getCardReward(playUtils.cardTypeEnum),win: false));
      }
    }
    playUtils.setContentList(list);
    update(["list"]);
  }

  _checkShowGuaKaAnimator(){
    if(PsnBUserGuideUtils.instance.checkShowGuaKaAnimatorStep2()){
      showGuaKaAnimator=true;
      update(["guaka_animator"]);
    }
  }

  onScratchStart(){
    if(showGuaKaAnimator){
      showGuaKaAnimator=false;
      update(["guaka_animator"]);
      PsnBUserGuideUtils.instance.setGuideStep3();
    }
  }

  @override
  resetPlay() {
    _initList();
  }

  clickCash(){
    PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
    PsnRootEventUtils.instance.sendEvent(code: PsnBEventCode.showHomeIndex,intValue: 2);
  }

  @override
  bool initEvent() => true;

  @override
  receivedEventBus(int code, int? intValue, String? strValue, anyValue) {
    switch(code){
      case PsnBEventCode.showTopMoneyFinger:
        showTopFinger=true;
        update(["top_finger"]);
        PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.newuser_guide,params: {"pop_step":"pop4"});
        break;
    }
  }
}