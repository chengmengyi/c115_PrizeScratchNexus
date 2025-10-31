import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_storage/psn_b_storage.dart';
import 'package:psn_b/psn_b_utils/psn_b_event_code.dart';
import 'package:psn_root/psn_root_event/psn_root_event_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_statefull.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_widget/psn_click.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';

class PsnBottomLeftCardWidget extends PsnRootStateful{
  @override
  State<StatefulWidget> createState() => _PsnBottomLeftCardWidgetState();
}

class _PsnBottomLeftCardWidgetState extends PsnRootStatefulState<PsnBottomLeftCardWidget> with SingleTickerProviderStateMixin{
  var currentIndex=0;
  GlobalKey globalKey=GlobalKey();
  late AnimationController _controller;
  late Animation<double> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _initAnimator();
    _getProgress();
  }

  @override
  Widget build(BuildContext context) => Stack(
    alignment: Alignment.bottomLeft,
    children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            key: globalKey,
            child: AnimatedBuilder(
              animation: _offsetAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(_offsetAnimation.value, 0),
                  child: child,
                );
              },
              child: PsnClick(
                onTap: (){
                  _startShake();
                },
                child: PsnImageWidget(name: currentIndex>=2?"card6":"card5",width: 70.w,height: 68.h,),
              ),
            ),
          ),
          SizedBox(width: 5.w,),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _circleItemWidget(0),
              SizedBox(height: 8.h,),
              Container(
                margin: EdgeInsets.only(left: 12.w),
                child: _circleItemWidget(1),
              ),
              SizedBox(height: 8.h,),
              _circleItemWidget(2),
            ],
          ),
        ],
      ),
      PsnImageWidget(name: "card7",height: 15.h,boxFit: BoxFit.fitHeight,),
    ],
  );

  _circleItemWidget(index)=>PsnImageWidget(name: currentIndex>index?"card9":"card8",width: 11.w,height: 11.w,);

  _startShake() {
    if(currentIndex>=2){
      return;
    }
    "Scratching 3 cards will trigger the lucky card flip.".showToast();
    _controller.forward(from: 0);
  }

  @override
  bool initEvent() => true;

  @override
  receivedEventBus(int code, int? intValue, String? strValue, anyValue) {
    switch(code){
      case PsnBEventCode.updateCardProgress:
        _getProgress();
        break;
    }
  }

  _initAnimator(){
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _offsetAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -10.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -10.0, end: 10.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 10.0, end: -10.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -10.0, end: 10.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 10.0, end: -10.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -10.0, end: 0.0), weight: 1),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  _getProgress()async{
    setState(() {
      currentIndex = bCardProgress.getData();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      if(currentIndex>=3){
        var renderBox = globalKey.currentContext?.findRenderObject() as RenderBox;
        var offset = renderBox.localToGlobal(Offset.zero);
        PsnRootEventUtils.instance.sendEvent(code: PsnBEventCode.showBottomLeftCardAnimator,anyValue: offset);
        await Future.delayed(Duration(milliseconds: 1000));
        bCardProgress.saveData(0);
        setState(() {
          currentIndex=0;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}