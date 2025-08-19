import 'package:psn_b/psn_b_dialog/psn_b_get_money_dialog/psn_b_get_money_dialog.dart';
import 'package:psn_b/psn_b_utils/psn_b_cash_utils.dart';
import 'package:psn_b/psn_b_utils/psn_b_value_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_con.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';
import 'package:psn_root/psn_root_utils/psn_ad_event_enum.dart';
import 'package:psn_root/psn_root_utils/psn_ad_utils.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';

class PsnBLuckyCardDialogCon extends PsnRootCon{
  var canClick=true;

  startLuckyCardFlipAnimator(){
    canClick=false;
  }

  clickCardAnimatorEnd(double reward, Function() dismissCallback)async{
    await Future.delayed(Duration(milliseconds: 1500));
    PsnBCashUtils.instance.updateCashTask(TaskType.lucky);
    PsnRootRouters.instance.router(
      routersEnum: PsnRoutersEnum.dialog,
      content: PsnBGetMoneyDialog(
        reward: reward,
        adEventEnumDouble: PsnAdEventEnum.apwxi_flopgetpop_rv,
        adEventEnumClose: PsnAdEventEnum.apwxi_flopgetpop_int,
        dismissCallback: (){
          PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
          dismissCallback.call();
        },
      ),
    );
  }

  clickClose(Function() dismissCallback){
    if(!canClick){
      return;
    }
    PsnAdUtils.instance.showAdBBBBBB(
      adType: AdType.interstitial,
      evnetEnum: PsnAdEventEnum.apwxi_flop_int,
      showAd: PsnBValueUtils.instance.showAd(AdType.interstitial),
      closeCallback: (){
        PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
        dismissCallback.call();
      },
    );
  }
}