import 'package:flutter/material.dart';
import 'package:psn_a/psn_a_dialog/psn_a_get_more_dialog/psn_a_get_more_dialog.dart';
import 'package:psn_a/psn_a_utils/psn_a_play_utils.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_widget/psn_click.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';

class PsnABottomBtnWidget extends StatelessWidget{
  PsnAPlayUtils playUtils;
  PsnABottomBtnWidget({required this.playUtils});

  @override
  Widget build(BuildContext context) => Row(
    children: [
      SizedBox(width: 34.w,),
      PsnClick(
        onTap: (){
          PsnRootRouters.instance.router(
            routersEnum: PsnRoutersEnum.dialog,
            content: PsnAGetMoreDialog(
              cardTypeEnum: playUtils.cardTypeEnum,
            ),
          );
        },
        child: PsnImageWidget(name: "bottom1",width: 267.w,height: 107.h,),
      ),
      Spacer(),
      PsnClick(
        onTap: (){
          playUtils.startAutoScratch();
        },
        child: PsnImageWidget(name: "bottom2",width: 325.w,height: 107.h,),
      ),
      SizedBox(width: 34.w,),
    ],
  );
}