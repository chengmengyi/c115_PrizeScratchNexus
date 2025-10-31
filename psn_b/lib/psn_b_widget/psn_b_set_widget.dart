import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_dialog/psn_b_set_dialog/psn_b_set_dialog.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_widget/psn_click.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';

class PsnBSetWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) => PsnClick(
    onTap: (){
      PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.dialog, content: PsnBSetDialog());
    },
    child: PsnImageWidget(name: "icon_set",width: 44.w,height: 44.h,),
  );

}