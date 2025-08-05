
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';

class PsnRootRouters {
  static final PsnRootRouters _routers=PsnRootRouters();
  static PsnRootRouters get instance => _routers;

  router({
    required PsnRoutersEnum routersEnum,
    required dynamic content,
    Map<String, dynamic>? params,
  }){
    switch(routersEnum){
      case PsnRoutersEnum.toNamed:
        Get.toNamed(content as String,arguments: params);
        break;
      case PsnRoutersEnum.offNamed:
        Get.offNamed(content as String);
        break;
      case PsnRoutersEnum.back:
        Get.back();
        break;
      case PsnRoutersEnum.dialog:
        Get.dialog(
          content as Widget,
          barrierDismissible: false,
        );
        break;
    }
  }

  Map<String, dynamic> getPrams(){
    try {
      return Get.arguments as Map<String, dynamic>;
    } catch (e) {
      return {};
    }
  }
}