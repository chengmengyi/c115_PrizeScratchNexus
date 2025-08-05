import 'package:psn_a/psn_a_bean/psn_a_card_bean.dart';
import 'package:psn_a/psn_a_storage/psn_a_storage.dart';
import 'package:psn_a/psn_a_utils/pns_a_card_type_enum.dart';
import 'package:psn_a/psn_a_utils/psn_a_event_code.dart';
import 'package:psn_root/psn_root_event/psn_root_event_utils.dart';
import 'package:psn_root/psn_root_utils/psn_root_sql/psn_root_sql_name.dart';
import 'package:psn_root/psn_root_utils/psn_root_sql/psn_root_sql_utils.dart';

class PsnAUserInfoUtils {
  static final PsnAUserInfoUtils _utils = PsnAUserInfoUtils();
  static PsnAUserInfoUtils get instance => _utils;

  initCardInfo()async{
    var database = await PsnRootSqlUtils.instance.initSql();
    var list = await database.query(PsnRootSqlName.aCardNum);
    if(list.isNotEmpty){
      return;
    }
    var cardList=[
      PsnACardBean(cardType: PsnACardTypeEnum.lucky7.name,cardNum: 10,unlock: 0),
      PsnACardBean(cardType: PsnACardTypeEnum.collectorWin.name,cardNum: 10,unlock: 1),
      PsnACardBean(cardType: PsnACardTypeEnum.dogWinning.name,cardNum: 10,unlock: 1),
      PsnACardBean(cardType: PsnACardTypeEnum.kingOfCards.name,cardNum: 10,unlock: 1),
      PsnACardBean(cardType: PsnACardTypeEnum.fruitLineup.name,cardNum: 10,unlock: 1),
      PsnACardBean(cardType: PsnACardTypeEnum.numberWinner.name,cardNum: 10,unlock: 1),
    ];
    for (var value in cardList) {
      database.insert(PsnRootSqlName.aCardNum, value.toJson());
    }
  }

  Future<List<PsnACardBean>> getCardList()async{
    var database = await PsnRootSqlUtils.instance.initSql();
    var list = await database.query(PsnRootSqlName.aCardNum);
    if(list.isEmpty){
      return [];
    }
    List<PsnACardBean> result=[];
    for (var value in list) {
      result.add(PsnACardBean.fromJson(value));
    }
    return result;
  }

  Future<int> updateCardNum(PsnACardTypeEnum cardType,int num)async{
    var database = await PsnRootSqlUtils.instance.initSql();
    var list = await database.query(PsnRootSqlName.aCardNum,where: '"cardType" = ?',whereArgs: [cardType.name]);
    if(list.isEmpty){
      return 0;
    }
    var first = list.first;
    var cardBean = PsnACardBean.fromJson(first);
    var cardNum = cardBean.cardNum??0;
    if(cardNum<=0&&num<0){
      return 0;
    }
    cardBean.cardNum=cardNum+num;
    if((cardBean.cardNum??0)>10){
      cardBean.cardNum=10;
    }
    await database.update(PsnRootSqlName.aCardNum, cardBean.toJson(),where: '"id" = ?',whereArgs: [first["id"]]);
    PsnRootEventUtils.instance.sendEvent(code: PsnAEventCode.updateCardNum,anyValue: cardType);
    return cardBean.cardNum??0;
  }

  Future<int> getCardNumByType(PsnACardTypeEnum cardType)async{
    var database = await PsnRootSqlUtils.instance.initSql();
    var list = await database.query(PsnRootSqlName.aCardNum,where: '"cardType" = ?',whereArgs: [cardType.name]);
    if(list.isEmpty){
      return 0;
    }
    var first = list.first;
    var cardBean = PsnACardBean.fromJson(first);
    return cardBean.cardNum??0;
  }

  Future<PsnACardBean?> getCardBeanByCardType(PsnACardTypeEnum cardType)async{
    var database = await PsnRootSqlUtils.instance.initSql();
    var list = await database.query(PsnRootSqlName.aCardNum,where: '"cardType" = ?',whereArgs: [cardType.name]);
    if(list.isEmpty){
      return null;
    }
    return PsnACardBean.fromJson(list.first);
  }

  //每个卡牌增加一次
  addAllCardNum()async{
    var database = await PsnRootSqlUtils.instance.initSql();
    var list = await database.query(PsnRootSqlName.aCardNum);
    if(list.isEmpty){
      return [];
    }
    for (var value in list) {
      var bean = PsnACardBean.fromJson(value);
      if((bean.cardNum??0)<10){
        bean.cardNum=(bean.cardNum??0)+1;
        await database.update(PsnRootSqlName.aCardNum, bean.toJson(),where: '"id" = ?',whereArgs: [value["id"]]);
        PsnRootEventUtils.instance.sendEvent(code: PsnAEventCode.updateCardNum,anyValue: PsnACardTypeEnum.values.byName(bean.cardType??""));
      }
    }
  }

  unlockCard(PsnACardTypeEnum cardType)async{
    var database = await PsnRootSqlUtils.instance.initSql();
    var list = await database.query(PsnRootSqlName.aCardNum,where: '"cardType" = ?',whereArgs: [cardType.name]);
    if(list.isEmpty){
      return;
    }
    var first = list.first;
    var cardBean = PsnACardBean.fromJson(first);
    cardBean.unlock=0;
    await database.update(PsnRootSqlName.aCardNum, cardBean.toJson(),where: '"id" = ?',whereArgs: [first["id"]]);    PsnRootEventUtils.instance.sendEvent(code: PsnAEventCode.updateCardNum,anyValue: cardType);
    PsnRootEventUtils.instance.sendEvent(code: PsnAEventCode.updateHomeCard,anyValue: cardType);
  }

  updateUserCoins(int addNum){
    if(addNum==0){
      return;
    }
    aUserCoins.saveData(aUserCoins.getData()+addNum);
    PsnRootEventUtils.instance.sendEvent(code: PsnAEventCode.updateCoins);
  }

  bool updatePlayNum(){
    aUserPlayNum.saveData(aUserPlayNum.getData()+1);
    PsnRootEventUtils.instance.sendEvent(code: PsnAEventCode.updatePlayNum);
    return [5, 15, 25, 35, 45].contains(aUserPlayNum.getData());
  }
}