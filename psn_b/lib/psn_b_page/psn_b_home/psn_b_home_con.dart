import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_bean/psn_b_bottom_btn_bean.dart';
import 'package:psn_b/psn_b_page/psn_b_home/psn_b_card_child/psn_b_card_child.dart';
import 'package:psn_b/psn_b_page/psn_b_home/psn_b_cash_child/psn_b_cash_child.dart';
import 'package:psn_b/psn_b_page/psn_b_home/psn_b_wheel_child/psn_b_wheel_child.dart';
import 'package:psn_b/psn_b_utils/psn_b_cash_utils.dart';
import 'package:psn_b/psn_b_utils/psn_b_event_code.dart';
import 'package:psn_b/psn_b_utils/psn_wheel_utils.dart';
import 'package:psn_root/psn_root.dart';
import 'package:psn_root/psn_root_page/psn_root_con.dart';
import 'package:psn_root/psn_root_utils/psn_ad_utils.dart';
import 'package:psn_root/psn_root_utils/psn_applife_utils.dart';
import 'package:psn_root/psn_root_utils/psn_b_android_notification_utils.dart';
import 'package:psn_root/psn_root_utils/psn_fengk/psn_fengk_utils.dart';
import 'package:psn_root/psn_root_utils/psn_music_utils.dart';
import 'package:psn_root/psn_root_utils/psn_tba/psn_b_tba_utils.dart';
import 'package:psn_root/psn_root_utils/psn_tba_point_enum.dart';

class PsnBHomeCon extends PsnRootCon{
  var tabIndex=0,wheelNum=0;
  List<Widget> pageList=[
    PsnBCardChild(),
    PsnBWheelChild(),
    PsnBCashChild(),
  ];
  List<PsnBBottomBtnBean> bottomList=[
    PsnBBottomBtnBean(icon: "home_card", text: "home_card_text"),
    PsnBBottomBtnBean(icon: "home_wheel", text: "home_wheel_text"),
    PsnBBottomBtnBean(icon: "home_cash", text: "home_cash_text"),
  ];

  @override
  void onInit() {
    super.onInit();
    PsnMusicUtils.instance.initPlayer();
    PsnBAndroidNotificationUtils.instance.initNotification();
    PsnApplifeUtils.instance.addLife();
    PsnFengkUtils.instance.initFengK();
    PsnRoot.instance.openPsnH();
    PsnAdUtils.instance.lookAdCallback=(){
      PsnBCashUtils.instance.updateCashTask(TaskType.ad);
    };
  }

  clickBottomBtn(index){
    if(tabIndex==index){
      return;
    }
    if(index==0){
      PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.home_page);
    }
    if(index==1){
      PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.wheel_c);
    }
    if(index==2){
      PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.cash_page);
    }
    tabIndex=index;
    update(["page"]);
  }

  String getBg()=>tabIndex==0?"bg1":tabIndex==1?"wheel_bg":"cash_bg";

  @override
  bool initEvent() => true;

  @override
  receivedEventBus(int code, int? intValue, String? strValue, anyValue) {
    switch(code){
      case PsnBEventCode.showHomeIndex:
        clickBottomBtn(intValue??0);
        break;
      case PsnBEventCode.updateWheelNum:
        _updateWheelNum();
        break;
    }
  }


  _updateWheelNum()async{
    wheelNum=await PsnWheelUtils.instance.getWheelNum();
    update(["wheel_num"]);
  }

  @override
  void onClose() {
    PsnAdUtils.instance.lookAdCallback=null;
    super.onClose();
  }
}