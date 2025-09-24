import 'dart:math';

import 'package:psn_b/psn_b_bean/psn_b_content_bean.dart';
import 'package:psn_b/psn_b_utils/pns_b_card_type_enum.dart';
import 'package:psn_b/psn_b_utils/psn_b_play_utils.dart';
import 'package:psn_b/psn_b_utils/psn_b_value_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_con.dart';

class PsnBCollectorWinCon extends PsnRootCon implements PlayListener{
  late PsnBPlayUtils playUtils;
  var showGuaKaAnimator=true;

  List<String> iconList=[];

  @override
  void onInit() {
    super.onInit();
    _initIcon();
    playUtils=PsnBPlayUtils(
      cardTypeEnum: PsnBCardTypeEnum.collectorWin,
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
    Random random = Random();
    List<PsnBContentBean> contentList = [];
    List<String> availableIcons = List.from(iconList);
    if(PsnBValueUtils.instance.getCollectorPoint1()){
      String first = availableIcons.removeAt(random.nextInt(availableIcons.length));
      contentList.addAll(List.filled(3, PsnBContentBean(content: first, reward: PsnBValueUtils.instance.getCardReward(playUtils.cardTypeEnum), win: true)));
    }
    if(PsnBValueUtils.instance.getCollectorPoint2()){
      String first = availableIcons.removeAt(random.nextInt(availableIcons.length));
      contentList.addAll(List.filled(3, PsnBContentBean(content: first, reward: PsnBValueUtils.instance.getCardReward(playUtils.cardTypeEnum), win: true)));
    }
    if(PsnBValueUtils.instance.getCollectorPoint3()){
      String first = availableIcons.removeAt(random.nextInt(availableIcons.length));
      contentList.addAll(List.filled(3, PsnBContentBean(content: first, reward: PsnBValueUtils.instance.getCardReward(playUtils.cardTypeEnum), win: true)));
    }
    if(PsnBValueUtils.instance.getCollectorPoint4()){
      String first = availableIcons.removeAt(random.nextInt(availableIcons.length));
      contentList.addAll(List.filled(3, PsnBContentBean(content: first, reward: PsnBValueUtils.instance.getCardReward(playUtils.cardTypeEnum), win: true)));
    }
    int remaining = 20 - contentList.length;
    Map<String, int> counts = {};
    while (contentList.length < 20) {
      String pick = availableIcons[random.nextInt(availableIcons.length)];
      counts[pick] = (counts[pick] ?? 0) + 1;

      if (counts[pick]! <= 2) {
        contentList.add(PsnBContentBean(content: pick, reward: PsnBValueUtils.instance.getCardReward(playUtils.cardTypeEnum), win: false));
      } else {
        counts[pick] = 2;
      }
    }
    contentList.shuffle();
    playUtils.setContentList(contentList);
    update(["list"]);
  }

  _initIcon(){
    iconList.clear();
    for(var index=0;index<12;index++){
      iconList.add("icon_collect${index+1}");
    }
  }

  @override
  resetPlay() {
    _initContentList();
    showGuaKaAnimator=true;
    update(["guaka_animator"]);
  }
}