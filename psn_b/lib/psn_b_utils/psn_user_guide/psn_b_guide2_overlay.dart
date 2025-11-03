import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_widget/psn_b_guaka_animator_widget.dart';
import 'package:psn_b/psn_b_widget/psn_b_guide_text_widget.dart';
import 'package:psn_root/psn_root_widget/psn_click.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';

class PsnBGuide2Overlay extends StatelessWidget{
  Offset offset;
  Size size;
  Function() clickCallback;
  PsnBGuide2Overlay({
    required this.offset,
    required this.size,
    required this.clickCallback,
});

  @override
  Widget build(BuildContext context) => Material(
    type: MaterialType.transparency,
    child: PsnClick(
      fromGuide: true,
      onTap: (){
        clickCallback.call();
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black.withOpacity(0.7),
        child: Stack(
          children: [
            Positioned(
              top: offset.dy,
              left: offset.dx,
              child: SizedBox(
                width: size.width,
                height: size.height,
                child: Stack(
                  children: [
                    PsnImageWidget(name: "lucky5",width: size.width,height: size.height,),
                    PsnBGuakaAnimatorWidget(),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: offset.dy+size.height),
                child: PsnBGuideTextWidget(text: "Simple scratch, grab big cash easy!"),
              ),
            )
          ],
        ),
      ),
    ),
  );
}