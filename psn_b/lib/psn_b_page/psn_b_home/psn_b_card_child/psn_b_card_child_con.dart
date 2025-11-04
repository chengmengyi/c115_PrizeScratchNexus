import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_bean/psb_cash_list_bean.dart';
import 'package:psn_b/psn_b_bean/psn_b_card_bean.dart';
import 'package:psn_b/psn_b_bean/psn_cash_task_bean.dart';
import 'package:psn_b/psn_b_bean/psn_rank_bean.dart';
import 'package:psn_b/psn_b_dialog/psn_b_big_win_dialog/psn_b_big_win_dialog.dart';
import 'package:psn_b/psn_b_dialog/psn_b_cash_success_dialog/psn_b_cash_success_dialog.dart';
import 'package:psn_b/psn_b_dialog/psn_b_cash_tips_dialog/psn_b_cash_tips_dialog.dart';
import 'package:psn_b/psn_b_dialog/psn_b_fail_dialog/psn_b_fail_dialog.dart';
import 'package:psn_b/psn_b_dialog/psn_b_get_money_dialog/psn_b_get_money_dialog.dart';
import 'package:psn_b/psn_b_dialog/psn_b_get_more_dialog/psn_b_get_more_dialog.dart';
import 'package:psn_b/psn_b_dialog/psn_b_input_account_dialog/psn_b_input_account_dialog.dart';
import 'package:psn_b/psn_b_dialog/psn_b_input_pix_account_dialog/psn_b_input_pix_account_dialog.dart';
import 'package:psn_b/psn_b_dialog/psn_b_level_up_dialog/psn_b_level_up_dialog.dart';
import 'package:psn_b/psn_b_dialog/psn_b_lucky_card_dialog/psn_b_lucky_card_dialog.dart';
import 'package:psn_b/psn_b_dialog/psn_b_no_money_dialog/psn_b_no_money_dialog.dart';
import 'package:psn_b/psn_b_dialog/psn_b_no_net_dialog/psn_b_no_net_dialog.dart';
import 'package:psn_b/psn_b_dialog/psn_b_normal_win_dialog/psn_b_normal_win_dialog.dart';
import 'package:psn_b/psn_b_dialog/psn_b_set_dialog/psn_b_set_dialog.dart';
import 'package:psn_b/psn_b_dialog/psn_b_unlock_dialog/psn_b_unlock_dialog.dart';
import 'package:psn_b/psn_b_dialog/psn_box_dialog/psn_box_dialog.dart';
import 'package:psn_b/psn_b_dialog/psn_cash_init_animator_dialog/psn_cash_init_animator_dialog.dart';
import 'package:psn_b/psn_b_dialog/psn_cash_last_step_success_dialog/psn_cash_last_step_success_dialog.dart';
import 'package:psn_b/psn_b_dialog/psn_dont_worry_dialog/psn_dont_worry_dialog.dart';
import 'package:psn_b/psn_b_dialog/psn_new_cash_task_dialog/psn_new_cash_task_dialog.dart';
import 'package:psn_b/psn_b_dialog/psn_rank_dialog/psn_rank_dialog.dart';
import 'package:psn_b/psn_b_dialog/psn_rank_tips_animator_dialog/psn_rank_tips_animator_dialog.dart';
import 'package:psn_b/psn_b_dialog/psn_safe_check_dialog/psn_safe_check_dialog.dart';
import 'package:psn_b/psn_b_dialog/psn_safe_check_dialog/psn_safe_check_dialog_con.dart';
import 'package:psn_b/psn_b_routers/psn_b_page_list.dart';
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
import 'package:psn_root/psn_b_dialog/psn_b_no_notification_permission_dialog/psn_b_no_notification_permission_dialog.dart';
import 'package:psn_root/psn_root_event/psn_root_event_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_con.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';
import 'package:psn_root/psn_root_utils/psn_fb_utils.dart';
import 'package:psn_root/psn_root_utils/psn_fengk/psn_fengk_utils.dart';
import 'package:psn_root/psn_root_utils/psn_firebase_utils.dart';
import 'package:psn_root/psn_root_utils/psn_local_info.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_utils/psn_tba/psn_b_tba_utils.dart';
import 'package:psn_root/psn_root_utils/psn_tba_point_enum.dart';

class PsnBCardChildCon extends PsnRootCon{
  var currentIndex=0;
  List<PsnBCardBean> cardList=[];
  Timer? _timer;
  GlobalKey firstPlayCardGlobalKey=GlobalKey();
  GlobalKey playBtnGlobalKey=GlobalKey();
  GlobalKey boxGlobalKey=GlobalKey();
  CarouselSliderControllerImpl carouselSliderControllerImpl=CarouselSliderControllerImpl();

  @override
  void onInit() {
    super.onInit();
    _startAddNumTimer();
    PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.home_page);
  }

  @override
  void onReady() {
    super.onReady();
    _initCard(showUserGuide: true);
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
    _toPlayPage(cardTypeEnum);
  }

  onPageChanged(index){
    currentIndex=index;
    update(["indicator"]);
  }

  _initCard({bool showUserGuide=false})async{
    var list = await PsnBUserInfoUtils.instance.getCardList();
    cardList.clear();
    cardList.addAll(list);
    update(["list","indicator"]);
    if(showUserGuide&&cardList.isNotEmpty){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        PsnBUserGuideUtils.instance.showPlayGuideStep1(
          context: context,
          playBtnGlobalKey: playBtnGlobalKey,
          firstPlayCardGlobalKey: firstPlayCardGlobalKey,
          value: cardList.first,
          boxGlobalKey: boxGlobalKey,
          step1Callback: (){
            toPlay();
          },
        );
      });
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
      case PsnBEventCode.noMoneyClickPlayNow:
        _noMoneyClickPlayNow();
        break;
      case PsnBEventCode.toNextLockTypeAndUnlock:
        _toNextLockTypeAndUnlock();
        break;
    }
  }

  _toNextLockTypeAndUnlock()async{
    var indexWhere = cardList.indexWhere((value)=>value.unlock==1);
    if(indexWhere>=0){
      carouselSliderControllerImpl.animateToPage(indexWhere);
      await Future.delayed(Duration(milliseconds: 400));
      var cardBean = cardList[indexWhere];
      PsnRootEventUtils.instance.sendEvent(code: PsnBEventCode.showLockAnimator,anyValue: cardBean.cardType);
      await Future.delayed(Duration(milliseconds: 1000));
      var cardTypeEnum = PsnBCardTypeEnum.values.byName(cardBean.cardType??"");
      await PsnBUserInfoUtils.instance.unlockCard(cardTypeEnum);
      _initCard();
      _toPlayPage(cardTypeEnum);
    }else{
      carouselSliderControllerImpl.animateToPage(cardList.length-1);
    }
  }

  _noMoneyClickPlayNow()async{
    var cardBean = await PsnBUserInfoUtils.instance.getHasPlayNumAndUnlockCardBean();
    if(null!=cardBean){
      var cardTypeEnum = PsnBCardTypeEnum.values.byName(cardBean.cardType??"");
      _toPlayPage(cardTypeEnum);
    }
  }

  _toPlayPage(PsnBCardTypeEnum cardTypeEnum){
    var routerName = getRouterNameByCardType(cardTypeEnum);
    if(routerName.isEmpty){
      return;
    }
    PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.toNamed, content: routerName);
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

    // PsnBUserInfoUtils.instance.updateUserCoins(200);
    // PsnBCashUtils.instance.updateCashTask(TaskType.lucky);
    // PsnBValueUtils.instance.initValue();

    // PsnBCashUtils.instance.queryRankProgress(1000, CashType.pay);
    // PsnBCashUtils.instance.createRankProgress(1000, CashType.pay);

    PsnRootRouters.instance.router(
      routersEnum: PsnRoutersEnum.dialog,
      content: PsnSafeCheckDialog(
        account: "dwidiwj@qq.com",
        safeCheckType: SafeCheckType.success,
        dismissCallback: (){},
      ),
    );

    // Navigator.push(context, MaterialPageRoute(builder: (_)=>FireballDemo()));
  }

  @override
  void onClose() {
    _timer?.cancel();
    _timer=null;
    super.onClose();
  }
}