import 'package:psn_root/psn_root_page/psn_root_con.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';

enum SafeCheckType{
  success,fail,
}
class PsnSafeCheckDialogCon extends PsnRootCon{
  var currentPro=0,showBtn=false;
  late SafeCheckType safeCheckType;

  PsnSafeCheckDialogCon(this.safeCheckType);

  updatePro(double pro){
    var progress=(pro*100).toInt();
    if(safeCheckType==SafeCheckType.fail&&progress>90){
      currentPro=90;
    }else{
      currentPro=progress;
    }
    update(["pro_text"]);
    if(progress>=100){
      showBtn=true;
      update(["btn"]);
    }
  }

  clickVer(Function() dismissCallback){
    PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
    dismissCallback.call();
  }
}