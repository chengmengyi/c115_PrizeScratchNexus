import 'package:psn_a/psn_a_storage/psn_a_storage.dart';
import 'package:psn_a/psn_a_utils/pns_a_card_type_enum.dart';
import 'package:psn_a/psn_a_utils/psn_a_user_info_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_con.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';

class PsnAGetMoreDialogCon extends PsnRootCon{

  clickClose(Function()? clickClose){
    PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
    clickClose?.call();
  }

  clickAdd(PsnACardTypeEnum cardTypeEnum)async{
    if(aUserCoins.getData()<5000){
      return;
    }
    await PsnAUserInfoUtils.instance.updateCardNum(cardTypeEnum, 5);
    PsnAUserInfoUtils.instance.updateUserCoins(-5000);
    PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
  }
}