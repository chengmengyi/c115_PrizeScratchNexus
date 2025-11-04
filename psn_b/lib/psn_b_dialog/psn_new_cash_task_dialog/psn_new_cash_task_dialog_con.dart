import 'package:psn_b/psn_b_bean/psn_cash_task_bean.dart';
import 'package:psn_b/psn_b_routers/psn_b_page_list.dart';
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

  clickGo(PsnCashTaskBean bean, Function()? dismissDialog){
    PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.cash_task_pop_c,params: {"pop_from":getPopFrom(bean)});
    var withdrawTask = PsnBValueUtils.instance.getCashTaskConfigByID(bean.cashTaskId);
    if(withdrawTask?.type=="wheel"){
      PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.toHome, content: PsnBPageName.home);
      PsnRootEventUtils.instance.sendEvent(code: PsnBEventCode.showHomeIndex,intValue: 1);
    }else{
      PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
      PsnRootEventUtils.instance.sendEvent(code: PsnBEventCode.showHomeIndex,intValue: 0);
      dismissDialog?.call();
    }
  }

  String getCaskTaskStr(PsnCashTaskBean? bean){
    var withdrawTask = PsnBValueUtils.instance.getCashTaskConfigByID(bean?.cashTaskId);
    if(null==withdrawTask){
      return "";
    }
    var start="";
    switch(withdrawTask.type){
      case "card": return "${start}Scratch ${bean?.currentProgress??0}/${withdrawTask.count??0} Card";
      case "wheel": return "${start}Play ${bean?.currentProgress??0}/${withdrawTask.count??0} Spins";
      case "lucky": return "${start}Play ${bean?.currentProgress??0}/${withdrawTask.count??0} lucky cards";
      case "ad": return "${start}Watch ${bean?.currentProgress??0}/${withdrawTask.count??0} video ads";
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