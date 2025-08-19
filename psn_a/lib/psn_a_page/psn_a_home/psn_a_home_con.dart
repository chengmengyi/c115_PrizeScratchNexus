import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:psn_a/psn_a_bean/psn_a_card_bean.dart';
import 'package:psn_a/psn_a_dialog/psn_a_get_more_dialog/psn_a_get_more_dialog.dart';
import 'package:psn_a/psn_a_dialog/psn_a_unlock_dialog/psn_a_unlock_dialog.dart';
import 'package:psn_a/psn_a_routers/psn_a_page_list.dart';
import 'package:psn_a/psn_a_utils/pns_a_card_type_enum.dart';
import 'package:psn_a/psn_a_utils/psn_a_event_code.dart';
import 'package:psn_a/psn_a_utils/psn_a_user_info_utils.dart';
import 'package:psn_a/psn_a_utils/psn_a_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_con.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';
import 'package:psn_root/psn_root_utils/psn_music_utils.dart';

class PsnAHomeCon extends PsnRootCon{
  var currentIndex=0;
  List<PsnACardBean> cardList=[];
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _startAddNumTimer();
    PsnMusicUtils.instance.initPlayer();
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
    var cardTypeEnum = PsnACardTypeEnum.values.byName(cardBean.cardType??"");
    if(cardBean.unlock==1){
      PsnRootRouters.instance.router(
        routersEnum: PsnRoutersEnum.dialog,
        content: PsnAUnlockDialog(
          typeEnum: cardTypeEnum,
        ),
      );
      return;
    }
    var cardNum = await PsnAUserInfoUtils.instance.getCardNumByType(cardTypeEnum);
    if(cardNum<=0){
      PsnRootRouters.instance.router(
        routersEnum: PsnRoutersEnum.dialog,
        content: PsnAGetMoreDialog(
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
    var list = await PsnAUserInfoUtils.instance.getCardList();
    cardList.clear();
    cardList.addAll(list);
    update(["list","indicator"]);
  }

  String getCardIcon(PsnACardBean bean){
    switch(PsnACardTypeEnum.values.byName(bean.cardType??"")){
      case PsnACardTypeEnum.lucky7: return "home_card_lucky";
      case PsnACardTypeEnum.collectorWin:
        if(bean.unlock==1){
          return "home_card_collector_lock";
        }
        return "home_card_collector";
      case PsnACardTypeEnum.dogWinning:
        if(bean.unlock==1){
          return "home_card_dog_lock";
        }
        return "home_card_dog";
      case PsnACardTypeEnum.kingOfCards:
        if(bean.unlock==1){
          return "home_card_king_lock";
        }
        return "home_card_king";
      case PsnACardTypeEnum.fruitLineup:
        if(bean.unlock==1){
          return "home_card_fruit_lock";
        }
        return "home_card_fruit";
      case PsnACardTypeEnum.numberWinner:
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
      case PsnAEventCode.updateHomeCard:
        _initCard();
        break;
    }
  }

  _startAddNumTimer(){
    _timer=Timer.periodic(Duration(seconds: 180), (timer){
      PsnAUserInfoUtils.instance.addAllCardNum();
    });
  }

  test(){
    if(!kDebugMode){
      return;
    }
    PsnAUserInfoUtils.instance.updateUserCoins(10000);
  }

  @override
  void onClose() {
    _timer?.cancel();
    _timer=null;
    super.onClose();
  }
}