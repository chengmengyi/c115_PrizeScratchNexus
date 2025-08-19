import 'package:psn_b/psn_b_utils/pns_b_card_type_enum.dart';
import 'package:psn_b/psn_b_utils/psn_b_user_info_utils.dart';
import 'package:psn_b/psn_b_utils/psn_b_value_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_con.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';
import 'package:psn_root/psn_root_utils/psn_ad_event_enum.dart';
import 'package:psn_root/psn_root_utils/psn_ad_utils.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';

class PsnBUnlockDialogCon extends PsnRootCon{

  clickClose(){
    PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
  }

  clickUnlock(PsnBCardTypeEnum typeEnum){
    PsnAdUtils.instance.showAdBBBBBB(
      adType: AdType.reward,
      evnetEnum: PsnAdEventEnum.apwxi_unlock_rv,
      showAd: PsnBValueUtils.instance.showAd(AdType.reward),
      closeCallback: ()async{
        await PsnBUserInfoUtils.instance.unlockCard(typeEnum);
        clickClose();
      },
    );
  }
}