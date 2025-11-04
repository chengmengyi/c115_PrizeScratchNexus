import 'package:psn_b/psn_b_bean/psb_cash_list_bean.dart';
import 'package:psn_b/psn_b_bean/psn_b_cash_type_bean.dart';
import 'package:psn_b/psn_b_bean/psn_cash_task_bean.dart';
import 'package:psn_b/psn_b_bean/psn_rank_bean.dart';
import 'package:psn_b/psn_b_dialog/psn_b_cash_success_dialog/psn_b_cash_success_dialog.dart';
import 'package:psn_b/psn_b_dialog/psn_b_input_account_dialog/psn_b_input_account_dialog.dart';
import 'package:psn_b/psn_b_dialog/psn_b_input_pix_account_dialog/psn_b_input_pix_account_dialog.dart';
import 'package:psn_b/psn_b_dialog/psn_b_no_money_dialog/psn_b_no_money_dialog.dart';
import 'package:psn_b/psn_b_dialog/psn_cash_init_animator_dialog/psn_cash_init_animator_dialog.dart';
import 'package:psn_b/psn_b_dialog/psn_cash_last_step_success_dialog/psn_cash_last_step_success_dialog.dart';
import 'package:psn_b/psn_b_dialog/psn_dont_worry_dialog/psn_dont_worry_dialog.dart';
import 'package:psn_b/psn_b_dialog/psn_new_cash_task_dialog/psn_new_cash_task_dialog.dart';
import 'package:psn_b/psn_b_dialog/psn_rank_dialog/psn_rank_dialog.dart';
import 'package:psn_b/psn_b_dialog/psn_rank_tips_animator_dialog/psn_rank_tips_animator_dialog.dart';
import 'package:psn_b/psn_b_dialog/psn_safe_check_dialog/psn_safe_check_dialog.dart';
import 'package:psn_b/psn_b_dialog/psn_safe_check_dialog/psn_safe_check_dialog_con.dart';
import 'package:psn_b/psn_b_storage/psn_b_storage.dart';
import 'package:psn_b/psn_b_utils/psn_b_cash_utils.dart';
import 'package:psn_b/psn_b_utils/psn_b_event_code.dart';
import 'package:psn_b/psn_b_utils/psn_b_user_info_utils.dart';
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
    _initCashList();
  }

  clickCashItem(PsbCashListBean bean){
    PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.cash_out_c);
    if(null!=bean.rankProgress){
      PsnBCashUtils.instance.showRankDialog(bean.rankProgress!);
      return;
    }
    if(null!=bean.cashTaskBean){
      PsnBCashUtils.instance.clickCashItem(bean.cashTaskBean!);
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
          inputCallback: (String account){
            _inputAccountCallback(bean.money,account);
          },
        ),
      );
      return;
    }
    PsnRootRouters.instance.router(
      routersEnum: PsnRoutersEnum.dialog,
      content:  PsnBInputAccountDialog(
        cashType: cashType,
        cashMoney: bean.money,
        inputCallback: (String account){
          _inputAccountCallback(bean.money,account);
        },
      ),
    );
  }

  _inputAccountCallback(int money, String account){
    var type = cashTypeList[cashTypeIndex].type;
    PsnRootRouters.instance.router(
      routersEnum: PsnRoutersEnum.dialog,
      content: PsnCashInitAnimatorDialog(
        cashType: type,
        cashMoney: money,
        clickCallback: (){
          _showSafeCheckDialog(money,type,account);
        },
      ),
    );
  }

  _showSafeCheckDialog(int money, String type, String account){
    PsnRootRouters.instance.router(
      routersEnum: PsnRoutersEnum.dialog,
      content: PsnSafeCheckDialog(
        account: account,
        safeCheckType: SafeCheckType.fail,
        dismissCallback: ()async{
          var result = await PsnBCashUtils.instance.createCashTask(money, type,account);
          if(result){
            PsnBUserInfoUtils.instance.updateUserCoins((-money).toDouble());
            var psnCashTaskBean = await PsnBCashUtils.instance.queryCashTaskByMoneyAndType(money, type);
            PsnBCashUtils.instance.showCashTaskDialog(psnCashTaskBean);
          }
        },
      ),
    );
  }

  // _showDontWorryDialog(int money, String type, String account){
  //   PsnRootRouters.instance.router(
  //     routersEnum: PsnRoutersEnum.dialog,
  //     content: PsnDontWorryDialog(
  //       clickCallback: ()async{
  //         var result = await PsnBCashUtils.instance.createCashTask(money, type,account);
  //         if(result){
  //           PsnBUserInfoUtils.instance.updateUserCoins((-money).toDouble());
  //           var psnCashTaskBean = await PsnBCashUtils.instance.queryCashTaskByMoneyAndType(money, type);
  //           PsnBCashUtils.instance.showCashTaskDialog(psnCashTaskBean);
  //         }
  //       },
  //     ),
  //   );
  // }

  _initCashList()async{
    cashList.clear();
    var type = cashTypeList[cashTypeIndex].type;
    for (var value in PsnBValueUtils.instance.getCashList()) {
      var psnCashTaskBean = await PsnBCashUtils.instance.queryCashTaskByMoneyAndType(value, type);
      var rankProgress = await PsnBCashUtils.instance.queryRankProgress(value, type);
      cashList.add(
        PsbCashListBean(
          money: value,
          cashTaskBean: psnCashTaskBean,
          rankProgress: rankProgress,
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

  String getCaskTaskStr(PsbCashListBean bean){
    if(null!=bean.rankProgress){
      return "Current rank:${bean.rankProgress?.currentRank}";
    }
    var withdrawTask = PsnBValueUtils.instance.getCashTaskConfigByID(bean.cashTaskBean?.cashTaskId);
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

  double getCashTaskPro(PsbCashListBean bean){
    if(null!=bean.rankProgress){
      var totalRank = bean.rankProgress?.totalRank??0;
      if(totalRank<=0){
        return 0.0;
      }
      var d = ((totalRank = bean.rankProgress?.totalRank??0)-(bean.rankProgress?.currentRank??0))/totalRank;
      if(d<=0){
        return 0.0;
      }else if(d>=1){
        return 1.0;
      }else{
        return d;
      }
    }
    var totalProgress = bean.cashTaskBean?.totalProgress??0;
    if(totalProgress<=0){
      return 0;
    }
    var d = (bean.cashTaskBean?.currentProgress??0)/totalProgress;
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