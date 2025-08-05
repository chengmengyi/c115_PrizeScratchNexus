import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psn_root/psn_root_event/psn_root_event_utils.dart';

class PsnRootCon extends GetxController{
  late BuildContext context;
  StreamSubscription<Map<String,dynamic>>? _ss;

  bool initEvent()=>false;

  @override
  void onInit() {
    super.onInit();
    if(initEvent()){
      _ss=PsnRootEventUtils.instance.registerEvent(
        callback: (map){
          receivedEventBus(map["code"],map["intValue"],map["strValue"],map["anyValue"]);
        },
      );
    }
  }

  receivedEventBus(int code,int? intValue,String? strValue,dynamic anyValue){}

  @override
  void onClose() {
    if(initEvent()){
      _ss?.cancel();
      _ss=null;
    }
    super.onClose();
  }
}