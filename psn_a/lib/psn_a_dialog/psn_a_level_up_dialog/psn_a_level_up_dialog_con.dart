import 'package:psn_a/psn_a_utils/psn_a_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_con.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';

class PsnALevelUpDialogCon extends PsnRootCon{

  String getLevelStr(){
    var bean = calculateLevel();
    return "Lv ${bean.level-1}  -  Lv ${bean.level}";
  }

  clickClaim(Function() dismissCallback)async{
    PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
    dismissCallback.call();
  }
}