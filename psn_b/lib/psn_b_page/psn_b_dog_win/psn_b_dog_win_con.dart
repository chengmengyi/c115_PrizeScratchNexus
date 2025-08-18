import 'dart:math';

import 'package:psn_b/psn_b_bean/psn_b_content_bean.dart';
import 'package:psn_b/psn_b_utils/pns_b_card_type_enum.dart';
import 'package:psn_b/psn_b_utils/psn_b_play_utils.dart';
import 'package:psn_b/psn_b_utils/psn_b_value_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_con.dart';

class PsnBDogWinCon extends PsnRootCon implements PlayListener{
  late PsnBPlayUtils playUtils;
  List<Map<int, double>> probabilityList = PsnBValueUtils.instance.getDogPoint();

  @override
  void onInit() {
    super.onInit();
    playUtils=PsnBPlayUtils(
      cardTypeEnum: PsnBCardTypeEnum.dogWinning,
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
    List<PsnBContentBean> contentList=[];
    var dogNum = pickByProbability();
    if(dogNum>0){
      var reward = PsnBValueUtils.instance.getCardReward(playUtils.cardTypeEnum);
      for(var index=0;index<dogNum;index++){
        contentList.add(PsnBContentBean(content: "dog7", reward: reward, win: true));
      }
    }
    while(contentList.length<15){
      contentList.add(PsnBContentBean(content: Random().nextBool()?"dog8":"dog9", reward: PsnBValueUtils.instance.getCardReward(playUtils.cardTypeEnum), win: false));
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