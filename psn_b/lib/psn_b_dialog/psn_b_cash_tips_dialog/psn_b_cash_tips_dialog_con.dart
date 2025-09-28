import 'package:psn_b/psn_b_dialog/psn_b_input_account_dialog/psn_b_input_account_dialog.dart';
import 'package:psn_b/psn_b_utils/psn_b_cash_utils.dart';
import 'package:psn_b/psn_b_utils/psn_b_event_code.dart';
import 'package:psn_b/psn_b_utils/psn_b_value_utils.dart';
import 'package:psn_root/psn_root_event/psn_root_event_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_con.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';
import 'package:psn_root/psn_root_utils/psn_tba/psn_b_tba_utils.dart';
import 'package:psn_root/psn_root_utils/psn_tba_point_enum.dart';

class PsnBCashTipsDialogCon extends PsnRootCon{
  String cashType=CashType.pay;

  @override
  void onInit() {
    super.onInit();
    PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.cash_confirm_pop);
  }

  int getFirstMoney()=>PsnBValueUtils.instance.getCashList().first;

  clickClose(){
    PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
  }

  clickCon(){
    PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.cash_confirm_pop_c);
    PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
    PsnRootEventUtils.instance.sendEvent(code: PsnBEventCode.showHomeIndex,intValue: 2);
    // PsnRootRouters.instance.router(
    //   routersEnum: PsnRoutersEnum.dialog,
    //   content:  PsnBInputAccountDialog(
    //     cashType: cashType,
    //     cashMoney: getFirstMoney(),
    //   ),
    // );
  }
}