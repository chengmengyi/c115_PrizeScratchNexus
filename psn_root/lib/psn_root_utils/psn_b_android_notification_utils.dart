import 'dart:io';

import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_utils/psn_tba/psn_b_tba_utils.dart';
import 'package:psn_root/psn_root_utils/psn_tba_point_enum.dart';

class NotificationBean{
  String title;
  String content;
  NotificationBean({
    required this.title,
    required this.content,
});
}

class PsnBAndroidNotificationUtils{
  static final PsnBAndroidNotificationUtils _utils=PsnBAndroidNotificationUtils();
  static PsnBAndroidNotificationUtils get instance => _utils;

  AndroidFlutterLocalNotificationsPlugin plugin=AndroidFlutterLocalNotificationsPlugin();

  final List<NotificationBean> _list=[
    NotificationBean(title: "Scratch for Cash", content: "One scratch, instant cash—try your luck!"),
    NotificationBean(title: "Sign in to receive a grand prize！", content: "Check in today! Streak surprises!"),
    NotificationBean(title: "Scratch for Rewards", content: "Scratch away, earn more—your next cash prize is hidden!"),
    NotificationBean(title: "New Coins Arrived!", content: "New coins! See how much!"),
    NotificationBean(title: "Scratch Cash Bonanza", content: "Scratch into a cash bonanza—big wins for lucky scratchers!"),
    NotificationBean(title: "Mystery Cash Scratch", content: "Scratch the mystery, reveal cash—what will you win?"),
    NotificationBean(title: "Cash Scratch Rush", content: "Join the rush, scratch for cash—your next win is seconds away!"),
    NotificationBean(title: "Cash Awaits Your Scratch", content: "One scratch, instant cash—your lucky day is here!"),
    NotificationBean(title: "Scratch for Big Bucks", content: "Small scratch, big bucks—win more than you expect!"),
    NotificationBean(title: "Grand Prize Arrives", content: "A new round of massive prizes is ready—unveil your moment of luck now!"),
  ];

  final List<NotificationBean> _lockNotificationList=[
    NotificationBean(title: "Scratch & Cash! 🎯", content: "\$500 instant win—cash out today!"),
    NotificationBean(title: "Jackpot Scratch! 🎰", content: "\$1,000 prize revealed—claim your cash!"),
    NotificationBean(title: "Cash Blast! 💥", content: "Scratch now for \$200 instant payout!"),
    NotificationBean(title: "Win & Withdraw! 💰", content: "\$300 waiting—scrape to claim!"),
  ];

  initNotification()async{
    if(Platform.isIOS){
      return;
    }
    var status = await Permission.notification.request();
    if(!status.isGranted){
      return;
    }
    var success = await plugin.initialize(
      AndroidInitializationSettings("logo"),
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        _click(response.payload);
      },
    );
    if(success==true){
      PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.push_status);
      _showLocalNotification();
      _showLockNotification();
      _showFcmNotification();
    }
  }

  _showLocalNotification()async{
    for(var index=0;index<_list.length;index++){
      var bean = _list[index];
      AndroidNotificationDetails details = AndroidNotificationDetails(
        'psn_channel',
        'psn_channel_name',
        styleInformation: BeautyStyleInformation(
          bean.title,
          bean.content,
          'psn_local',
          'Go Earn',
          'logo',
        ),
        priority: Priority.high,
        importance: Importance.high,
        groupKey: "${index+1}",
      );
      await plugin.periodicallyShowWithDuration(
        index+1,
        bean.title,
        bean.content,
        Duration(hours: 1),
        notificationDetails: details,
        scheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        payload: "local",
      );
    }
  }

  _showLockNotification()async{
    NotificationBean bean = _lockNotificationList.random();
    await plugin.showBroadcastNotification(
      66,
      bean.title,
      bean.content,
      Duration(seconds: 1),
      'android.intent.action.USER_PRESENT',
      AndroidNotificationDetails(
        'psn_channel_lock',
        'psn_channel_name_lock',
        priority: Priority.high,
        importance: Importance.high,
        styleInformation: BeautyStyleInformation(
          bean.title,
          bean.content,
          'psn_lock',
          'Go Earn',
          'logo',
        ),
        groupKey: "66",
      ),
      'unlock',
    );
  }

  _showFcmNotification()async{
    var result = await plugin.subscribeToTopic(
      'c115_card_fcm',
      const AndroidNotificationDetails(
        'psn_channel_fcm',
        'psn_channel_name_fcm',
        styleInformation: BeautyStyleInformation(
          '',
          '',
          '',
          'Go Earn',
          'logo',
        ),
        priority: Priority.high,
        importance: Importance.high,
      ),
    );
  }

  _click(String? payload){
    PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.inform_c,params: {"type":payload});
  }

  checkLaunchAppFrom()async{
    var launchDetails = await plugin.getNotificationAppLaunchDetails();
    var fromNotification = launchDetails?.didNotificationLaunchApp==true;
    PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.launch_page,params: {"source_from":fromNotification?"push":"icon"});
    if(fromNotification){
      _click(launchDetails?.notificationResponse?.payload);
    }
    checkNotificationShowNum();
  }

  checkNotificationShowNum()async{
    var localNum = await plugin.extractMessageReceivedNum("local");
    if(localNum>0){
      for(var index=0;index<localNum;index++){
        PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.inform_show,params: {"type":"local"});
      }
    }
    var unlockNum = await plugin.extractMessageReceivedNum("unlock");
    if(unlockNum>0){
      for(var index=0;index<unlockNum;index++){
        PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.inform_show,params: {"type":"unlock"});
      }
    }
    var fcmNum = await plugin.extractMessageReceivedNum("fcm");
    if(fcmNum>0){
      for(var index=0;index<fcmNum;index++){
        PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.inform_show,params: {"type":"fcm"});
      }
    }
  }
}