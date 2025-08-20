import 'dart:io';

import 'package:flutter_check_af/flutter_check_af.dart';
import 'package:flutter_check_af/request_af/request_af_callback.dart';
import 'package:flutter_check_af/request_cloak/request_cloak_callback.dart';
import 'package:flutter_tba_info/flutter_tba_info.dart';
import 'package:psn_root/psn_root_utils/psn_local_info.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_utils/psn_tba/psn_b_tba_utils.dart';
import 'package:psn_root/psn_root_utils/psn_tba_point_enum.dart';

class PsnBCheckUserUtils{
  static final PsnBCheckUserUtils _utils=PsnBCheckUserUtils();
  static PsnBCheckUserUtils get instance => _utils;

  Function()? aPackageCallback;

  initCheck()async{
    FlutterCheckAf.instance.init(
      afKey: PsnLocalInfo.afKeyBase64.base64(),
      afAppId: PsnLocalInfo.afAppId,
      afSwitch: "1",
      distinctId: await FlutterTbaInfo.instance.getDistinctId(),
      clockUrl: PsnLocalInfo.cloakUrl,
      cloakWhiteKey: "fault",
      cloakData: await _createCloakMap(),
      requestAfCallback: RequestAfCallback(
        startRequestAf: (){
          PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.af_req);
        },
        requestSuccess: (bool isB){
          PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.af_suc,params: {"adj_user":isB?1:0});
          _checkUser();
        },
        firstRequestAfB: (){
          PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.organic_to_buy);
        },
        startAfSuccess: (){},
        startAfFail: (int code,String msg){},
      ),
      requestCloakCallback: RequestCloakCallback(
        startRequestCloak: (){
          PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.cloak_req);
        },
        requestSuccess: (bool isWhite){
          //cloak_user：【0】【1】，对应【黑名单用户】【自然量用户】
          PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.cloak_suc,params: {"cloak_user":isWhite?1:0});
          _checkUser();
        },
      ),
    );
  }

  _checkUser(){
    if(Platform.isAndroid){
      return;
    }
    if(FlutterCheckAf.instance.checkUser()){
      aPackageCallback?.call();
    }
  }

  Future<Map<String,dynamic>> _createCloakMap()async=>{
    "hiroshi":await FlutterTbaInfo.instance.getBundleId(),
    "blush":Platform.isAndroid?"theft":"knoll",
    "add":await FlutterTbaInfo.instance.getAppVersion(),
    "whack":await FlutterTbaInfo.instance.getDistinctId(),
    "coconut":DateTime.now().millisecondsSinceEpoch,
    "alumina":await FlutterTbaInfo.instance.getDeviceModel(),
    "fallow":await FlutterTbaInfo.instance.getOsVersion(),
    "stead":await FlutterTbaInfo.instance.getIdfv(),
    "wiry":await FlutterTbaInfo.instance.getGaid(),
    "bernardo":await FlutterTbaInfo.instance.getAndroidId(),
    "compare":await FlutterTbaInfo.instance.getIdfa(),
  };
}