import 'package:c115/psn_launch/psn_launch_page.dart';
import 'package:c115/psn_web/psn_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:psn_a/psn_a_routers/psn_a_page_list.dart';
import 'package:psn_a/psn_a_utils/psn_a_user_info_utils.dart';
import 'package:psn_b/psn_b_routers/psn_b_page_list.dart';
import 'package:psn_b/psn_b_utils/psn_b_user_info_utils.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarDividerColor: null,
        statusBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
      )
  );
  await GetStorage.init();
  await PsnAUserInfoUtils.instance.initCardInfo();


  await initSpineFlutter();
  await PsnBUserInfoUtils.instance.initCardInfo();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => ScreenUtilInit(
    designSize: const Size(750, 1624),
    builder: (c,child)=>GetMaterialApp(
      title: 'PrizeScratch Nexus',
      enableLog: true,
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      initialRoute: RootPageName.launch,
      debugShowCheckedModeBanner: false,
      getPages: rootPageList+aPageList+bPageList,
      defaultTransition: Transition.rightToLeft,
    ),
  );
}

class RootPageName{
  static final String launch="/root/launch";
  static final String web="/root/web";
}

var rootPageList=[
  GetPage(
      name: RootPageName.launch,
      page: ()=> PsnLaunchPage(),
      transition: Transition.fadeIn
  ),
  GetPage(
      name: RootPageName.web,
      page: ()=> PsnWeb(),
      transition: Transition.fadeIn
  ),
];

