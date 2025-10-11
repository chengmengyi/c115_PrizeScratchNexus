import 'dart:io';

import 'package:birdsong/birdsong.dart';
import 'package:flutter/foundation.dart';
import 'package:psn_root/psn_b_dialog/psn_b_no_notification_permission_dialog/psn_b_no_notification_permission_dialog.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_utils/psn_tba/psn_b_tba_utils.dart';
import 'package:psn_root/psn_root_utils/psn_tba_point_enum.dart';

class PsnBAndroidNotificationUtils{
  static final PsnBAndroidNotificationUtils _utils=PsnBAndroidNotificationUtils();
  static PsnBAndroidNotificationUtils get instance => _utils;

  // AndroidFlutterLocalNotificationsPlugin plugin=AndroidFlutterLocalNotificationsPlugin();

  final List<BirdsongText> _list=[
    BirdsongText(title: "Scratch for Cash", body: "One scratch, instant cash—try your luck!"),
    BirdsongText(title: "Sign in to receive a grand prize！", body: "Check in today! Streak surprises!"),
    BirdsongText(title: "Scratch for Rewards", body: "Scratch away, earn more—your next cash prize is hidden!"),
    BirdsongText(title: "New Coins Arrived!", body: "New coins! See how much!"),
    BirdsongText(title: "Scratch Cash Bonanza", body: "Scratch into a cash bonanza—big wins for lucky scratchers!"),
    BirdsongText(title: "Mystery Cash Scratch", body: "Scratch the mystery, reveal cash—what will you win?"),
    BirdsongText(title: "Cash Scratch Rush", body: "Join the rush, scratch for cash—your next win is seconds away!"),
    BirdsongText(title: "Cash Awaits Your Scratch", body: "One scratch, instant cash—your lucky day is here!"),
    BirdsongText(title: "Scratch for Big Bucks", body: "Small scratch, big bucks—win more than you expect!"),
    BirdsongText(title: "Grand Prize Arrives", body: "A new round of massive prizes is ready—unveil your moment of luck now!"),
  ];

  final List<BirdsongText> _lockNotificationList=[
    BirdsongText(title: "Scratch & Cash! 🎯", body: "\$500 instant win—cash out today!"),
    BirdsongText(title: "Jackpot Scratch! 🎰", body: "\$1,000 prize revealed—claim your cash!"),
    BirdsongText(title: "Cash Blast! 💥", body: "Scratch now for \$200 instant payout!"),
    BirdsongText(title: "Win & Withdraw! 💰", body: "\$300 waiting—scrape to claim!"),
  ];

  initNotification()async{
    if(Platform.isIOS){
      return;
    }
    var status = await Permission.notification.request();
    if(!status.isGranted){
      return;
    }
    await Birdsong.instance.initialize(
      image: BirdsongImage(big: "large", small: "small"),
      button: "Claim",
    );
    PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.push_status);
    _showLocalNotification();
    _showLockNotification();
    _showFcmNotification();
    _showListener();
    _clickListener();
  }

  checkHasNotificationPermission()async{
    final status = await Permission.notification.status;
    if (!status.isGranted) {
      PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.dialog, content: PsnBNoNotificationPermissionDialog());
    }
  }

  _showLocalNotification()async{
    Birdsong.instance.repeat(content: _list, duration: kDebugMode?Duration(minutes: 1):Duration(hours: 1));
    // for(var index=0;index<_list.length;index++){
    //   var bean = _list[index];
    //   AndroidNotificationDetails details = AndroidNotificationDetails(
    //     'psn_channel',
    //     'psn_channel_name',
    //     styleInformation: BeautyStyleInformation(
    //       bean.title,
    //       bean.content,
    //       'psn_local',
    //       'Go Earn',
    //       'logo',
    //     ),
    //     priority: Priority.high,
    //     importance: Importance.high,
    //     groupKey: "${index+1}",
    //   );
    //   await plugin.periodicallyShowWithDuration(
    //     index+1,
    //     bean.title,
    //     bean.content,
    //     Duration(hours: 1),
    //     notificationDetails: details,
    //     scheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    //     payload: "local",
    //   );
    // }
  }

  _showLockNotification()async{
    Birdsong.instance.present(content: _lockNotificationList, duration: kDebugMode?Duration(minutes: 1):Duration(hours: 1));
    // BirdsongText bean = _lockNotificationList.random();
    // await plugin.showBroadcastNotification(
    //   66,
    //   bean.title,
    //   bean.content,
    //   Duration(seconds: 1),
    //   'android.intent.action.USER_PRESENT',
    //   AndroidNotificationDetails(
    //     'psn_channel_lock',
    //     'psn_channel_name_lock',
    //     priority: Priority.high,
    //     importance: Importance.high,
    //     styleInformation: BeautyStyleInformation(
    //       bean.title,
    //       bean.content,
    //       'psn_lock',
    //       'Go Earn',
    //       'logo',
    //     ),
    //     groupKey: "66",
    //   ),
    //   'unlock',
    // );
  }

  _showFcmNotification()async{
    Birdsong.instance.subscribe(topic: "c115_card_fcm");
    // var result = await plugin.subscribeToTopic(
    //   'c115_card_fcm',
    //   const AndroidNotificationDetails(
    //     'psn_channel_fcm',
    //     'psn_channel_name_fcm',
    //     styleInformation: BeautyStyleInformation(
    //       '',
    //       '',
    //       '',
    //       'Go Earn',
    //       'logo',
    //     ),
    //     priority: Priority.high,
    //     importance: Importance.high,
    //   ),
    // );
  }

  // _click(String? payload){
  //   PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.inform_c,params: {"type":payload});
  // }

  _showListener(){
    Birdsong.instance.onTrigger.listen((e){
      checkNotificationShowNum(e.source);
    });
  }

  _clickListener(){
    Birdsong.instance.onTap.listen((e){
      checkNotificationClickNum(e.source);
    });
  }

  checkLaunchAppFrom()async{
    // var launchDetails = await plugin.getNotificationAppLaunchDetails();
    // var fromNotification = launchDetails?.didNotificationLaunchApp==true;
    // PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.launch_page,params: {"source_from":fromNotification?"push":"icon"});
    // if(fromNotification){
    //   _click(launchDetails?.notificationResponse?.payload);
    // }
    // checkNotificationShowNum();
  }

  checkNotificationShowNum(String source){
    var type=source;
    switch(source){
      case "firebase":
        type="fcm";
        break;
      case "repeat":
        type="local";
        break;
      case "present":
        type="unlock";
        break;
    }
    PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.inform_show,params: {"type":type});
  }

  checkNotificationClickNum(String source){
    var type=source;
    switch(source){
      case "firebase":
        type="fcm";
        break;
      case "repeat":
        type="local";
        break;
      case "present":
        type="unlock";
        break;
    }
    PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.inform_c,params: {"type":type});
  }
}