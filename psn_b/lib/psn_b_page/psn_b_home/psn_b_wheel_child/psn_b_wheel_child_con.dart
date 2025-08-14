import 'package:psn_b/psn_b_storage/psn_b_storage.dart';
import 'package:psn_b/psn_b_utils/psn_b_event_code.dart';
import 'package:psn_b/psn_b_utils/psn_b_value_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_con.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';

class PsnBWheelChildCon extends PsnRootCon{

  double getCashMoney(){
    var coins = bUserCoins.getData();
    var first = PsnBValueUtils.instance.getCashList().first;
    if(coins>=first){
      return 0;
    }
    return twoNumSub(first, coins);
  }

  @override
  bool initEvent() => true;

  @override
  receivedEventBus(int code, int? intValue, String? strValue, anyValue) {
    switch(code){
      case PsnBEventCode.updateCoins:
        update(["top_text"]);
        break;
    }
  }
}