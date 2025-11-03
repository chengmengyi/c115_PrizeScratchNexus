import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_utils/psn_b_event_code.dart';
import 'package:psn_b/psn_b_utils/psn_b_play_utils.dart';
import 'package:psn_b/psn_b_utils/psn_b_user_info_utils.dart';
import 'package:psn_b/psn_b_widget/psn_b_meteor_item_widget.dart';
import 'package:psn_root/psn_root_event/psn_root_event_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_statefull.dart';

class PsnBMeteorWidget extends PsnRootStateful{
  PsnBPlayUtils playUtils;
  PsnBMeteorWidget({
    required this.playUtils,
});
  @override
  State<StatefulWidget> createState() => _PsnBMeteorWidgetState();
}

class _PsnBMeteorWidgetState extends PsnRootStatefulState<PsnBMeteorWidget>{
  List<PsnBMeteorItemWidget> widgetList=[];

  @override
  Widget build(BuildContext context) {
    if(widgetList.isEmpty){
      return Container();
    }
    return Stack(
      children: widgetList,
    );
  }

  @override
  bool initEvent() => true;

  @override
  receivedEventBus(int code, int? intValue, String? strValue, anyValue) {
    switch(code){
      case PsnBEventCode.showMeteor:
        _showMeteor();
        break;
    }
  }

  _showMeteor()async{
    var list = widget.playUtils.contentList.where((value)=>value.win).toList();
    widgetList.clear();
    if(list.isNotEmpty){
      PsnBUserInfoUtils.instance.updateBottomLeftCardNum(list.length*5);
      for (var value in list) {
        widgetList.add(
          PsnBMeteorItemWidget(
            key: UniqueKey(),
            bean: value,
            bottomLeftGlobalKey: widget.playUtils.bottomLeftGlobalKey,
          ),
        );
      }
      setState(() {});
      await Future.delayed(Duration(milliseconds: 800));
      setState(() {
        widgetList.clear();
      });
      PsnRootEventUtils.instance.sendEvent(code: PsnBEventCode.updateCardProgress);
    }else{
      setState(() {});
    }
  }
}