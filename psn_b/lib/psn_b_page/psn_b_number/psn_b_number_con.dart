import 'dart:math';

import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_bean/psn_b_content_bean.dart';
import 'package:psn_b/psn_b_utils/pns_b_card_type_enum.dart';
import 'package:psn_b/psn_b_utils/psn_b_play_utils.dart';
import 'package:psn_b/psn_b_utils/psn_b_value_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_con.dart';

class PsnBNumberCon extends PsnRootCon implements PlayListener{
  late PsnBPlayUtils playUtils;
  var showGuaKaAnimator=true;
  List<int> specialNumbersList=[];
  List<Map<int, double>> probabilityList = PsnBValueUtils.instance.getNumberPoint();


  @override
  void onInit() {
    super.onInit();
    playUtils=PsnBPlayUtils(
      cardTypeEnum: PsnBCardTypeEnum.numberWinner,
      playListener: this,
    );
  }

  @override
  void onReady() {
    super.onReady();
    _initList();
    playUtils.initScratchWidthHeight();
  }

  onScratchStart(){
    if(showGuaKaAnimator){
      showGuaKaAnimator=false;
      update(["guaka_animator"]);
    }
  }

  _initList(){
    specialNumbersList.clear();
    specialNumbersList.addAll(generateSpecialNumbers());
    playUtils.setContentList(generateNumbers(specialNumbersList,pickByProbability()));
    update(["list","win"]);
  }

  /// 生成3个不重复的特殊数
  List<int> generateSpecialNumbers() {
    Random random = Random();
    List<int> numbers = List.generate(99, (i) => i + 1);
    numbers.shuffle(random);
    return numbers.take(3).toList();
  }

  /// 生成16个主数
  List<PsnBContentBean> generateNumbers(List<int> firstThree,int sameCount) {
    // Step 2: 从 firstThree 中取 sameCount 个数
    final rand = Random();
    final selectedFromFirstThree = firstThree.toList()..shuffle(rand);
    final sameNumbers = selectedFromFirstThree.take(sameCount).toList();

    // Step 3: 取剩余的 (16 - sameCount) 个数，这些数不能与 firstThree 重复
    final availableNumbers = List.generate(99, (i) => i + 1)
      ..removeWhere((n) => firstThree.contains(n));
    availableNumbers.shuffle(rand);
    final differentNumbers = availableNumbers.take(16 - sameCount).toList();

    // Step 4: 合并成最终 16 个数
    final secondList = [...sameNumbers, ...differentNumbers]..shuffle(rand);

    // Step 5: 转成 PsnBContentBean 列表
    final resultList = secondList.map((value) => PsnBContentBean(content: "$value", win: firstThree.contains(value),reward: PsnBValueUtils.instance.getCardReward(playUtils.cardTypeEnum),globalKey: GlobalKey(),)).toList();
    return resultList;
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

  @override
  resetPlay() {
    _initList();
    showGuaKaAnimator=true;
    update(["guaka_animator"]);
  }
}