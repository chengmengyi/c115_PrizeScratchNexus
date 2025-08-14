import 'package:psn_b/psn_b_bean/psn_cash_task_bean.dart';

class PsbCashListBean{
  int money;
  PsnCashTaskBean? cashTaskBean;
  PsbCashListBean({
    required this.money,
    this.cashTaskBean,
});
}