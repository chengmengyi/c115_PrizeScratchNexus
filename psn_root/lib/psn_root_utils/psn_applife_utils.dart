import 'dart:async';
import 'package:flutter_android_ad_plugins/flutter_android_ad_plugins.dart';
import 'package:flutter_android_ad_plugins/hep/ad_type.dart';
import 'package:flutter_app_lifecycle/app_state_observer.dart';
import 'package:flutter_app_lifecycle/flutter_app_lifecycle.dart';
import 'package:psn_root/psn_root_utils/psn_ad_event_enum.dart';
import 'package:psn_root/psn_root_utils/psn_ad_utils.dart';
import 'package:psn_root/psn_root_utils/psn_b_android_notification_utils.dart';
import 'package:psn_root/psn_root_utils/psn_music_utils.dart';
import 'package:psn_root/psn_root_utils/psn_tba/psn_b_tba_utils.dart';

class PsnApplifeUtils{
  static final PsnApplifeUtils _utils=PsnApplifeUtils();
  static PsnApplifeUtils get instance => _utils;

  Timer? _psnTimer;
  var _isBackPsn=false,isToOpenNotifi=false;

  addLife(){
    FlutterAppLifecycle.instance.setCallObserver(
      AppStateObserver(
        call: (back){
          if(back){
            PsnMusicUtils.instance.pauseBackMp3();
            _psnTimer=Timer(Duration(milliseconds: 3000), () {
              _isBackPsn=true;
            });
          }else{
            PsnMusicUtils.instance.playBackMp3();
            PsnBTbaUtils.instance.sessionEvent();
            // PsnBAndroidNotificationUtils.instance.checkNotificationShowNum();
            _psnTimer?.cancel();
            Future.delayed(const Duration(milliseconds: 100),()async{
              if(isToOpenNotifi){
                await Future.delayed(Duration(milliseconds: 1000));
                PsnBAndroidNotificationUtils.instance.initNotification();
                isToOpenNotifi=false;
              }
              if(_isBackPsn&&!FlutterAndroidAdPlugins.instance.adShowing()){
                PsnAdUtils.instance.showAdBBBBBB(
                  adType: AdType.interstitial,
                  evnetEnum: PsnAdEventEnum.apwxi_launch,
                  showAd: true,
                  isOpen: true,
                  closeCallback: (){},
                  closeDialogNotGiveMoney: (){},
                );
              }
              _isBackPsn=false;
            });
          }
        },
      ),
    );
  }
}