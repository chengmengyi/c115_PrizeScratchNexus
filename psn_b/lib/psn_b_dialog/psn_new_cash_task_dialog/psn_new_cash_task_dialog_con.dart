import 'package:psn_b/psn_b_bean/psn_cash_task_bean.dart';
import 'package:psn_b/psn_b_utils/psn_b_event_code.dart';
import 'package:psn_b/psn_b_utils/psn_b_value_utils.dart';
import 'package:psn_root/psn_root_event/psn_root_event_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_con.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';
import 'package:psn_root/psn_root_utils/psn_tba/psn_b_tba_utils.dart';
import 'package:psn_root/psn_root_utils/psn_tba_point_enum.dart';

class PsnNewCashTaskDialogCon extends PsnRootCon{

  clickClose(){
    PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
  }

  clickGo(PsnCashTaskBean bean){
    PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.cash_task_pop_c,params: {"pop_from":getPopFrom(bean)});
    PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
    PsnRootEventUtils.instance.sendEvent(code: PsnBEventCode.showHomeIndex,intValue: 0);
  }

  String getCaskTaskStr(PsnCashTaskBean? bean){
    var withdrawTask = PsnBValueUtils.instance.getCashTaskConfigByID(bean?.cashTaskId);
    if(null==withdrawTask){
      return "";
    }
    switch(withdrawTask.type){
      case "card": return "Scratch ${bean?.currentProgress??0}/${withdrawTask.count??0} Card";
      case "wheel": return "Play ${bean?.currentProgress??0}/${withdrawTask.count??0} Spins";
      case "lucky": return "Play ${bean?.currentProgress??0}/${withdrawTask.count??0} luck cards";
      case "ad": return "Watch ${bean?.currentProgress??0}/${withdrawTask.count??0} video ads";
      default: return "";
    }
  }

  String getPopFrom(PsnCashTaskBean? bean){
    var withdrawTask = PsnBValueUtils.instance.getCashTaskConfigByID(bean?.cashTaskId);
    return withdrawTask?.type??"";
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