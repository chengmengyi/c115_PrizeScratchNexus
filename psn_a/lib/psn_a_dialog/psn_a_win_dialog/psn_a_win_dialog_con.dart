import 'package:psn_a/psn_a_utils/psn_a_user_info_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_con.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';

class PsnAWinDialogCon extends PsnRootCon{

  clickClaim(int totalReward,Function() dismissCall){
    PsnAUserInfoUtils.instance.updateUserCoins(totalReward);
    PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null,);
    dismissCall.call();
  }
}