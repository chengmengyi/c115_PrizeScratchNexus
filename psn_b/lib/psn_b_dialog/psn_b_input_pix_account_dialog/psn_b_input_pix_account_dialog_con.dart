import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_utils/psn_b_cash_utils.dart';
import 'package:psn_b/psn_b_utils/psn_b_user_info_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_con.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';

class PsnBInputPixAccountDialogCon extends PsnRootCon{
  var chooseAccountTypeIndex=0;
  List<String> accountTypeList=["Email","Phone","CPF","EVP"];
  TextEditingController cpfEditingController=TextEditingController();
  TextEditingController accountEditingController=TextEditingController();
  TextEditingController nameEditingController=TextEditingController();

  clickAccountType(int index){
    if(chooseAccountTypeIndex==index){
      return;
    }
    chooseAccountTypeIndex=index;
    update(["account_type"]);
  }

  clickClose(){
    PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
  }

  clickSubmit(String cashType,int cashMoney)async{
    var cpf = cpfEditingController.text.trim();
    var account = accountEditingController.text.trim();
    var name = nameEditingController.text.trim();
    if(cpf.isEmpty||account.isEmpty||name.isEmpty){
      return;
    }
    if(!_isElevenDigitNumber(cpf)){
      "Enter 11-digit CPF number".showToast();
      return;
    }
    if(name.contains("@")){
      "Enter the correct name".showToast();
      return;
    }
    if(chooseAccountTypeIndex==0){
      if(!_isEmail(account)){
        "The format you entered is incorrect.".showToast();
        return;
      }
    }
    if(chooseAccountTypeIndex==1){
      if(!_isBrazilPhoneNumber(account)){
        "The format you entered is incorrect.".showToast();
        return;
      }
    }

    if(chooseAccountTypeIndex==2){
      if(!_isElevenDigitNumber(account)){
        "The format you entered is incorrect.".showToast();
        return;
      }
    }

    if(chooseAccountTypeIndex==3){
      if(!_is36CharsWithDash(account)){
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

  bool _is36CharsWithDash(String input) {
    return input.length == 36 && input.contains('-');
  }

  bool _isBrazilPhoneNumber(String input) {
    return RegExp(r'^\+55\d{10,11}$').hasMatch(input);
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

  bool _isElevenDigitNumber(String input) {
    return RegExp(r'^\d{11}$').hasMatch(input);
  }

  @override
  void onClose() {
    cpfEditingController.dispose();
    accountEditingController.dispose();
    nameEditingController.dispose();
    super.onClose();
  }
}