import 'package:psn_b/psn_b_bean/psn_cash_task_bean.dart';
import 'package:psn_b/psn_b_utils/psn_b_event_code.dart';
import 'package:psn_b/psn_b_utils/psn_b_value_utils.dart';
import 'package:psn_root/psn_root_event/psn_root_event_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_con.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';

class PsnBCashTaskDialogCon extends PsnRootCon{
  clickClose(){
    PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
  }

  clickCashOut(){
    PsnRootEventUtils.instance.sendEvent(code: PsnBEventCode.showHomeIndex,intValue: 0);
    PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
  }


  String getCaskTaskStr(PsnCashTaskBean? bean){
    var withdrawTask = PsnBValueUtils.instance.getCashTaskConfigByID(bean?.cashTaskId);
    if(null==withdrawTask){
      return "";
    }
    switch(withdrawTask.type){
      case "card": return "Scratch ${withdrawTask.count??0} Card";
      case "wheel": return "Play ${withdrawTask.count??0} Spins";
      case "lucky": return "Play ${withdrawTask.count??0} luck cards";
      case "ad": return "Watch ${withdrawTask.count??0} video ads";
      default: return "";
    }
  }

  double getCashTaskPro(PsnCashTaskBean? bean){
    var totalProgress = bean?.totalProgress??0;
    if(totalProgress<=0){
      return 0;
    }
    var d = (bean?.currentProgress??0)/totalProgress;
    if(d<=0){
      return 0.0;
    }else if(d>=1){
      return 1.0;
    }else{
      return d;
    }
  }
}