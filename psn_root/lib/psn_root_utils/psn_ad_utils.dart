import 'dart:convert';

import 'package:flutter_ad_ios_plugins/data/ad_info_data.dart';
import 'package:flutter_ad_ios_plugins/data/config_ad_data.dart';
import 'package:flutter_ad_ios_plugins/flutter_ios_ad_hep.dart';
import 'package:flutter_ad_ios_plugins/hep/ad_type.dart';
import 'package:flutter_ad_ios_plugins/hep/ios_ad_callback.dart';
import 'package:flutter_ad_ios_plugins/hep/ios_load_ad_result_callback.dart';
import 'package:psn_root/psn_b_dialog/psn_b_ad_fail_dialog/psn_b_ad_fail_dialog.dart';
import 'package:psn_root/psn_b_dialog/psn_b_ad_limit_dialog/psn_b_ad_limit_dialog.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';
import 'package:psn_root/psn_root_utils/psn_ad_event_enum.dart';
import 'package:psn_root/psn_root_utils/psn_b_fk_utils.dart';
import 'package:psn_root/psn_root_utils/psn_firebase_utils.dart';
import 'package:psn_root/psn_root_utils/psn_local_info.dart';
import 'package:psn_root/psn_root_utils/psn_music_utils.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_utils/psn_tba/psn_b_tba_utils.dart';
import 'package:psn_root/psn_root_utils/psn_tba_point_enum.dart';

class PsnAdUtils{
  static final PsnAdUtils _utils=PsnAdUtils();
  static PsnAdUtils get instance => _utils;

  initAd(){
    FlutterIosAdHep.instance.initMax(
      maxKey: PsnLocalInfo.maxKeyBase64.base64(),
      topOnAppId: PsnLocalInfo.topOnAppId.base64(),
      topOnAppKey: PsnLocalInfo.topOnAppKey.base64(),
      data: _createAdData(),
      fengKongLogic: (){
        return false;
      },
      iosLoadAdResultCallback: IosLoadAdResultCallback(
        startLoadAdCallback: (info){

        },
        loadAdSuccessCallback: (maxAd,info){},
        loadAdFailCallback: (info){},
      ),
    );
  }

  showAdBBBBBB({
    required AdType adType,
    required PsnAdEventEnum evnetEnum,
    required bool showAd,
    required Function() closeCallback,
    bool isOpen=false,
  }){
    if(!showAd){
      closeCallback.call();
      return;
    }
    if(AdNumHep.instance.notLoad()||PsnBFkUtils.instance.isFk()){
      if(isOpen){
        closeCallback.call();
        return;
      }
      PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.dialog, content: PsnBAdLimitDialog());
      return;
    }
    PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.apwxi_ad_chance,params: {"ad_pos_id":evnetEnum.name});
    var resultData = FlutterIosAdHep.instance.getCacheResultData(adType);
    if(null==resultData){
      FlutterIosAdHep.instance.loadAdWhenNoCache(adType);
      PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.apwxi_ad_no_chance,params: {"ad_pos_id":evnetEnum.name});
      if(isOpen){
        closeCallback.call();
      }else{
        PsnRootRouters.instance.router(
            routersEnum: PsnRoutersEnum.dialog,
            content: PsnBAdFailDialog(
              clickTryCallback: (){
                var data = FlutterIosAdHep.instance.getCacheResultData(adType);
                if(null==data){
                  closeCallback.call();
                }else{
                  _show(adType: adType, evnetEnum: evnetEnum, closeAd: closeCallback);
                }
              },
            ),
        );
      }
      return;
    }
    _show(adType: adType, evnetEnum: evnetEnum, closeAd: closeCallback);
  }

  _show({
    required AdType adType,
    required PsnAdEventEnum evnetEnum,
    required Function() closeAd,
    bool isOpen=false,
  }){
    FlutterIosAdHep.instance.showAd(
      adType: adType,
      iosAdCallback: IosAdCallback(
        showSuccess: (ad,info){
          // _handleTwoShowAdTime(adType);
          // // FlutterCustomFacebook.instance.logPurchase(amount: ad?.revenue??0, currency: "USD");
          // FlutterCheckAf.instance.uploadAdRevenue(ad?.networkName??"", ad?.revenue??0, ad?.adUnitId??"", adPosId.name);
          // TTTTUtils.instance.adEvent(ad: ad, adPosId: adPosId, adInfoData: info);
          // VoicePlayUtils.instance.pauseBg();
          // p2LookAdNum.saveData(p2LookAdNum.getData()+1);
          // var adLevel = p2LastAdLevel.getData()+5;
          // if(p2LookAdNum.getData()>=adLevel){
          //   TTTTUtils.instance.pointEvent(customId: CustomId.cash_ad_detail,params: {"ad":adLevel});
          //   p2LastAdLevel.saveData(adLevel);
          // }
        },
        showFail: (){
          PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.apwxi_ad_impression_fail,params: {"ad_pos_id":evnetEnum.name});
          if(isOpen){
            closeAd.call();
          }else{
            if(adType==AdType.reward){
              "Advertisement display failed, please try again later".showToast();
            }else{
              closeAd.call();
            }
          }
        },
        closeAd: (){
          PsnMusicUtils.instance.playBackMp3();
          closeAd.call();
        },
        revenuePaid: (ad,info){
          // _handleRvLookCount(adType);
        },
      ),
    );
  }


  ConfigAdData _createAdData(){
    var data = psnAdConfigStr.getData();
    if(data.isEmpty){
      data=PsnLocalInfo.adStr.base64();
    }
    var json = jsonDecode(data);
    return ConfigAdData(
      maxShowNum: json["dqpdgttu"],
      maxClickNum: json["fkjpztlk"],
      priceSwitch: json["apwxi_switch"]??false,
      newInterList: _getAdList(json["apwxi_int"]),
      newRewardList: _getAdList(json["apwxi_rv"]),
    );
  }

  List<AdInfoData> _getAdList(List? list){
    if(null==list){
      return [];
    }
    List<AdInfoData> resultList=[];
    for (var value in list) {
      resultList.add(
          AdInfoData(
            adId: value["bzhcoldl"],
            adPlat: value["rmoezcsw"],
            adType: value["ngixgfpw"]=="reward"?AdType.reward:AdType.interstitial,
            expireTime: value["euovnizy"],
          )
      );
    }
    return resultList;
  }
}