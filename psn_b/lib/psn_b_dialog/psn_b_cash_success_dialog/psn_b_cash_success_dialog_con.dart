import 'package:psn_b/psn_b_bean/psn_cash_task_bean.dart';
import 'package:psn_b/psn_b_utils/psn_b_cash_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_con.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';

class PsnBCashSuccessDialogCon extends PsnRootCon{

  clickClose(){
    PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
  }

  clickSure(PsnCashTaskBean? cashTaskBean)async{
    await PsnBCashUtils.instance.deleteCashTask(cashTaskBean);
    PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
  }

}