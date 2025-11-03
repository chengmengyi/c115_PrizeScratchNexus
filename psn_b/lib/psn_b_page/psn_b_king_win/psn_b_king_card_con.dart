import 'dart:math';

import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_bean/psn_b_content_bean.dart';
import 'package:psn_b/psn_b_utils/pns_b_card_type_enum.dart';
import 'package:psn_b/psn_b_utils/psn_b_play_utils.dart';
import 'package:psn_b/psn_b_utils/psn_b_value_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_con.dart';

class PsnBKingCardCon extends PsnRootCon implements PlayListener{
  late PsnBPlayUtils playUtils;
  var showGuaKaAnimator=true;
  List<Map<int, double>> probabilityList = PsnBValueUtils.instance.getKingPoint();

  @override
  void onInit() {
    super.onInit();
    playUtils=PsnBPlayUtils(
      cardTypeEnum: PsnBCardTypeEnum.kingOfCards,
      playListener: this,
    );
  }

  @override
  void onReady() {
    super.onReady();
    _initContentList();
    playUtils.initScratchWidthHeight();
  }

  onScratchStart(){
    if(showGuaKaAnimator){
      showGuaKaAnimator=false;
      update(["guaka_animator"]);
    }
  }

  _initContentList(){
    var list = generateCardBeans(pickByProbability());
    playUtils.setContentList(list);
    update(["list"]);
  }

  int pickByProbability() {
    Random random = Random();
    double roll = random.nextDouble() * 100;
    double cumulative = 0;
    for (var entry in probabilityList) {
      int value = entry.keys.first;
      double probability = entry.values.first;

      cumulative += probability;
      if (roll < cumulative) {
        return value;
      }
    }
    return probabilityList.first.keys.first;
  }

  List<PsnBContentBean> generateCardBeans(int n) {

    List<int> cards = List.generate(13, (i) => i + 2); // 2~14
    cards.shuffle(Random());
    List<int> selected = cards.take(10).toList();
    List<List<int>> groups = [];
    for (int i = 0; i < 5; i++) {
      groups.add([selected[i * 2], selected[i * 2 + 1]]);
    }
    List<int> indices = List.generate(5, (i) => i);
    indices.shuffle();
    List<int> descIndices = indices.take(n).toList();

    List<PsnBContentBean> result = [];

    for (int i = 0; i < 5; i++) {
      var g = groups[i];
      bool isDesc = descIndices.contains(i);
      if (isDesc) {
        if (g[0] < g[1]) g = g.reversed.toList();
      } else {
        if (g[0] > g[1]) g = g.reversed.toList();
      }
      double rewardValue = PsnBValueUtils.instance.getCardReward(playUtils.cardTypeEnum);
      result.add(PsnBContentBean(content: "${g[0]}", reward: rewardValue,win: isDesc,globalKey: GlobalKey(),));
      result.add(PsnBContentBean(content: "${g[1]}", reward: rewardValue,win: isDesc,globalKey: GlobalKey(),));
    }

    return result;
  }
  @override
  resetPlay() {
    _initContentList();
    showGuaKaAnimator=true;
    update(["guaka_animator"]);
  }
}