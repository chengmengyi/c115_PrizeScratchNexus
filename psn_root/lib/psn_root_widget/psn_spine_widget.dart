import 'package:flutter/material.dart';
import 'package:spine_flutter/spine_flutter.dart';

class PsnSpineWidget extends StatelessWidget{
  String atlasFile;
  String skeletonFile;
  String animatorName;
  String folder;
  double width;
  double height;
  BoxFit? fit;
  SpineWidgetController? controller;
  PsnSpineWidget({
    required this.atlasFile,
    required this.skeletonFile,
    required this.animatorName,
    required this.folder,
    required this.width,
    required this.height,
    this.fit,
    this.controller,
  });
  @override
  Widget build(BuildContext context) => SizedBox(
    width: width,
    height: height,
    child: SpineWidget.fromAsset(
      "assets/spine/$folder/$atlasFile.atlas",
      "assets/spine/$folder/$skeletonFile.json",
      controller??SpineWidgetController(
        onInitialized: (controller) {
          controller.animationState.setAnimationByName(0, animatorName, true);
        },
      ),
      fit: fit??BoxFit.fill,
    ),
  );
}