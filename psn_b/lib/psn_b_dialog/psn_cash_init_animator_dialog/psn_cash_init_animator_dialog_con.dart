import 'package:flutter/material.dart';
import 'package:psn_root/psn_root_page/psn_root_con.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_tba/psn_b_tba_utils.dart';
import 'package:psn_root/psn_root_utils/psn_tba_point_enum.dart';

class PsnCashInitAnimatorDialogCon extends PsnRootCon with GetSingleTickerProviderStateMixin{
  var showFail=false;
  late AnimationController _controller;
  late Animation<double> animation;

  @override
  void onInit() {
    super.onInit();
    _initAnimator();
  }

  clickConfirm(Function() clickCallback){
    PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.payment_failed_c);
    PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
    clickCallback.call();
  }

  _initAnimator(){
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    animation = Tween<double>(begin: 0, end: 50.w).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reset();
          _controller.forward();
        }
      });
    _controller.forward();
    Future.delayed(const Duration(seconds: 4), () {
      _controller.stop();
      showFail=true;
      update(["icon","text","btn"]);
    });
  }

  @override
  void onClose() {
    _controller.dispose();
    super.onClose();
  }
}