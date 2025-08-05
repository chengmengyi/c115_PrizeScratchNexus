import 'package:flutter/material.dart';
import 'package:psn_a/psn_a_routers/psn_a_page_list.dart';
import 'package:psn_root/psn_root_page/psn_root_con.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';

class PsnLaunchCon extends PsnRootCon with GetSingleTickerProviderStateMixin{
  late AnimationController progressAnimationController;

  @override
  void onInit() {
    super.onInit();
    progressAnimationController=AnimationController(duration: const Duration(seconds: 3),vsync: this)
      ..addListener(() {
        update(["pro","pro_text"]);
      })
      ..addStatusListener((status) {
        if(status==AnimationStatus.completed){
          toHome();
        }
      })..forward();
  }

  toHome(){
    PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.offNamed, content: PsnAPageName.home);
  }

  @override
  void onClose() {
    progressAnimationController.dispose();
    super.onClose();
  }
}