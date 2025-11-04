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
  late Function() clickCallback;

  PsnCashInitAnimatorDialogCon(this.clickCallback);

  @override
  void onInit() {
    super.onInit();
    PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.payment_animation);
    _initAnimator();
  }

  clickConfirm(){
    PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.payment_failed_c);
    PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
    clickCallback.call();
  }

  _initAnimator(){
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    animation = Tween<double>(begin: 0, end: 42.h).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reset();
          _controller.forward();
        }
      });
    _controller.forward();
    Future.delayed(const Duration(seconds: 4), () {
      _controller.stop();
      clickConfirm();
    });
  }

  @override
  void onClose() {
    _controller.dispose();
    super.onClose();
  }
}