import 'package:psn_b/psn_b_bean/psb_cash_list_bean.dart';
import 'package:psn_b/psn_b_bean/psn_b_cash_type_bean.dart';
import 'package:psn_b/psn_b_bean/psn_cash_task_bean.dart';
import 'package:psn_b/psn_b_dialog/psn_b_cash_success_dialog/psn_b_cash_success_dialog.dart';
import 'package:psn_b/psn_b_dialog/psn_b_cash_task_dialog/psn_b_cash_task_dialog.dart';
import 'package:psn_b/psn_b_dialog/psn_b_input_account_dialog/psn_b_input_account_dialog.dart';
import 'package:psn_b/psn_b_dialog/psn_b_input_pix_account_dialog/psn_b_input_pix_account_dialog.dart';
import 'package:psn_b/psn_b_dialog/psn_b_no_money_dialog/psn_b_no_money_dialog.dart';
import 'package:psn_b/psn_b_storage/psn_b_storage.dart';
import 'package:psn_b/psn_b_utils/psn_b_cash_utils.dart';
import 'package:psn_b/psn_b_utils/psn_b_event_code.dart';
import 'package:psn_b/psn_b_utils/psn_b_value_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_con.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';
import 'package:psn_root/psn_root_utils/psn_tba/psn_b_tba_utils.dart';
import 'package:psn_root/psn_root_utils/psn_tba_point_enum.dart';

class PsnBCashChildCon extends PsnRootCon{
  var cashTypeIndex=0;
  List<PsnBCashTypeBean> cashTypeList=[
    PsnBCashTypeBean(type: CashType.pay, icon: "cash_type_pay"),
    PsnBCashTypeBean(type: CashType.cash, icon: "cash_type_cash"),
    PsnBCashTypeBean(type: CashType.pag, icon: "cash_type_pag"),
    PsnBCashTypeBean(type: CashType.pix, icon: "cash_type_pix"),
  ];

  List<PsbCashListBean> cashList=[];

  @override
  void onReady() {
    super.onReady();
    _initCashList();
  }

  clickCashType(index){
    if(cashTypeIndex==index){
      return;
    }
    cashTypeIndex=index;
    update(["cash_list"]);
  }

  clickCashItem(PsbCashListBean bean){
    PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.cash_out_c);
    if(null!=bean.cashTaskBean){
      if(bean.cashTaskBean?.completed==1){
        PsnRootRouters.instance.router(
          routersEnum: PsnRoutersEnum.dialog,
          content: PsnBCashSuccessDialog(
            cashTaskBean: bean.cashTaskBean,
          ),
        );
        return;
      }
      PsnRootRouters.instance.router(
        routersEnum: PsnRoutersEnum.dialog,
        content: PsnBCashTaskDialog(bean: bean),
      );
      return;
    }
    if(bUserCoins.getData()<bean.money){
      PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.dialog, content: PsnBNoMoneyDialog(),);
      return;
    }
    var cashType = cashTypeList[cashTypeIndex].type;
    if(cashType==CashType.pix){
      PsnRootRouters.instance.router(
        routersEnum: PsnRoutersEnum.dialog,
        content:  PsnBInputPixAccountDialog(
          cashType: cashType,
          cashMoney: bean.money,
        ),
      );
      return;
    }
    PsnRootRouters.instance.router(
      routersEnum: PsnRoutersEnum.dialog,
      content:  PsnBInputAccountDialog(
        cashType: cashType,
        cashMoney: bean.money,
      ),
    );
  }

  _initCashList()async{
    cashList.clear();
    for (var value in PsnBValueUtils.instance.getCashList()) {
      var psnCashTaskBean = await PsnBCashUtils.instance.queryCashTaskByMoneyAndType(value, cashTypeList[cashTypeIndex].type);
      cashList.add(
        PsbCashListBean(
          money: value,
          cashTaskBean: psnCashTaskBean,
        ),
      );
    }
    update(["cash_list"]);
  }

  String getCashListBg(){
    switch(cashTypeList[cashTypeIndex].type){
      case CashType.pay: return "cash_list_pay";
      case CashType.cash: return "cash_list_cash";
      case CashType.pag: return "cash_list_pag";
      case CashType.pix: return "cash_list_pix";
      default: return "cash_list_pix";
    }
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

  @override
  bool initEvent() => true;

  @override
  receivedEventBus(int code, int? intValue, String? strValue, anyValue) {
    switch(code){
      case PsnBEventCode.updateCashList:
        _initCashList();
        break;
    }
  }
}