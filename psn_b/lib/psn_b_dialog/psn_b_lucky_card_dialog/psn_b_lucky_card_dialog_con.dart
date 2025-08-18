import 'package:psn_b/psn_b_dialog/psn_b_get_money_dialog/psn_b_get_money_dialog.dart';
import 'package:psn_root/psn_root_page/psn_root_con.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';

class PsnBLuckyCardDialogCon extends PsnRootCon{
  var canClick=true;

  startLuckyCardFlipAnimator(){
    canClick=false;
  }

  clickCardAnimatorEnd(double reward, Function() dismissCallback)async{
    await Future.delayed(Duration(milliseconds: 1500));
    PsnRootRouters.instance.router(
      routersEnum: PsnRoutersEnum.dialog,
      content: PsnBGetMoneyDialog(
        reward: reward,
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
    PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
    dismissCallback.call();
  }
}