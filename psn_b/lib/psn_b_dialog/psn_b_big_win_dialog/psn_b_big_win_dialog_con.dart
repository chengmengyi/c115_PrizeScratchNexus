import 'package:psn_b/psn_b_utils/psn_b_user_info_utils.dart';
import 'package:psn_b/psn_b_utils/psn_b_value_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_con.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';
import 'package:psn_root/psn_root_utils/psn_ad_event_enum.dart';
import 'package:psn_root/psn_root_utils/psn_ad_utils.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';

class PsnBBigWinDialogCon extends PsnRootCon{
  clickClaim(double totalReward,Function() dismissCallback)async{
    PsnAdUtils.instance.showAdBBBBBB(
      adType: AdType.interstitial,
      showAd: PsnBValueUtils.instance.showAd(AdType.interstitial),
      evnetEnum: PsnAdEventEnum.apwxi_scrgetpop_int,
      closeCallback: (){
        PsnBUserInfoUtils.instance.updateUserCoins(totalReward);
        PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
        dismissCallback.call();
      },
    );
  }

  clickDouble(double totalReward,Function() dismissCallback){
    PsnAdUtils.instance.showAdBBBBBB(
      adType: AdType.reward,
      showAd: PsnBValueUtils.instance.showAd(AdType.reward),
      evnetEnum: PsnAdEventEnum.apwxi_scrgetpop_rv,
      closeCallback: (){
        PsnBUserInfoUtils.instance.updateUserCoins(twoNumMul(totalReward, 2));
        PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
        dismissCallback.call();
      },
    );
  }
}