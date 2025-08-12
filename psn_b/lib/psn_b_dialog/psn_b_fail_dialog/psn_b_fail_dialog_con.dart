import 'package:psn_root/psn_root_page/psn_root_con.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';

class PsnBFailDialogCon extends PsnRootCon{
  clickContinue(Function() dismissCallback){
    PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
    dismissCallback.call();
  }
}