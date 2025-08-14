import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_bean/psn_b_bottom_btn_bean.dart';
import 'package:psn_b/psn_b_page/psn_b_home/psn_b_card_child/psn_b_card_child.dart';
import 'package:psn_b/psn_b_page/psn_b_home/psn_b_cash_child/psn_b_cash_child.dart';
import 'package:psn_b/psn_b_page/psn_b_home/psn_b_wheel_child/psn_b_wheel_child.dart';
import 'package:psn_b/psn_b_utils/psn_b_event_code.dart';
import 'package:psn_b/psn_b_utils/psn_music_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_con.dart';

class PsnBHomeCon extends PsnRootCon{
  var tabIndex=0;
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
  }

  clickBottomBtn(index){
    if(tabIndex==index){
      return;
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
    }
  }
}