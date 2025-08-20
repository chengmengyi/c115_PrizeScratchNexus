import 'package:psn_b/psn_b_bean/psn_b_card_bean.dart';
import 'package:psn_b/psn_b_dialog/psn_b_cash_tips_dialog/psn_b_cash_tips_dialog.dart';
import 'package:psn_b/psn_b_storage/psn_b_storage.dart';
import 'package:psn_b/psn_b_utils/pns_b_card_type_enum.dart';
import 'package:psn_b/psn_b_utils/psn_b_event_code.dart';
import 'package:psn_b/psn_b_utils/psn_b_value_utils.dart';
import 'package:psn_root/psn_root_event/psn_root_event_utils.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';
import 'package:psn_root/psn_root_utils/psn_fengk/psn_fengk_utils.dart';
import 'package:psn_root/psn_root_utils/psn_root_sql/psn_root_sql_name.dart';
import 'package:psn_root/psn_root_utils/psn_root_sql/psn_root_sql_utils.dart';
import 'package:psn_root/psn_root_utils/psn_root_storage.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_utils/psn_tba/psn_b_tba_utils.dart';
import 'package:psn_root/psn_root_utils/psn_tba_point_enum.dart';

class PsnBUserInfoUtils {
  static final PsnBUserInfoUtils _utils = PsnBUserInfoUtils();
  static PsnBUserInfoUtils get instance => _utils;

  initCardInfo()async{
    var database = await PsnRootSqlUtils.instance.initSql();
    var list = await database.query(PsnRootSqlName.bCardNum);
    if(list.isNotEmpty){
      return;
    }
    var cardList=[
      PsnBCardBean(cardType: PsnBCardTypeEnum.lucky7.name,cardNum: 10,unlock: 0),
      PsnBCardBean(cardType: PsnBCardTypeEnum.collectorWin.name,cardNum: 10,unlock: 1),
      PsnBCardBean(cardType: PsnBCardTypeEnum.dogWinning.name,cardNum: 10,unlock: 1),
      PsnBCardBean(cardType: PsnBCardTypeEnum.kingOfCards.name,cardNum: 10,unlock: 1),
      PsnBCardBean(cardType: PsnBCardTypeEnum.fruitLineup.name,cardNum: 10,unlock: 1),
      PsnBCardBean(cardType: PsnBCardTypeEnum.numberWinner.name,cardNum: 10,unlock: 1),
    ];
    for (var value in cardList) {
      database.insert(PsnRootSqlName.bCardNum, value.toJson());
    }
  }

  Future<List<PsnBCardBean>> getCardList()async{
    var database = await PsnRootSqlUtils.instance.initSql();
    var list = await database.query(PsnRootSqlName.bCardNum);
    if(list.isEmpty){
      return [];
    }
    List<PsnBCardBean> result=[];
    for (var value in list) {
      result.add(PsnBCardBean.fromJson(value));
    }
    return result;
  }

  Future<int> updateCardNum(PsnBCardTypeEnum cardType,int num)async{
    var database = await PsnRootSqlUtils.instance.initSql();
    var list = await database.query(PsnRootSqlName.bCardNum,where: '"cardType" = ?',whereArgs: [cardType.name]);
    if(list.isEmpty){
      return 0;
    }
    var first = list.first;
    var cardBean = PsnBCardBean.fromJson(first);
    var cardNum = cardBean.cardNum??0;
    if(cardNum<=0&&num<0){
      return 0;
    }
    cardBean.cardNum=cardNum+num;
    if((cardBean.cardNum??0)>10){
      cardBean.cardNum=10;
    }
    await database.update(PsnRootSqlName.bCardNum, cardBean.toJson(),where: '"id" = ?',whereArgs: [first["id"]]);
    PsnRootEventUtils.instance.sendEvent(code: PsnBEventCode.updateCardNum,anyValue: cardType);
    return cardBean.cardNum??0;
  }

  Future<int> getCardNumByType(PsnBCardTypeEnum cardType)async{
    var database = await PsnRootSqlUtils.instance.initSql();
    var list = await database.query(PsnRootSqlName.bCardNum,where: '"cardType" = ?',whereArgs: [cardType.name]);
    if(list.isEmpty){
      return 0;
    }
    var first = list.first;
    var cardBean = PsnBCardBean.fromJson(first);
    return cardBean.cardNum??0;
  }

  Future<PsnBCardBean?> getCardBeanByCardType(PsnBCardTypeEnum cardType)async{
    var database = await PsnRootSqlUtils.instance.initSql();
    var list = await database.query(PsnRootSqlName.bCardNum,where: '"cardType" = ?',whereArgs: [cardType.name]);
    if(list.isEmpty){
      return null;
    }
    return PsnBCardBean.fromJson(list.first);
  }

  //每个卡牌增加一次
  addAllCardNum()async{
    var database = await PsnRootSqlUtils.instance.initSql();
    var list = await database.query(PsnRootSqlName.bCardNum);
    if(list.isEmpty){
      return [];
    }
    for (var value in list) {
      var bean = PsnBCardBean.fromJson(value);
      if((bean.cardNum??0)<10){
        bean.cardNum=(bean.cardNum??0)+1;
        await database.update(PsnRootSqlName.bCardNum, bean.toJson(),where: '"id" = ?',whereArgs: [value["id"]]);
        PsnRootEventUtils.instance.sendEvent(code: PsnBEventCode.updateCardNum,anyValue: PsnBCardTypeEnum.values.byName(bean.cardType??""));
      }
    }
  }

  unlockCard(PsnBCardTypeEnum cardType)async{
    var database = await PsnRootSqlUtils.instance.initSql();
    var list = await database.query(PsnRootSqlName.bCardNum,where: '"cardType" = ?',whereArgs: [cardType.name]);
    if(list.isEmpty){
      return;
    }
    var first = list.first;
    var cardBean = PsnBCardBean.fromJson(first);
    cardBean.unlock=0;
    await database.update(PsnRootSqlName.bCardNum, cardBean.toJson(),where: '"id" = ?',whereArgs: [first["id"]]);    PsnRootEventUtils.instance.sendEvent(code: PsnBEventCode.updateCardNum,anyValue: cardType);
    PsnRootEventUtils.instance.sendEvent(code: PsnBEventCode.updateHomeCard,anyValue: cardType);
  }

  updateUserCoins(double addNum){
    if(addNum==0){
      return;
    }
    bUserCoins.saveData(twoNumAdd(bUserCoins.getData(), addNum));
    PsnRootEventUtils.instance.sendEvent(code: PsnBEventCode.updateCoins);
    if(addNum>0){
      var moneyLevel = bLastCoinsLevel.getData()+100;
      var data = bUserCoins.getData();
      if(data>=moneyLevel){
        var max = ((bUserCoins.getData()-moneyLevel)~/100)+1;
        for(var index=0; index<max; index++){
          PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.cash_money_detail,params: {"money":moneyLevel});
          bLastCoinsLevel.saveData(moneyLevel);
          moneyLevel+=100;
        }
      }

      var first = PsnBValueUtils.instance.getCashList().first;
      var getRewardNum = psnRewardRevenuePaidNum.getData();
      var wrongDeemAdLess = PsnFengkUtils.instance.getWrongDeemAdLess();
      if(data>=first&&getRewardNum<wrongDeemAdLess){
        psnDeemAdLess.saveData(true);
      }
      var wrongDeemAdMore = PsnFengkUtils.instance.getWrongDeemAdMore();
      if(data<first&&getRewardNum>=wrongDeemAdMore){
        psnDeemAdMore.saveData(true);
      }

      if(data>=first&&!bAlreadyShowCashTipsDialog.getData()){
        bAlreadyShowCashTipsDialog.saveData(true);
        PsnRootRouters.instance.router(
          routersEnum: PsnRoutersEnum.dialog,
          content:  PsnBCashTipsDialog(),
        );
      }
    }
  }

  bool updatePlayNum(){
    bUserPlayNum.saveData(bUserPlayNum.getData()+1);
    PsnRootEventUtils.instance.sendEvent(code: PsnBEventCode.updatePlayNum);
    return [5, 15, 25, 35, 45].contains(bUserPlayNum.getData());
  }
}