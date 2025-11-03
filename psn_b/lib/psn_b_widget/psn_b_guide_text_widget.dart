import 'package:flutter/material.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';
import 'package:psn_root/psn_root_widget/psn_text_widget.dart';

class PsnBGuideTextWidget extends StatelessWidget{
  String text;
  PsnBGuideTextWidget({
    required this.text,
});
  
  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    margin: EdgeInsets.only(left: 43.w,right: 43.w),
    child: Stack(
      alignment: Alignment.topCenter,
      children: [
        PsnImageWidget(name: "icon_sanjiao",width: 25.w,height: 25.w,),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          margin: EdgeInsets.only(top: 12.h,),
          decoration: BoxDecoration(
            color: "#FFFFFF".toColor(),
            borderRadius: BorderRadius.circular(16.w),
          ),
          child: PsnTextWidget(text: text, size: 12.sp, color: "#373F42".toColor(),),
        ),
      ],
    ),
  );
}