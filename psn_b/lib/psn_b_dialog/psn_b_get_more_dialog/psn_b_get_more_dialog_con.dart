import 'package:psn_b/psn_b_utils/pns_b_card_type_enum.dart';
import 'package:psn_b/psn_b_utils/psn_b_user_info_utils.dart';
import 'package:psn_b/psn_b_utils/psn_b_value_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_con.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';
import 'package:psn_root/psn_root_utils/psn_ad_event_enum.dart';
import 'package:psn_root/psn_root_utils/psn_ad_utils.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';

class PsnBGetMoreDialogCon extends PsnRootCon{

  clickClose(Function()? clickClose){
    PsnAdUtils.instance.showAdBBBBBB(
      adType: AdType.interstitial,
      evnetEnum: PsnAdEventEnum.apwxi_scrgetpop_int,
      showAd: PsnBValueUtils.instance.showAd(AdType.interstitial),
      closeCallback: (){
        PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
        clickClose?.call();
      },
    );
  }

  clickAdd(PsnBCardTypeEnum cardTypeEnum){
    PsnAdUtils.instance.showAdBBBBBB(
      adType: AdType.reward,
      evnetEnum: PsnAdEventEnum.apwxi_scr_rv,
      showAd: PsnBValueUtils.instance.showAd(AdType.reward),
      closeCallback: ()async{
        await PsnBUserInfoUtils.instance.updateCardNum(cardTypeEnum, 5);
        PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
      },
    );
  }
}