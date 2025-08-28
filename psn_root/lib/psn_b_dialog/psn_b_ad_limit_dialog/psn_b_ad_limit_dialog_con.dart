import 'package:psn_root/psn_root_page/psn_root_con.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';
import 'package:psn_root/psn_root_utils/psn_tba/psn_b_tba_utils.dart';
import 'package:psn_root/psn_root_utils/psn_tba_point_enum.dart';

class PsnBAdLimitDialogCon extends PsnRootCon{
  @override
  void onInit() {
    super.onInit();
    PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.see_you_tommorow);
  }

  clickClose(Function() dismissCallback){
    PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
    dismissCallback.call();
  }
}