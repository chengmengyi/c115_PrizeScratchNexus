import 'package:psn_b/psn_b_bean/psn_level_result_bean.dart';
import 'package:psn_b/psn_b_routers/psn_b_page_list.dart';
import 'package:psn_b/psn_b_storage/psn_b_storage.dart';
import 'package:psn_b/psn_b_utils/pns_b_card_type_enum.dart';

int getLevelByCardType(PsnBCardTypeEnum type){
  var indexWhere = PsnBCardTypeEnum.values.indexWhere((value)=>value==type);
  if(indexWhere>=0){
    return indexWhere+1;
  }
  return 1;
}

PsnLevelResultBean calculateLevel() {
  List<int> levelCosts = [5, 10, 10, 10, 10];
  int level = 1;
  int remaining = bUserPlayNum.getData();

  for (int cost in levelCosts) {
    if (remaining >= cost) {
      remaining -= cost;
      level++;
    } else {
      return PsnLevelResultBean(level, remaining, cost);
    }
  }
  // 如果超出 LV6，直接返回满级
  return PsnLevelResultBean(level, 0, 0);
}

String getRouterNameByCardType(PsnBCardTypeEnum cardTypeEnum){
  var routerName="";
  switch(cardTypeEnum){
    case PsnBCardTypeEnum.lucky7:
      routerName=PsnBPageName.lucky7;
      break;
    case PsnBCardTypeEnum.collectorWin:
      routerName=PsnBPageName.collectorWin;
      break;
    case PsnBCardTypeEnum.dogWinning:
      routerName=PsnBPageName.dogWin;
      break;
    case PsnBCardTypeEnum.kingOfCards:
      routerName=PsnBPageName.kingCard;
      break;
    case PsnBCardTypeEnum.fruitLineup:
      routerName=PsnBPageName.fruit;
      break;
    case PsnBCardTypeEnum.numberWinner:
      routerName=PsnBPageName.number;
      break;
  }
  return routerName;
}
