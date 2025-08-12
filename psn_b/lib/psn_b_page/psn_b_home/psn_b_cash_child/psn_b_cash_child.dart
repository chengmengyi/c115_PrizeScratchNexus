import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_page/psn_b_home/psn_b_cash_child/psn_b_cash_child_con.dart';
import 'package:psn_root/psn_root_page/psn_root_child.dart';

class PsnBCashChild extends PsnRootChild<PsnBCashChildCon>{
  @override
  PsnBCashChildCon onCon() => PsnBCashChildCon();

  @override
  Widget onCreate() => Container();
}