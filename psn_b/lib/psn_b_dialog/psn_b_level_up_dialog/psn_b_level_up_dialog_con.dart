import 'package:psn_b/psn_b_utils/psn_b_user_info_utils.dart';
import 'package:psn_b/psn_b_utils/psn_b_utils.dart';
import 'package:psn_b/psn_b_utils/psn_b_value_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_con.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';
import 'package:psn_root/psn_root_utils/psn_ad_utils.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';

class PsnBLevelUpDialogCon extends PsnRootCon{
  var upLevelReward=0;
  @override
  void onInit() {
    super.onInit();
    upLevelReward=PsnBValueUtils.instance.getUpLevelReward();
  }

  String getLevelStr(){
    var bean = calculateLevel();
    return "Lv ${bean.level-1}  -  Lv ${bean.level}";
  }

  clickClaim(Function() dismissCallback)async{
    PsnBUserInfoUtils.instance.updateUserCoins(upLevelReward.toDouble());
    PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
    dismissCallback.call();
  }

  clickDouble(Function() dismissCallback){
    PsnAdUtils.instance.showAdBBBBBB(
      closeCallback: (){
        PsnBUserInfoUtils.instance.updateUserCoins(twoNumMul(upLevelReward, 2));
        PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
        dismissCallback.call();
      },
    );
  }
}