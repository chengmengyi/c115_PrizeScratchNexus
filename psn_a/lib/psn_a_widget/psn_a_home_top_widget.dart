import 'package:flutter/material.dart';
import 'package:psn_a/psn_a_widget/psn_a_coins_widget.dart';
import 'package:psn_a/psn_a_widget/psn_a_level_widget.dart';
import 'package:psn_a/psn_a_widget/psn_a_set_widget.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_widget/psn_click.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';

class PsnAHomeTopWidget extends StatelessWidget{

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: EdgeInsets.only(bottom: 36.h),
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/top_bg.webp'),
        fit: BoxFit.fill,
      ),
    ),
    child: SafeArea(
      top: true,
      child: Row(
        children: [
          SizedBox(width: 18.w,),
          Expanded(child: PsnACoinsWidget(),),
          SizedBox(width: 18.w,),
          Expanded(child: PsnALevelWidget(),),
          SizedBox(width: 100.w,),
          PsnASetWidget(),
          SizedBox(width: 18.w,),
        ],
      ),
    ),
  );
}