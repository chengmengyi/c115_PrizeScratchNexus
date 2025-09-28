import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_dialog/psn_b_get_more_dialog/psn_b_get_more_dialog.dart';
import 'package:psn_b/psn_b_utils/psn_b_play_utils.dart';
import 'package:psn_b/psn_b_widget/psn_bottom_left_card_widget.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_widget/psn_click.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';

class PsnBBottomBtnWidget extends StatelessWidget{
  PsnBPlayUtils playUtils;
  PsnBBottomBtnWidget({required this.playUtils});

  @override
  Widget build(BuildContext context) => Row(
    children: [
      SizedBox(width: 34.w,),
      // PsnClick(
      //   onTap: (){
      //     PsnRootRouters.instance.router(
      //       routersEnum: PsnRoutersEnum.dialog,
      //       content: PsnBGetMoreDialog(
      //         cardTypeEnum: playUtils.cardTypeEnum,
      //       ),
      //     );
      //   },
      //   child: PsnImageWidget(name: "bottom1",width: 267.w,height: 107.h,),
      // ),
      PsnBottomLeftCardWidget(),
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