import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_bean/psn_b_card_bean.dart';
import 'package:psn_b/psn_b_bean/psn_rank_bean.dart';
import 'package:psn_b/psn_b_dialog/psn_b_cash_tips_dialog/psn_b_cash_tips_dialog.dart';
import 'package:psn_b/psn_b_dialog/psn_b_get_more_dialog/psn_b_get_more_dialog.dart';
import 'package:psn_b/psn_b_dialog/psn_b_level_up_dialog/psn_b_level_up_dialog.dart';
import 'package:psn_b/psn_b_dialog/psn_b_lucky_card_dialog/psn_b_lucky_card_dialog.dart';
import 'package:psn_b/psn_b_dialog/psn_b_no_net_dialog/psn_b_no_net_dialog.dart';
import 'package:psn_b/psn_b_dialog/psn_b_unlock_dialog/psn_b_unlock_dialog.dart';
import 'package:psn_b/psn_b_dialog/psn_box_dialog/psn_box_dialog.dart';
import 'package:psn_b/psn_b_dialog/psn_rank_dialog/psn_rank_dialog.dart';
import 'package:psn_b/psn_b_dialog/psn_rank_tips_animator_dialog/psn_rank_tips_animator_dialog.dart';
import 'package:psn_b/psn_b_storage/psn_b_storage.dart';
import 'package:psn_b/psn_b_utils/pns_b_card_type_enum.dart';
import 'package:psn_b/psn_b_utils/psn_b_cash_utils.dart';
import 'package:psn_b/psn_b_utils/psn_b_event_code.dart';
import 'package:psn_b/psn_b_utils/psn_b_play_utils.dart';
import 'package:psn_b/psn_b_utils/psn_b_user_info_utils.dart';
import 'package:psn_b/psn_b_utils/psn_b_utils.dart';
import 'package:psn_b/psn_b_utils/psn_b_value_utils.dart';
import 'package:psn_b/psn_b_utils/psn_user_guide/psn_b_user_guide_utils.dart';
import 'package:psn_root/psn_b_dialog/psn_b_ad_fail_dialog/psn_b_ad_fail_dialog.dart';
import 'package:psn_root/psn_b_dialog/psn_b_ad_limit_dialog/psn_b_ad_limit_dialog.dart';
import 'package:psn_root/psn_root_page/psn_root_con.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';
import 'package:psn_root/psn_root_utils/psn_fb_utils.dart';
import 'package:psn_root/psn_root_utils/psn_fengk/psn_fengk_utils.dart';
import 'package:psn_root/psn_root_utils/psn_firebase_utils.dart';
import 'package:psn_root/psn_root_utils/psn_local_info.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_utils/psn_tba/psn_b_tba_utils.dart';
import 'package:psn_root/psn_root_utils/psn_tba_point_enum.dart';

class PsnBCardChildCon extends PsnRootCon{
  var currentIndex=0;
  List<PsnBCardBean> cardList=[];
  Timer? _timer;
  GlobalKey playBtnGlobalKey=GlobalKey();

  @override
  void onInit() {
    super.onInit();
    _startAddNumTimer();
    PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.home_page);
  }

  @override
  void onReady() {
    super.onReady();
    _initCard();
    PsnBUserGuideUtils.instance.showPlayGuideStep1(
      context: context,
      key: playBtnGlobalKey,
      clickCallback: (){
        toPlay();
      },
    );
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
      case PsnBCardTypeEnum.lucky7: return "home_card_lucky2";
      case PsnBCardTypeEnum.collectorWin:
        if(bean.unlock==1){
          return "home_card_collector_lock2";
        }
        return "home_card_collector2";
      case PsnBCardTypeEnum.dogWinning:
        if(bean.unlock==1){
          return "home_card_dog_lock2";
        }
        return "home_card_dog2";
      case PsnBCardTypeEnum.kingOfCards:
        if(bean.unlock==1){
          return "home_card_king_lock2";
        }
        return "home_card_king2";
      case PsnBCardTypeEnum.fruitLineup:
        if(bean.unlock==1){
          return "home_card_fruit_lock2";
        }
        return "home_card_fruit2";
      case PsnBCardTypeEnum.numberWinner:
        if(bean.unlock==1){
          return "home_card_number_lock2";
        }
        return "home_card_number2";
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

  toMoreGame(){
    PsnRootRouters.instance.router(
      routersEnum: PsnRoutersEnum.toNamed,
      content: "/root/web",
      params: {"url": PsnLocalInfo.moreGame,"title":"More Fun"},
    );
  }

  test(){
    if(!kDebugMode){
      return;
    }
    // PsnBUserGuideUtils.instance.showPlayGuideStep1(
    //   context: context,
    //   key: playBtnGlobalKey,
    //   clickCallback: (){
    //     toPlay();
    //   },
    // );
    
    // PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.dialog, content: PsnBLuckyCardDialog(dismissCallback: (){}));

    // PsnBCashUtils.instance.updateCashTask(TaskType.ad);

    // PsnBUserInfoUtils.instance.updateUserCoins(200);

    // print("kk=====${PsnFengkUtils.instance.isFk()}");

    // PsnFirebaseUtils.instance.test();

    // bAlreadyShowCashTipsDialog.saveData(false);
    // PsnBUserInfoUtils.instance.updateUserCoins(-200);

    PsnBUserInfoUtils.instance.updateUserCoins(200);
    // PsnBCashUtils.instance.updateCashTask(TaskType.lucky);
    // PsnBValueUtils.instance.initValue();

    // PsnBCashUtils.instance.queryRankProgress(1000, CashType.pay);
    // PsnBCashUtils.instance.createRankProgress(1000, CashType.pay);

    // PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.dialog, content: PsnRankDialog(
    //   rankBean: PsnRankBean(currentRank: 111,totalRank: 222),
    // ));

  }

  @override
  void onClose() {
    _timer?.cancel();
    _timer=null;
    super.onClose();
  }
}