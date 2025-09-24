import 'package:flutter/material.dart';
import 'package:psn_root/psn_root_page/psn_root_statefull.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';

class PsnPlayLogoAnimatorWidget extends PsnRootStateful{
  String image;
  double width;
  double height;
  PsnPlayLogoAnimatorWidget({
    required this.image,
    required this.width,
    required this.height,
});
  @override
  State<StatefulWidget> createState() => _PsnPlayLogoAnimatorWidgetState();
}

class _PsnPlayLogoAnimatorWidgetState extends PsnRootStatefulState<PsnPlayLogoAnimatorWidget> with SingleTickerProviderStateMixin{

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _initAnimator();
  }

  @override
  Widget build(BuildContext context) => ScaleTransition(
    scale: _animation,
    child: PsnImageWidget(name: widget.image,width: widget.width,height: widget.height,),
  );

  _initAnimator()async{
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _animation = Tween<double>(begin: 0.8, end: 1.0)
        .animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}