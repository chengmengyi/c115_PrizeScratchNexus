import 'dart:math';

import 'package:flutter/material.dart';
import 'package:psn_a/psn_a_bean/psn_a_content_bean.dart';
import 'package:psn_a/psn_a_utils/pns_a_card_type_enum.dart';
import 'package:psn_a/psn_a_utils/psn_a_play_utils.dart';
import 'package:psn_a/psn_a_utils/psn_a_value_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_con.dart';

class PsnALucky7Con extends PsnRootCon implements PlayListener{
  late PsnAPlayUtils playUtils;

  @override
  void onInit() {
    super.onInit();
    playUtils=PsnAPlayUtils(
      cardTypeEnum: PsnACardTypeEnum.lucky7,
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
    List<PsnAContentBean> list=[];
    for(var index=0;index<15;index++){
      var lucky7point = PsnAValueUtils.instance.getLucky7Point();
      if(lucky7point){
        list.add(PsnAContentBean(content: "lucky4", reward: PsnAValueUtils.instance.getReward(),win: true));
      }else{
        list.add(PsnAContentBean(content: "${Random().nextInt(100)}", reward: PsnAValueUtils.instance.getReward(),win: false));
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