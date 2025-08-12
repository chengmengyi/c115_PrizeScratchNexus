import 'dart:math';

import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_bean/psn_b_content_bean.dart';
import 'package:psn_b/psn_b_utils/pns_b_card_type_enum.dart';
import 'package:psn_b/psn_b_utils/psn_b_play_utils.dart';
import 'package:psn_b/psn_b_utils/psn_b_value_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_con.dart';

class PsnBLucky7Con extends PsnRootCon implements PlayListener{
  late PsnBPlayUtils playUtils;

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
  }

  _initList(){
    List<PsnBContentBean> list=[];
    for(var index=0;index<15;index++){
      var lucky7point = PsnBValueUtils.instance.getLucky7Point();
      if(lucky7point){
        list.add(PsnBContentBean(content: "lucky4", reward: PsnBValueUtils.instance.getReward(),win: true));
      }else{
        list.add(PsnBContentBean(content: "${Random().nextInt(100)}", reward: PsnBValueUtils.instance.getReward(),win: false));
      }
    }
    playUtils.setContentList(list);
    update(["list"]);
  }

  @override
  resetPlay() {
    _initList();
  }
}