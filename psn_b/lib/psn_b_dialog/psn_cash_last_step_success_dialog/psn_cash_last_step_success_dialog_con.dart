import 'package:psn_b/psn_b_bean/psn_rank_bean.dart';
import 'package:psn_b/psn_b_utils/psn_b_cash_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_con.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';
import 'package:psn_root/psn_root_utils/psn_tba/psn_b_tba_utils.dart';
import 'package:psn_root/psn_root_utils/psn_tba_point_enum.dart';

class PsnCashLastStepSuccessDialogCon extends PsnRootCon{

  @override
  void onInit() {
    super.onInit();
    PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.funds_received);
  }

  clickSure(PsnRankBean rankBean)async{
    await PsnBCashUtils.instance.deleteRankProgress(rankBean);
    PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
  }
}