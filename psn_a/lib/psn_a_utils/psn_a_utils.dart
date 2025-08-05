import 'package:psn_a/psn_a_bean/psn_level_result_bean.dart';
import 'package:psn_a/psn_a_routers/psn_a_page_list.dart';
import 'package:psn_a/psn_a_storage/psn_a_storage.dart';
import 'package:psn_a/psn_a_utils/pns_a_card_type_enum.dart';

int getLevelByCardType(PsnACardTypeEnum type){
  var indexWhere = PsnACardTypeEnum.values.indexWhere((value)=>value==type);
  if(indexWhere>=0){
    return indexWhere+1;
  }
  return 1;
}

PsnLevelResultBean calculateLevel() {
  List<int> levelCosts = [5, 10, 10, 10, 10];
  int level = 1;
  int remaining = aUserPlayNum.getData();

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

String getRouterNameByCardType(PsnACardTypeEnum cardTypeEnum){
  var routerName="";
  switch(cardTypeEnum){
    case PsnACardTypeEnum.lucky7:
      routerName=PsnAPageName.lucky7;
      break;
    case PsnACardTypeEnum.collectorWin:
      routerName=PsnAPageName.collectorWin;
      break;
    case PsnACardTypeEnum.dogWinning:
      routerName=PsnAPageName.dogWin;
      break;
    case PsnACardTypeEnum.kingOfCards:
      routerName=PsnAPageName.kingCard;
      break;
    case PsnACardTypeEnum.fruitLineup:
      routerName=PsnAPageName.fruit;
      break;
    case PsnACardTypeEnum.numberWinner:
      routerName=PsnAPageName.number;
      break;
  }
  return routerName;
}
