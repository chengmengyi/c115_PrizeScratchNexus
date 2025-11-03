import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_bean/psn_b_card_bean.dart';
import 'package:psn_b/psn_b_storage/psn_b_storage.dart';
import 'package:psn_b/psn_b_utils/psn_b_event_code.dart';
import 'package:psn_b/psn_b_utils/psn_user_guide/psn_b_box_guide_overlay.dart';
import 'package:psn_b/psn_b_utils/psn_user_guide/psn_b_guide1_overlay.dart';
import 'package:psn_b/psn_b_utils/psn_user_guide/psn_b_guide2_overlay.dart';
import 'package:psn_b/psn_b_utils/psn_user_guide/psn_b_guide4_overlay.dart';
import 'package:psn_root/psn_root_event/psn_root_event_utils.dart';
import 'package:psn_root/psn_root_utils/psn_b_android_notification_utils.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_utils/psn_tba/psn_b_tba_utils.dart';
import 'package:psn_root/psn_root_utils/psn_tba_point_enum.dart';

class PsnBUserGuideUtils{
  static final PsnBUserGuideUtils _utils = PsnBUserGuideUtils();
  static PsnBUserGuideUtils get instance => _utils;

  OverlayEntry? _overlayEntry;
  var _newUserGuideStep=1;

  showPlayGuideStep1({
    required BuildContext context,
    required GlobalKey playBtnGlobalKey,
    required GlobalKey firstPlayCardGlobalKey,
    required GlobalKey boxGlobalKey,
    required PsnBCardBean value,
    required Function() step1Callback,
}){
    if(!bShowNewUserGuide.getData()){
      _checkShowOldUserGuide(context: context, globalKey: boxGlobalKey,);
      return;
    }
    var playBtnRenderBox = playBtnGlobalKey.currentContext!.findRenderObject() as RenderBox;
    var playBtnOffset = playBtnRenderBox.localToGlobal(Offset.zero);

    var firstPlayCardRenderBox = firstPlayCardGlobalKey.currentContext!.findRenderObject() as RenderBox;
    var firstPlayCardOffset = firstPlayCardRenderBox.localToGlobal(Offset.zero);
    var firstPlayCardSize = firstPlayCardRenderBox.size;

    PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.newuser_guide,params: {"pop_step":"pop1"});
    bShowNewUserGuide.saveData(false);
    showOverlay(
      context: context,
      widget: PsnBGuide1Overlay(
        playBtnOffset: playBtnOffset,
        firstPlayCardOffset: firstPlayCardOffset,
        firstPlayCardSize: firstPlayCardSize,
        value: value,
        clickCallback: (){
          hideOverlay();
          _newUserGuideStep=2;
          step1Callback.call();
        },
      ),
    );
  }

  bool checkShowGuaKaAnimatorStep2(){
    if(_newUserGuideStep!=2||!bShowNewUserGuide.getData()){
      return false;
    }
    PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.newuser_guide,params: {"pop_step":"pop2"});
    return true;
  }

  showUserGuideStep2({
    required BuildContext context,
    required Offset offset,
    required Size size,
    required Function() dismissCallback,
}){
    showOverlay(
      context: context,
      widget: PsnBGuide2Overlay(
        offset: offset,
        size: size,
        clickCallback: (){
          hideOverlay();
          _newUserGuideStep=3;
          dismissCallback.call();
        },
      ),
    );
  }

  setGuideStep3(){
    if(_newUserGuideStep==2){
      _newUserGuideStep=3;
    }
  }

  bool checkShowStep3(){
    if(_newUserGuideStep!=3||!bShowNewUserGuide.getData()){
      return false;
    }
    PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.newuser_guide,params: {"pop_step":"pop3"});
    return true;
  }

  setGuideStep4(){
    if(_newUserGuideStep==4){
      return;
    }
    _newUserGuideStep=4;
    bShowNewUserGuide.saveData(false);
    PsnRootEventUtils.instance.sendEvent(code: PsnBEventCode.showTopMoneyFinger);
  }

  showUserGuideStep4({
    required BuildContext context,
    required Offset offset,
    required Size size,
  }){
    showOverlay(
      context: context,
      widget: PsnBGuide4Overlay(
        offset: offset,
        size: size,
        dismissCallback: (){
          hideOverlay();
          _newUserGuideStep=5;
        },
      ),
    );
  }

  _checkShowOldUserGuide({
    required BuildContext context,
    required GlobalKey globalKey,
}){
    if(bLastShowBoxGuideTimer.getData()==getTodayTimeStr()){
      return;
    }
    bLastShowBoxGuideTimer.saveData(getTodayTimeStr());
    var renderBox = globalKey.currentContext?.findRenderObject() as RenderBox;
    var offset = renderBox.localToGlobal(Offset.zero);
    showOverlay(
      context: context,
      widget: PsnBBoxGuideOverlay(
        offset: offset,
        dismissCallback: (){
          hideOverlay();
          PsnRootEventUtils.instance.sendEvent(code: PsnBEventCode.clickBox);
        },
      ),
    );
  }

  showOverlay({
    required BuildContext context,
    required Widget widget,
  }){
    _overlayEntry=OverlayEntry(builder: (_)=>widget);
    Overlay.of(context).insert(_overlayEntry!);
  }

  hideOverlay(){
    _overlayEntry?.remove();
    _overlayEntry=null;
  }
}