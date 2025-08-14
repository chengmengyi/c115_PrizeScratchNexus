import 'package:psn_b/psn_b_utils/pns_b_card_type_enum.dart';
import 'package:psn_b/psn_b_utils/psn_b_user_info_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_con.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';
import 'package:psn_root/psn_root_utils/psn_ad_utils.dart';

class PsnBGetMoreDialogCon extends PsnRootCon{

  clickClose(Function()? clickClose){
    PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
    clickClose?.call();
  }

  clickAdd(PsnBCardTypeEnum cardTypeEnum){
    PsnAdUtils.instance.showAdBBBBBB(
      closeCallback: ()async{
        await PsnBUserInfoUtils.instance.updateCardNum(cardTypeEnum, 5);
        PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
      },
    );
  }
}