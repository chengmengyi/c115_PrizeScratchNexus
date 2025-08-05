import 'package:psn_a/psn_a_storage/psn_a_storage.dart';
import 'package:psn_a/psn_a_utils/pns_a_card_type_enum.dart';
import 'package:psn_a/psn_a_utils/psn_a_user_info_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_con.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';

class PsnAUnlockDialogCon extends PsnRootCon{

  clickClose(){
    PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
  }

  clickUnlock(PsnACardTypeEnum typeEnum)async{
    if(aUserCoins.getData()<30000){
      "Insufficient gold coins".showToast();
      return;
    }
    await PsnAUserInfoUtils.instance.unlockCard(typeEnum);
    PsnAUserInfoUtils.instance.updateUserCoins(-30000);
    clickClose();
  }
}