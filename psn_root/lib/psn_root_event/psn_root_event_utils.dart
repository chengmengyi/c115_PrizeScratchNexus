import 'dart:async';
import 'package:event_bus/event_bus.dart';

class PsnRootEventUtils {
  static final PsnRootEventUtils _utils=PsnRootEventUtils();
  static PsnRootEventUtils get instance => _utils;

  final EventBus _event=EventBus();

  sendEvent({
    required int code,
    int? intValue,
    String? strValue,
    dynamic anyValue,
}){
    _event.fire({"code":code,"intValue":intValue,"strValue":strValue,"anyValue":anyValue});
  }

  StreamSubscription<Map<String,dynamic>> registerEvent({
    required Function(Map<String,dynamic> map) callback,
  }){
    return _event.on<Map<String,dynamic>>().listen((map) {
      callback.call(map);
    });
  }
}