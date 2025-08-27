import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:psn_root/psn_root_utils/psn_fb_utils.dart';
import 'package:psn_root/psn_root_utils/psn_fengk/psn_fengk_utils.dart';
import 'package:psn_root/psn_root_utils/psn_root_storage.dart';


class PsnFirebaseUtils{
  static final PsnFirebaseUtils _utils = PsnFirebaseUtils();
  static PsnFirebaseUtils get instance => _utils;
  Function()? valueCallback;

  FirebaseRemoteConfig? _remoteConfig;

  initFirebase()async{
    try{
      await Firebase.initializeApp();
      _remoteConfig=FirebaseRemoteConfig.instance;
      await _remoteConfig?.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(seconds: 1),
      ));
      await _remoteConfig?.fetchAndActivate();
      _getFirebaseConfig();
    }catch(e){
      await Future.delayed(const Duration(milliseconds: 1000));
      initFirebase();
      PsnFbUtils.instance.initFb();
    }
  }

  _getFirebaseConfig(){
    var br_numbers_us = _remoteConfig?.getString("br_numbers_us")??"";
    if(br_numbers_us.isNotEmpty&&psnValueConfigStr.getData().isEmpty){
      psnValueConfigStr.saveData(br_numbers_us);
      valueCallback?.call();
    }
    var apwxi_ad_config = _remoteConfig?.getString("apwxi_ad_config")??"";
    if(apwxi_ad_config.isNotEmpty){
      psnAdConfigStr.saveData(apwxi_ad_config);
    }
    var risk_control = _remoteConfig?.getString("risk_control")??"";
    if(risk_control.isNotEmpty){
      psnFengKConfigStr.saveData(risk_control);
      PsnFengkUtils.instance.initFengK();
    }
    var prizescratch_fb_inform = _remoteConfig?.getString("prizescratch_fb_inform")??"";
    if(prizescratch_fb_inform.isNotEmpty){
      psnFacebookConfig.saveData(prizescratch_fb_inform);
      PsnFbUtils.instance.initFb();
    }
  }
}