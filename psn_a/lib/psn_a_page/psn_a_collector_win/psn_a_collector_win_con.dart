import 'dart:math';

import 'package:psn_a/psn_a_bean/psn_a_content_bean.dart';
import 'package:psn_a/psn_a_utils/pns_a_card_type_enum.dart';
import 'package:psn_a/psn_a_utils/psn_a_play_utils.dart';
import 'package:psn_a/psn_a_utils/psn_a_value_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_con.dart';

class PsnACollectorWinCon extends PsnRootCon implements PlayListener{
  late PsnAPlayUtils playUtils;

  List<String> iconList=[];

  @override
  void onInit() {
    super.onInit();
    _initIcon();
    playUtils=PsnAPlayUtils(
      cardTypeEnum: PsnACardTypeEnum.collectorWin,
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
    Random random = Random();
    List<PsnAContentBean> contentList = [];
    List<String> availableIcons = List.from(iconList);
    if(PsnAValueUtils.instance.getCollectorPoint1()){
      String first = availableIcons.removeAt(random.nextInt(availableIcons.length));
      contentList.addAll(List.filled(3, PsnAContentBean(content: first, reward: PsnAValueUtils.instance.getReward(), win: true)));
    }
    if(PsnAValueUtils.instance.getCollectorPoint2()){
      String first = availableIcons.removeAt(random.nextInt(availableIcons.length));
      contentList.addAll(List.filled(3, PsnAContentBean(content: first, reward: PsnAValueUtils.instance.getReward(), win: true)));
    }
    if(PsnAValueUtils.instance.getCollectorPoint3()){
      String first = availableIcons.removeAt(random.nextInt(availableIcons.length));
      contentList.addAll(List.filled(3, PsnAContentBean(content: first, reward: PsnAValueUtils.instance.getReward(), win: true)));
    }
    if(PsnAValueUtils.instance.getCollectorPoint4()){
      String first = availableIcons.removeAt(random.nextInt(availableIcons.length));
      contentList.addAll(List.filled(3, PsnAContentBean(content: first, reward: PsnAValueUtils.instance.getReward(), win: true)));
    }
    int remaining = 20 - contentList.length;
    Map<String, int> counts = {};
    while (contentList.length < 20) {
      String pick = availableIcons[random.nextInt(availableIcons.length)];
      counts[pick] = (counts[pick] ?? 0) + 1;

      if (counts[pick]! <= 2) {
        contentList.add(PsnAContentBean(content: pick, reward: PsnAValueUtils.instance.getReward(), win: false));
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
  }
}