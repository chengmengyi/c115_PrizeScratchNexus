import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_tba/psn_b_base_tba_bean.dart';

class PsnBInstallTbaBean{
  Future<Map<String,dynamic>> getInstallMap()async{
    var baseMap = await PsnBBaseTbaBean().getBaseMap();
    var referrerMap = await FlutterTbaInfo.instance.getReferrerMap();
    baseMap["oneill"]="tadpole";
    baseMap["meadow"]=referrerMap["build"];
    baseMap["bump"]=referrerMap["referrer_url"];
    baseMap["carpet"]=referrerMap["install_version"];
    baseMap["conform"]=referrerMap["user_agent"];
    baseMap["shone"]="teach";
    baseMap["forlorn"]=referrerMap["referrer_click_timestamp_seconds"];
    baseMap["annulus"]=referrerMap["install_begin_timestamp_seconds"];
    baseMap["plop"]=referrerMap["referrer_click_timestamp_server_seconds"];
    baseMap["check"]=referrerMap["install_begin_timestamp_server_seconds"];
    baseMap["tsunami"]=referrerMap["install_first_seconds"];
    baseMap["base"]=referrerMap["last_update_seconds"];
    baseMap["shrike"]=referrerMap["google_play_instant"];
    return baseMap;
  }
}