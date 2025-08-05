import 'dart:math';

import 'package:psn_a/psn_a_bean/psn_a_content_bean.dart';
import 'package:psn_a/psn_a_utils/pns_a_card_type_enum.dart';
import 'package:psn_a/psn_a_utils/psn_a_play_utils.dart';
import 'package:psn_a/psn_a_utils/psn_a_value_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_con.dart';

class PsnAKingCardCon extends PsnRootCon implements PlayListener{
  late PsnAPlayUtils playUtils;
  List<Map<int, double>> probabilityList = [
    {1: 30},
    {2: 30},
    {3: 30},
    {4: 10},
  ];

  @override
  void onInit() {
    super.onInit();
    playUtils=PsnAPlayUtils(
      cardTypeEnum: PsnACardTypeEnum.kingOfCards,
      playListener: this,
    );
  }

  @override
  void onReady() {
    super.onReady();
    _initContentList();
    playUtils.initScratchWidthHeight();
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

  List<PsnAContentBean> generateCardBeans(int n) {

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

    List<PsnAContentBean> result = [];

    for (int i = 0; i < 5; i++) {
      var g = groups[i];
      bool isDesc = descIndices.contains(i);
      if (isDesc) {
        if (g[0] < g[1]) g = g.reversed.toList();
      } else {
        if (g[0] > g[1]) g = g.reversed.toList();
      }
      int rewardValue = PsnAValueUtils.instance.getReward();
      result.add(PsnAContentBean(content: "${g[0]}", reward: rewardValue,win: isDesc));
      result.add(PsnAContentBean(content: "${g[1]}", reward: rewardValue,win: isDesc));
    }

    return result;
  }
  @override
  resetPlay() {
    _initContentList();
  }
}