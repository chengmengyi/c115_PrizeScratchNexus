import 'package:psn_b/psn_b_utils/psn_b_event_code.dart';
import 'package:psn_root/psn_root_event/psn_root_event_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_con.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';
import 'package:psn_root/psn_root_utils/psn_tba/psn_b_tba_utils.dart';
import 'package:psn_root/psn_root_utils/psn_tba_point_enum.dart';

class PsnBNoWheelDialogCon extends PsnRootCon{

  @override
  void onInit() {
    super.onInit();
    // PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.cash_not_pop);
  }

  clickClose(){
    PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
  }

  clickPlayNow(){
    // PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.cash_not_pop_c);
    PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
    PsnRootEventUtils.instance.sendEvent(code: PsnBEventCode.noMoneyClickPlayNow);
    PsnRootEventUtils.instance.sendEvent(code: PsnBEventCode.showHomeIndex,intValue: 0);
  }

}