import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_utils/psn_b_event_code.dart';
import 'package:psn_root/psn_root_page/psn_root_statefull.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_widget/psn_click.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';

class PsnWheelAnimatorWidget extends PsnRootStateful{
  GlobalKey endGlobalKey;
  PsnWheelAnimatorWidget({
    required this.endGlobalKey,
});
  @override
  State<StatefulWidget> createState() => _PsnWheelAnimatorWidgetState();
}

class _PsnWheelAnimatorWidgetState extends PsnRootStatefulState<PsnWheelAnimatorWidget> with SingleTickerProviderStateMixin {
  var showAnimator=false;

  late AnimationController _controller;
  Animation<Offset>? _posAnim;
  Animation<double>? _scaleAnim;
  final GlobalKey _containerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
  }

  @override
  Widget build(BuildContext context){
    if(!showAnimator){
      return Visibility(
        visible: false,
        maintainAnimation: true,
        maintainState: true,
        maintainSize: true,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          key: _containerKey,
        ),
      );
    }
    return Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      key: _containerKey,
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final pos = _posAnim!.value;
              final scale = _scaleAnim!.value;
              return Positioned(
                left: pos.dx-143.w,
                top: pos.dy,
                width: 143.w,
                height: 134.h,
                child: Transform.scale(
                  scale: scale,
                  child: child,
                ),
              );
            },
            child: PsnImageWidget(name: "icon_wheel",width: 143.w,height: 134.h,),
          ),
        ],
      ),
    );
  }

  _startAnimator()async{
    final RenderBox box = _containerKey.currentContext!.findRenderObject() as RenderBox;
    final Offset containerPos = box.localToGlobal(Offset.zero);
    final Size containerSize = box.size;

    // 起点：容器的中心
    final Offset start = containerPos + Offset(containerSize.width / 2, containerSize.height / 2);

    // 终点：容器右上角（x + width），y 固定 143
    final Offset end = Offset(containerPos.dx + containerSize.width, 130.h);
    final curved = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _posAnim = Tween<Offset>(begin: start, end: end).animate(curved);
    _scaleAnim = Tween<double>(begin: 0, end: 1).animate(curved);
    setState(() {
      showAnimator=true;
    });

    await _controller.forward(from: 0);
    setState(() {
      showAnimator=false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  bool initEvent() => true;

  @override
  receivedEventBus(int code, int? intValue, String? strValue, anyValue) {
    switch(code){
      case PsnBEventCode.showWheelAnimator:
        _startAnimator();
        break;
    }
  }
}