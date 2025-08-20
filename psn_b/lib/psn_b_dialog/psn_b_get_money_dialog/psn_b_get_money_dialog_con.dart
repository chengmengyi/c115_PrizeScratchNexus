import 'package:psn_b/psn_b_dialog/psn_b_no_net_dialog/psn_b_no_net_dialog.dart';
import 'package:psn_b/psn_b_utils/psn_b_cash_utils.dart';
import 'package:psn_b/psn_b_utils/psn_b_user_info_utils.dart';
import 'package:psn_b/psn_b_utils/psn_b_value_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_con.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';
import 'package:psn_root/psn_root_utils/psn_ad_event_enum.dart';
import 'package:psn_root/psn_root_utils/psn_ad_utils.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';

class PsnBGetMoneyDialogCon extends PsnRootCon{
  clickClaim(PsnAdEventEnum adEventEnum,double totalReward,Function() dismissCallback)async{
    PsnAdUtils.instance.showAdBBBBBB(
      adType: AdType.interstitial,
      evnetEnum: adEventEnum,
      showAd: PsnBValueUtils.instance.showAd(AdType.interstitial),
      closeCallback: (){
        PsnBUserInfoUtils.instance.updateUserCoins(totalReward);
        PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
        dismissCallback.call();
      },
    );
  }

  clickDouble(PsnAdEventEnum adEventEnum,double totalReward,Function() dismissCallback)async{
    List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult.contains(ConnectivityResult.none)){
      PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.dialog, content: PsnBNoNetDialog());
      return;
    }

    PsnAdUtils.instance.showAdBBBBBB(
      adType: AdType.reward,
      evnetEnum: adEventEnum,
      showAd: PsnBValueUtils.instance.showAd(AdType.reward),
      closeCallback: (){
        PsnBUserInfoUtils.instance.updateUserCoins(twoNumMul(totalReward, 2));
        PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
        dismissCallback.call();
      },
    );
  }
}