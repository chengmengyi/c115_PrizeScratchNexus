import 'package:psn_b/psn_b_utils/pns_b_card_type_enum.dart';
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
import 'package:psn_root/psn_root_utils/psn_tba/psn_b_tba_utils.dart';
import 'package:psn_root/psn_root_utils/psn_tba_point_enum.dart';

class PsnBBigWinDialogCon extends PsnRootCon{
  clickClaim(PsnBCardTypeEnum cardTypeEnum,double totalReward,Function() dismissCallback)async{
    PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.coin_pop_close,params: {"source_from":cardTypeEnum.name});
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

  clickDouble(PsnBCardTypeEnum cardTypeEnum,double totalReward,Function() dismissCallback){
    PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.coin_pop_c,params: {"source_from":cardTypeEnum.name});
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