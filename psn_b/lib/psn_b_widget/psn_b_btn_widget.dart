import 'package:flutter/material.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_widget/psn_click.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';
import 'package:psn_root/psn_root_widget/psn_text_widget.dart';

class PsnBBtnWidget extends StatelessWidget{
  String text;
  String bgName;
  bool showVideoIcon;
  double? width;
  Widget? leftIcon;
  Function()? onTap;
  PsnBBtnWidget({
    required this.text,
    required this.bgName,
    this.leftIcon,
    this.showVideoIcon=false,
    this.onTap,
    this.width,
});

  @override
  Widget build(BuildContext context) => PsnClick(
    onTap: (){
      onTap?.call();
    },
    child: SizedBox(
      width: width??148.w,
      height: 53.h,
      child: Stack(
        children: [
          PsnImageWidget(name: bgName,width: double.infinity,height: double.infinity,),
          Align(
            alignment: Alignment.center,
            child:  Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                leftIcon??Container(),
                PsnTextWidget(text: text, size: 21.sp, color: "#F2F3F3".toColor(),outlineColor: "#090733".toColor(),),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Visibility(
              visible: showVideoIcon,
              child: PsnImageWidget(name: "icon_video",width: 26.w,height: 26.w,),
            ),
          )
        ],
      ),
    ),
  );
}