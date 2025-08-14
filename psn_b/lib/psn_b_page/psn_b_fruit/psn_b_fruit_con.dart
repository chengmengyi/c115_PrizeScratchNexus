import 'dart:math';
import 'package:psn_b/psn_b_bean/psn_b_content_bean.dart';
import 'package:psn_b/psn_b_utils/pns_b_card_type_enum.dart';
import 'package:psn_b/psn_b_utils/psn_b_play_utils.dart';
import 'package:psn_b/psn_b_utils/psn_b_value_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_con.dart';

class PsnBFruitCon extends PsnRootCon implements PlayListener{
  late PsnBPlayUtils playUtils;
  List<Map<int, double>> probabilityList = PsnBValueUtils.instance.getFruitPoint();

  List<String> iconList=["icon_fruit1","icon_fruit2","icon_fruit3",];

  @override
  void onInit() {
    super.onInit();
    playUtils=PsnBPlayUtils(
      cardTypeEnum: PsnBCardTypeEnum.fruitLineup,
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
    var list = generateFruitBeans(pickByProbability());
    playUtils.setContentList(list);
    update(["list"]);
  }

  List<PsnBContentBean> generateFruitBeans(int n) {

    Random random = Random();
    List<List<String>> groups = List.generate(4, (_) => []);

    // 随机选择哪些组是三个一样
    List<int> indices = List.generate(4, (i) => i);
    indices.shuffle();
    List<int> tripleGroups = indices.take(n).toList();

    for (int i = 0; i < 4; i++) {
      if (tripleGroups.contains(i)) {
        // 三个一样
        String fruit = iconList[random.nextInt(iconList.length)];
        groups[i] = List.filled(3, fruit);
      } else {
        // 最多两个一样
        List<String> group = [];
        while (group.length < 3) {
          String fruit = iconList[random.nextInt(iconList.length)];
          int count = group.where((f) => f == fruit).length;
          if (count < 2) {
            group.add(fruit);
          }
        }
        groups[i] = group;
      }
    }

    // 转成 List<PsnBContentBean>
    List<PsnBContentBean> result = [];
    for (int i = 0; i < 4; i++) {
      bool isTriple = tripleGroups.contains(i);
      var reward = PsnBValueUtils.instance.getReward(playUtils.cardTypeEnum);
      for (String fruit in groups[i]) {
        result.add(PsnBContentBean(content: fruit, reward: reward,win: isTriple));
      }
    }

    return result;
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
  }
}