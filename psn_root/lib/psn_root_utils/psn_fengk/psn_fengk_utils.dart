import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_ad_ios_plugins/flutter_ios_ad_hep.dart';
import 'package:flutter_check_af/dio/dio_hep.dart';
import 'package:psn_root/psn_root_utils/psn_fengk/psn_fengk_bean.dart';
import 'package:psn_root/psn_root_utils/psn_firebase_utils.dart';
import 'package:psn_root/psn_root_utils/psn_local_info.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_storage.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_utils/psn_tba/psn_b_tba_utils.dart';
import 'package:psn_root/psn_root_utils/psn_tba_point_enum.dart';



class PsnFengkUtils{
  static final PsnFengkUtils _utils=PsnFengkUtils();
  static PsnFengkUtils get instance => _utils;

  var _hasInit=false;
  PsnFengkBean? _fengkBean;

  initFengK(){
    if(_hasInit){
      return;
    }
    _initFengKBean();
    FlutterIosAdHep.instance.setEverydayWatchAdNum(_fengkBean?.behavior?.adDailyShow??60);
    _checkDevice();
  }

  _checkDevice(){
    _checkRootDevice();
    _checkVpnDevice();
    _checkSimDevice();
    _checkSimulatorDevice();
    _checkDeveloperDevice();
    _checkStoreDevice();
    _checkIpDevice();
    _checkNumDevice();
  }

  _checkRootDevice()async{
    var root = await Psn.instance.root();
    tbaSessionCustom({"root":root?1:0});
    if(root&&_fengkBean?.ui?.device!=0&&_checkHasDevice("root")){
      tbaUploadFengkTag("root");
    }
  }

  _checkVpnDevice()async{
    var vpn = await Psn.instance.vpn();
    tbaSessionCustom({"vpn":vpn?1:0});
    if(vpn&&_fengkBean?.ui?.device!=0&&_checkHasDevice("vpn")){
      tbaUploadFengkTag("vpn");
    }
  }

  _checkSimDevice()async{
    var sim = await Psn.instance.sim();
    tbaSessionCustom({"sim":sim?1:0});
    if(!sim&&_fengkBean?.ui?.device!=0&&_checkHasDevice("sim")){
      tbaUploadFengkTag("sim");
    }
  }

  _checkSimulatorDevice()async{
    var simulator = await Psn.instance.simulator();
    tbaSessionCustom({"simulator":simulator?1:0});
    if(simulator&&_fengkBean?.ui?.device!=0&&_checkHasDevice("simulator")){
      tbaUploadFengkTag("simulator");
    }
  }

  _checkDeveloperDevice()async{
    var developer = await Psn.instance.developer();
    tbaSessionCustom({"developer":developer?1:0});
    if(developer&&_fengkBean?.ui?.device!=0&&_checkHasDevice("developer")){
      tbaUploadFengkTag("developer");
    }
  }

  _checkStoreDevice()async{
    var googleplay = await Psn.instance.store();
    tbaSessionCustom({"googleplay":googleplay?1:0});
    if(!googleplay&&_fengkBean?.ui?.device!=0&&_checkHasDevice("googleplay")){
      tbaUploadFengkTag("googleplay");
    }
  }

  _checkNumDevice()async{
    var numberUnitID = await Psn.instance.getNumberUnitID();
    var dioResult = await DioHep.instance.requestPost(
      path: "https://sg-ddi.shuzilm.cn/q",
      data: {"protocol":2,"pkg":await FlutterTbaInfo.instance.getBundleId(),"did":numberUnitID},
    );
    print("kk=====${await FlutterTbaInfo.instance.getBundleId()}===${dioResult.success}===${dioResult.msg}");
    if(dioResult.success){
      try{
        _hasInit=true;
        var json = jsonDecode(dioResult.msg);
        if(json["err"]==0&&json["device_type"]!=0&&_fengkBean?.ui?.number==1){
          tbaUploadFengkTag("number");
        }else{

        }
      }catch(e){

      }
    }
  }

  _checkIpDevice()async{
    var dioResult = await DioHep.instance.requestPost(
      path: "https://ip-prod.prizescratch.com/api/cmonkey",
      data: {
        "acat":await FlutterTbaInfo.instance.getAndroidId(),
      },
    );
    if(dioResult.success){
      try{
        var result = decrypt(dioResult.msg, 13);
        var bfrog = jsonDecode(result)["data"]["bfrog"];
        if(bfrog&&_fengkBean?.ui?.device!=0&&_checkHasDevice("ip")){
          tbaUploadFengkTag("ip");
        }
      }catch(e){}
    }
  }

  bool _checkHasDevice(String type)=>_fengkBean?.device?.contains(type)==true;

  tbaUploadFengkTag(String source){
    psnAlreadyFengKSource.saveData(source);
    PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.risk_chance,params: {"risk_from":source});
  }

  tbaSessionCustom(Map<String,dynamic> map){
    PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.session_custom,params: map);
  }

  _initFengKBean(){
    try{
      var data = psnFengKConfigStr.getData();
      if(data.isEmpty){
        data=PsnLocalInfo.fengKStrBase64.base64();
      }
      _fengkBean=PsnFengkBean.fromJson(jsonDecode(data));
    }catch(e){
      _fengkBean=PsnFengkBean.fromJson(jsonDecode(PsnLocalInfo.fengKStrBase64.base64()));
    }
  }

  AdShortShow? getAdShortShow()=>_fengkBean?.behavior?.adShortShow;

  AdShortClose? getAdShortClose()=>_fengkBean?.behavior?.adShortClose;

  bool isFk(){
    if(kDebugMode){
      return false;
    }
    var data = psnAlreadyFengKSource.getData();
    if(data.isNotEmpty){
      tbaUploadFengkTag(data);
      return true;
    }
    if(_fengkBean?.ui?.behavior!=1){
      return false;
    }
    if(_checkTwoRewardAdTimeNum()){
      tbaUploadFengkTag("ad_short_show");
      return true;
    }
    if(_checkShortClose()){
      tbaUploadFengkTag("ad_short_close");
      return true;
    }
    if(_checkDeemAdLess()){
      tbaUploadFengkTag("wrong_deem_ad_less");
      return true;
    }
    if(_checkDeemAdMore()){
      tbaUploadFengkTag("wrong_deem_ad_more");
      return true;
    }
    return false;
  }

  bool _checkTwoRewardAdTimeNum(){
    var data = psnTwoRewardAdTimeNum.getData();
    var i = getAdShortShow()?.value??3;
    return data>=i;
  }

  bool _checkShortClose(){
    var data = psnCloseRewardAdTimeNum.getData();
    var i = getAdShortClose()?.value??3;
    return data>=i;
  }

  bool _checkDeemAdLess()=>psnDeemAdLess.getData();

  bool _checkDeemAdMore()=>psnDeemAdMore.getData();

  int getWrongDeemAdLess()=>_fengkBean?.behavior?.wrongDeemAdLess??3;
  int getWrongDeemAdMore()=>_fengkBean?.behavior?.wrongDeemAdMore??90;
}