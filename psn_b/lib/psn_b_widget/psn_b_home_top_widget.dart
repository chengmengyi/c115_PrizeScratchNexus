import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_utils/psn_b_event_code.dart';
import 'package:psn_b/psn_b_widget/psn_b_coins_widget.dart';
import 'package:psn_b/psn_b_widget/psn_b_level_widget.dart';
import 'package:psn_b/psn_b_widget/psn_b_set_widget.dart';
import 'package:psn_root/psn_root_event/psn_root_event_utils.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_widget/psn_click.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';

class PsnBHomeTopWidget extends StatelessWidget{

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: EdgeInsets.only(bottom: 18.h),
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
          SizedBox(width: 9.w,),
          Expanded(
            child: PsnClick(
              onTap: (){
                PsnRootEventUtils.instance.sendEvent(code: PsnBEventCode.showHomeIndex,intValue: 2);
              },
              child: PsnBCoinsWidget(),
            ),
          ),
          SizedBox(width: 9.w,),
          Expanded(child: PsnBLevelWidget(),),
          SizedBox(width: 50.w,),
          PsnBSetWidget(),
          SizedBox(width: 9.w,),
        ],
      ),
    ),
  );
}