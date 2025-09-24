import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_storage/psn_b_storage.dart';
import 'package:psn_b/psn_b_utils/psn_b_event_code.dart';
import 'package:psn_b/psn_b_utils/psn_user_guide/psn_b_guide1_overlay.dart';
import 'package:psn_root/psn_root_event/psn_root_event_utils.dart';
import 'package:psn_root/psn_root_utils/psn_tba/psn_b_tba_utils.dart';
import 'package:psn_root/psn_root_utils/psn_tba_point_enum.dart';

class PsnBUserGuideUtils{
  static final PsnBUserGuideUtils _utils = PsnBUserGuideUtils();
  static PsnBUserGuideUtils get instance => _utils;

  OverlayEntry? _overlayEntry;
  var _newUserGuideStep=1;

  showPlayGuideStep1({
    required BuildContext context,
    required GlobalKey key,
    required Function() clickCallback,
}){
    if(_newUserGuideStep!=1||!bShowNewUserGuide.getData()){
      return;
    }
    var renderBox = key.currentContext!.findRenderObject() as RenderBox;
    var offset = renderBox.localToGlobal(Offset.zero);
    PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.newuser_guide,params: {"pop_step":"pop1"});
    showOverlay(
      context: context,
      widget: PsnBGuide1Overlay(
        offset: offset,
        clickCallback: (){
          hideOverlay();
          _newUserGuideStep=2;
          clickCallback.call();
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