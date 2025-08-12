import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:psn_b/psn_b_bean/psn_b_card_bean.dart';
import 'package:psn_b/psn_b_dialog/psn_b_get_more_dialog/psn_b_get_more_dialog.dart';
import 'package:psn_b/psn_b_dialog/psn_b_level_up_dialog/psn_b_level_up_dialog.dart';
import 'package:psn_b/psn_b_dialog/psn_b_unlock_dialog/psn_b_unlock_dialog.dart';
import 'package:psn_b/psn_b_utils/pns_b_card_type_enum.dart';
import 'package:psn_b/psn_b_utils/psn_b_event_code.dart';
import 'package:psn_b/psn_b_utils/psn_b_user_info_utils.dart';
import 'package:psn_b/psn_b_utils/psn_b_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_con.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';

class PsnBCardChildCon extends PsnRootCon{
  var currentIndex=0;
  List<PsnBCardBean> cardList=[];
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _startAddNumTimer();
  }

  @override
  void onReady() {
    super.onReady();
    _initCard();
  }

  toPlay()async{
    if(cardList.isEmpty){
      return;
    }
    var cardBean = cardList[currentIndex];
    var cardTypeEnum = PsnBCardTypeEnum.values.byName(cardBean.cardType??"");
    if(cardBean.unlock==1){
      PsnRootRouters.instance.router(
        routersEnum: PsnRoutersEnum.dialog,
        content: PsnBUnlockDialog(
          typeEnum: cardTypeEnum,
        ),
      );
      return;
    }
    var cardNum = await PsnBUserInfoUtils.instance.getCardNumByType(cardTypeEnum);
    if(cardNum<=0){
      PsnRootRouters.instance.router(
        routersEnum: PsnRoutersEnum.dialog,
        content: PsnBGetMoreDialog(
          cardTypeEnum: cardTypeEnum,
          clickClose: (){},
        ),
      );
      return;
    }
    var routerName = getRouterNameByCardType(cardTypeEnum);
    if(routerName.isEmpty){
      return;
    }
    PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.toNamed, content: routerName);
  }

  onPageChanged(index){
    currentIndex=index;
    update(["indicator"]);
  }

  _initCard()async{
    var list = await PsnBUserInfoUtils.instance.getCardList();
    cardList.clear();
    cardList.addAll(list);
    update(["list","indicator"]);
  }

  String getCardIcon(PsnBCardBean bean){
    switch(PsnBCardTypeEnum.values.byName(bean.cardType??"")){
      case PsnBCardTypeEnum.lucky7: return "home_card_lucky";
      case PsnBCardTypeEnum.collectorWin:
        if(bean.unlock==1){
          return "home_card_collector_lock";
        }
        return "home_card_collector";
      case PsnBCardTypeEnum.dogWinning:
        if(bean.unlock==1){
          return "home_card_dog_lock";
        }
        return "home_card_dog";
      case PsnBCardTypeEnum.kingOfCards:
        if(bean.unlock==1){
          return "home_card_king_lock";
        }
        return "home_card_king";
      case PsnBCardTypeEnum.fruitLineup:
        if(bean.unlock==1){
          return "home_card_fruit_lock";
        }
        return "home_card_fruit";
      case PsnBCardTypeEnum.numberWinner:
        if(bean.unlock==1){
          return "home_card_number_lock";
        }
        return "home_card_number";
    }
  }

  @override
  bool initEvent() => true;

  @override
  receivedEventBus(int code, int? intValue, String? strValue, anyValue) {
    switch(code){
      case PsnBEventCode.updateHomeCard:
        _initCard();
        break;
    }
  }

  _startAddNumTimer(){
    _timer=Timer.periodic(Duration(seconds: 180), (timer){
      PsnBUserInfoUtils.instance.addAllCardNum();
    });
  }

  test(){
    if(!kDebugMode){
      return;
    }
    PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.dialog, content: PsnBLevelUpDialog(totalReward: 1, dismissCallback: (){}));
  }

  @override
  void onClose() {
    _timer?.cancel();
    _timer=null;
    super.onClose();
  }
}