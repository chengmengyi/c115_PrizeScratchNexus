import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_page/psn_b_home/psn_b_wheel_child/psn_b_wheel_child_con.dart';
import 'package:psn_root/psn_root_page/psn_root_child.dart';

class PsnBWheelChild extends PsnRootChild<PsnBWheelChildCon>{
  @override
  PsnBWheelChildCon onCon() => PsnBWheelChildCon();

  @override
  Widget onCreate() => Container();
}