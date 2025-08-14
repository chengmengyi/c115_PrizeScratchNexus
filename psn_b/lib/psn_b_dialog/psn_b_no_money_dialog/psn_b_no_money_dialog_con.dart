import 'package:psn_b/psn_b_utils/psn_b_event_code.dart';
import 'package:psn_root/psn_root_event/psn_root_event_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_con.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';

class PsnBNoMoneyDialogCon extends PsnRootCon{

  clickClose(){
    PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
  }

  clickPlayNow(){
    PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
    PsnRootEventUtils.instance.sendEvent(code: PsnBEventCode.showHomeIndex,intValue: 0);
  }
}