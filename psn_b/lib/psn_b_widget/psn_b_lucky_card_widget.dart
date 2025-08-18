import 'dart:math';

import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_utils/psn_b_event_code.dart';
import 'package:psn_b/psn_b_utils/psn_b_value_utils.dart';
import 'package:psn_root/psn_root_event/psn_root_event_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_statefull.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_widget/psn_click.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';
import 'package:psn_root/psn_root_widget/psn_text_widget.dart';

class PsnBLuckyCardWidget extends PsnRootStateful{
  int index;
  Function() startLuckyCardFlipAnimator;
  Function(double reward) clickCardAnimatorEnd;
  PsnBLuckyCardWidget({
    required this.index,
    required this.startLuckyCardFlipAnimator,
    required this.clickCardAnimatorEnd,
});

  @override
  State<StatefulWidget> createState() =>PsnBLuckyCardWidgetState();

}
class PsnBLuckyCardWidgetState extends PsnRootStatefulState<PsnBLuckyCardWidget> with SingleTickerProviderStateMixin {
  late AnimationController _luckyCardController;
  late Animation<double> _luckyCardAnimation;
  var isFront=false,canClick=true,reward=0.0,clickItemIndex=-1,showMissIcon=false;

  @override
  void initState() {
    super.initState();
    _initAnimator();
    reward=PsnBValueUtils.instance.getLuckyCardReward();
  }

  @override
  Widget build(BuildContext context) => PsnClick(
    onTap: (){
      _clickCard();
    },
    child: AnimatedBuilder(
      animation: _luckyCardAnimation,
      builder: (context, child) {
        var angle = _luckyCardAnimation.value * pi;
        var transform = Matrix4.identity()..setEntry(3, 2, 0.001)..rotateY(angle);
        return Transform(
          transform: transform,
          alignment: Alignment.center,
          child: Opacity(
            opacity: angle <= pi / 2 ? 1 : 0,
            child: isFront ?
            _frontWidget() :
            Transform(
              transform: Matrix4.identity()..rotateY(3.1415926),
              alignment: Alignment.center,
              child: _backgroundWidget(),
            ),
          ),
        );
      },
    ),
  );

  _backgroundWidget()=>PsnImageWidget(name: "card2",width: double.infinity,height: 209.h,);

  _frontWidget()=>SizedBox(
    width: double.infinity,
    height: 209.h,
    child: Stack(
      children: [
        PsnImageWidget(name: "card3",width: double.infinity,height: 209.h,),
        Align(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PsnImageWidget(name: "icon_money3",width: 116.w,height: 80.h,),
              SizedBox(height: 10.h,),
              PsnTextWidget(text: "\$$reward", size: 28.sp, color: "#FFD52C".toColor(),outlineColor: "#000000".toColor(),),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Visibility(
            visible: showMissIcon,
            child: Container(
              margin: EdgeInsets.only(top: 10.h),
              child: PsnImageWidget(name: "card4",width: 120.w,height: 34.h,),
            ),
          ),
        )
      ],
    ),
  );

  _clickCard(){
    if(!canClick){
      return;
    }
    clickItemIndex=widget.index;
    PsnRootEventUtils.instance.sendEvent(code: PsnBEventCode.startLuckyCardFlipAnimator);
    _luckyCardController.forward();
    widget.startLuckyCardFlipAnimator.call();
  }

  _initAnimator(){
    _luckyCardController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _luckyCardAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _luckyCardController,
        curve: Curves.easeInOut,
      ),
    );
    _luckyCardController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _clickItemFlipAnimatorEnd();
      }
    });
  }

  _clickItemFlipAnimatorEnd()async{
    setState(() {
      isFront=!isFront;
    });
    _luckyCardController.reverse();
    if(clickItemIndex==widget.index){
      await Future.delayed(Duration(milliseconds: 1000));
      PsnRootEventUtils.instance.sendEvent(code: PsnBEventCode.flipOtherLuckyCard,intValue: widget.index);
      widget.clickCardAnimatorEnd.call(reward);
    }
  }

  @override
  bool initEvent() => true;

  @override
  receivedEventBus(int code, int? intValue, String? strValue, anyValue) {
    switch(code){
      case PsnBEventCode.startLuckyCardFlipAnimator:
        canClick=false;
        break;
      case PsnBEventCode.flipOtherLuckyCard:
        _flipOtherLuckyCard(intValue);
        break;
    }
  }

  _flipOtherLuckyCard(int? intValue){
    if(intValue==widget.index){
      return;
    }
    setState(() {
      showMissIcon=true;
      reward=_randomReduce();
    });
    _luckyCardController.forward();
  }

  double _randomReduce() {
    final random = Random();
    final reducePercent = 0.2 + random.nextDouble() * 0.8;
    final reducedValue = reward * (1 - reducePercent);
    return max(0, (reducedValue * 100).floor() / 100);
  }

  @override
  void dispose() {
    _luckyCardController.dispose();
    super.dispose();
  }
}