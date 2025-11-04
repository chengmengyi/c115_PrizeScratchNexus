import 'package:psn_b/psn_b_bean/psn_cash_task_bean.dart';
import 'package:psn_b/psn_b_utils/psn_b_cash_utils.dart';
import 'package:psn_b/psn_b_utils/psn_b_event_code.dart';
import 'package:psn_root/psn_root_event/psn_root_event_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_con.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';
import 'package:psn_root/psn_root_utils/psn_tba/psn_b_tba_utils.dart';
import 'package:psn_root/psn_root_utils/psn_tba_point_enum.dart';

class PsnBCashSuccessDialogCon extends PsnRootCon{

  @override
  void onInit() {
    super.onInit();
    PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.task_congratulation);
  }

  clickClose(){
    PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
  }

  clickSure(Function() callback)async{
    PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.request_congra_c);
    PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
    callback.call();
  }
}