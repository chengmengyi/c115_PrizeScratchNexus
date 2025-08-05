import 'dart:async';

import 'package:flutter/material.dart';
import 'package:psn_root/psn_root_event/psn_root_event_utils.dart';

abstract class PsnRootStateful extends StatefulWidget{
}

abstract class PsnRootStatefulState<T extends PsnRootStateful> extends State<T>{
  StreamSubscription<Map<String,dynamic>>? _ss;

  @override
  void initState() {
    if(initEvent()){
      _ss=PsnRootEventUtils.instance.registerEvent(
        callback: (map){
          receivedEventBus(map["code"],map["intValue"],map["strValue"],map["anyValue"]);
        },
      );
    }
    super.initState();
  }

  bool initEvent()=>false;

  receivedEventBus(int code,int? intValue,String? strValue,dynamic anyValue){}

  @override
  void dispose() {
    if(initEvent()){
      _ss?.cancel();
      _ss=null;
    }
    super.dispose();
  }
}