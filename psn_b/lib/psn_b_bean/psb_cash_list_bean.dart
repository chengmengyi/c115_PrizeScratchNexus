import 'package:psn_b/psn_b_bean/psn_cash_task_bean.dart';
import 'package:psn_b/psn_b_bean/psn_rank_bean.dart';

class PsbCashListBean{
  int money;
  PsnCashTaskBean? cashTaskBean;
  PsnRankBean? rankProgress;
  PsbCashListBean({
    required this.money,
    this.cashTaskBean,
    this.rankProgress,
});
}