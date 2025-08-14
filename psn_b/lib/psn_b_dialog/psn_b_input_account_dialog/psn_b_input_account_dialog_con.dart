import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_utils/psn_b_cash_utils.dart';
import 'package:psn_b/psn_b_utils/psn_b_user_info_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_con.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';

class PsnBInputAccountDialogCon extends PsnRootCon{
  TextEditingController editingController=TextEditingController();

  clickClose(){
    PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
  }

  clickSubmit(String cashType,int cashMoney)async{
    var account = editingController.text.trim();
    if(account.isEmpty){
      return;
    }
    if(cashType==CashType.pag||cashType==CashType.pay){
      if(!_isEmail(account)){
        "The format you entered is incorrect.".showToast();
        return;
      }
    }
    if(cashType==CashType.cash){
      if(!_isTenDigitNumber(account)){
        "The format you entered is incorrect.".showToast();
        return;
      }
    }
    var result = await PsnBCashUtils.instance.createCashTask(cashMoney, cashType);
    if(result){
      PsnBUserInfoUtils.instance.updateUserCoins((-cashMoney).toDouble());
      PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
    }else{
      "Operation failed, please try again".showToast();
    }
  }

  bool _isEmail(String input) {
    final emailRegex = RegExp(
      r'^[\w\.-]+@[\w\.-]+\.\w+$',
    );
    return emailRegex.hasMatch(input);
  }

  bool _isTenDigitNumber(String input) {
    return RegExp(r'^\d{10}$').hasMatch(input);
  }

  @override
  void onClose() {
    editingController.dispose();
    super.onClose();
  }
}