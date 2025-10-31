import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_utils/psn_b_event_code.dart';
import 'package:psn_root/psn_root_page/psn_root_statefull.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';

class PsnBottomLeftCardAnimatorWidget extends PsnRootStateful{
  @override
  State<StatefulWidget> createState() => _PsnBottomLeftCardAnimatorWidgetState();
}

class _PsnBottomLeftCardAnimatorWidgetState extends PsnRootStatefulState<PsnBottomLeftCardAnimatorWidget> with SingleTickerProviderStateMixin{
  Offset? startOffset;
  Offset? endOffset;
  late AnimationController _controller;
  late Animation<Offset> _positionAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
  }

  @override
  Widget build(BuildContext context) {
    if(null==startOffset||null==endOffset){
      return Container();
    }
    return Stack(
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Positioned(
              left: _positionAnimation.value.dx,
              top: _positionAnimation.value.dy,
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: PsnImageWidget(name: "card6",width: 70.w,height: 68.h,),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  bool initEvent() => true;

  @override
  receivedEventBus(int code, int? intValue, String? strValue, anyValue) {
    switch(code){
      case PsnBEventCode.showBottomLeftCardAnimator:
        showBottomLeftCardAnimator(anyValue);
        break;
    }
  }

  showBottomLeftCardAnimator(anyValue)async{
    final screenSize = MediaQuery.of(context).size;
    setState(() {
      startOffset=anyValue;
      endOffset=Offset(screenSize.width / 2, screenSize.height / 2,);
    });
    _positionAnimation = Tween<Offset>(
      begin: startOffset,
      end: endOffset,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 2.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    await _controller.forward(from: 0);
    setState(() {
      startOffset=null;
      endOffset=null;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}