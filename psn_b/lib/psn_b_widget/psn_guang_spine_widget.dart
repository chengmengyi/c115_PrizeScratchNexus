import 'package:flutter/material.dart';
import 'package:psn_root/psn_root_widget/psn_spine_widget.dart';

class PsnGuangSpineWidget extends StatelessWidget{
  double width;
  double height;
  PsnGuangSpineWidget({
    required this.width,
    required this.height,
});

  @override
  Widget build(BuildContext context) => PsnSpineWidget(
    atlasFile: "gg",
    skeletonFile: "skeleton",
    animatorName: "animation",
    folder: "guang",
    width: width,
    height: height,
  );
}