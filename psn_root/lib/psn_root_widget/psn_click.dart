import 'package:flutter/material.dart';
import 'package:psn_root/psn_root_widget/psn_tap_scale_widget.dart';

class PsnClick extends StatelessWidget{
  Widget? child;
  bool fromGuide;
  Function()? onTap;
  PsnClick({
    this.child,
    this.fromGuide=false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) => PsnTapScaleWidget(
    fromGuide: fromGuide,
    onTap: (){
      onTap?.call();
    },
    child: child??Container(),
  );
}