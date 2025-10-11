import 'package:psn_root/psn_root_page/psn_root_con.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';
import 'package:psn_root/psn_root_utils/psn_applife_utils.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_tba/psn_b_tba_utils.dart';
import 'package:psn_root/psn_root_utils/psn_tba_point_enum.dart';

class PsnBNoNotificationPermissionDialogCon extends PsnRootCon{
  @override
  void onInit() {
    super.onInit();
    PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.noti_second_pop);
  }

  clickClose(){
    PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.noti_second_c);
    PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
  }

  clickTo(){
    PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.noti_second_r);
    PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
    PsnApplifeUtils.instance.isToOpenNotifi=true;
    AppSettings.openAppSettings(type: AppSettingsType.notification);
  }

}