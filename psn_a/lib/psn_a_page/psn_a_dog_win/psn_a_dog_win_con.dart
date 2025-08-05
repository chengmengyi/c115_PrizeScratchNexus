import 'dart:math';

import 'package:psn_a/psn_a_bean/psn_a_content_bean.dart';
import 'package:psn_a/psn_a_utils/pns_a_card_type_enum.dart';
import 'package:psn_a/psn_a_utils/psn_a_play_utils.dart';
import 'package:psn_a/psn_a_utils/psn_a_value_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_con.dart';

class PsnADogWinCon extends PsnRootCon implements PlayListener{
  late PsnAPlayUtils playUtils;
  List<Map<int, double>> probabilityList = [
    {2: 26.7},
    {3: 10},
    {4: 20},
    {5: 20},
    {6: 20},
    {7: 2},
    {8: 1},
    {9: 0.2},
    {10: 0.1},
  ];

  @override
  void onInit() {
    super.onInit();
    playUtils=PsnAPlayUtils(
      cardTypeEnum: PsnACardTypeEnum.dogWinning,
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
    List<PsnAContentBean> contentList=[];
    var dogNum = pickByProbability();
    if(dogNum>0){
      var reward = PsnAValueUtils.instance.getReward();
      for(var index=0;index<dogNum;index++){
        contentList.add(PsnAContentBean(content: "dog7", reward: reward, win: true));
      }
    }
    while(contentList.length<15){
      contentList.add(PsnAContentBean(content: Random().nextBool()?"dog8":"dog9", reward: PsnAValueUtils.instance.getReward(), win: false));
    }
    contentList.shuffle();
    playUtils.setContentList(contentList);
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

  @override
  resetPlay() {
    _initContentList();
  }
}