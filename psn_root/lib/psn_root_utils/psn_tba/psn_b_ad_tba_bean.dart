import 'package:flutter_android_ad_plugins/data/ad_info_data.dart';
import 'package:flutter_android_ad_plugins/data/ad_money_info_bean.dart';
import 'package:psn_root/psn_root_utils/psn_ad_event_enum.dart';
import 'package:psn_root/psn_root_utils/psn_tba/psn_b_base_tba_bean.dart';

class PsnBAdTbaBean{
  Future<Map<String,dynamic>> getAdMap(AdMoneyInfoBean? ad,PsnAdEventEnum adEvent,AdInfoData? adInfoData)async{
    var baseMap = await PsnBBaseTbaBean().getBaseMap();
    baseMap["oneill"]="mawkish";
    baseMap["venomous"]=(ad?.revenue??0)*1000000;
    baseMap["lordosis"]="USD";
    baseMap["idiotic"]=ad?.networkName??"";
    baseMap["blurb"]=adInfoData?.adPlat??"";
    baseMap["fallible"]=adInfoData?.adId??"";
    baseMap["drizzle"]=adEvent.name;
    baseMap["nitty"]=adInfoData?.adType.name;
    baseMap["valery"]=ad?.revenuePrecision??"";
    return baseMap;
  }
}