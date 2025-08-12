import 'package:get/get.dart';
import 'package:psn_b/psn_b_page/psn_b_collector_win/psn_b_collector_win.dart';
import 'package:psn_b/psn_b_page/psn_b_dog_win/psn_b_dog_win.dart';
import 'package:psn_b/psn_b_page/psn_b_fruit/psn_b_fruit_page.dart';
import 'package:psn_b/psn_b_page/psn_b_king_win/psn_b_king_card.dart';
import 'package:psn_b/psn_b_page/psn_b_lucky7/psn_b_lucky7_page.dart';
import 'package:psn_b/psn_b_page/psn_b_home/psn_b_home_page.dart';
import 'package:psn_b/psn_b_page/psn_b_number/psn_b_number_page.dart';

class PsnBPageName{
  static final String home="/b/home";
  static final String lucky7="/b/lucky7";
  static final String collectorWin="/b/collectorWin";
  static final String dogWin="/b/dogWin";
  static final String kingCard="/b/kingCard";
  static final String fruit="/b/fruit";
  static final String number="/b/number";
}

var bPageList=[
  GetPage(
      name: PsnBPageName.home,
      page: ()=> PsnBHomePage(),
      transition: Transition.fadeIn
  ),
  GetPage(
      name: PsnBPageName.lucky7,
      page: ()=> PsnBLucky7Page(),
      transition: Transition.fadeIn
  ),
  GetPage(
      name: PsnBPageName.collectorWin,
      page: ()=> PsnBCollectorWin(),
      transition: Transition.fadeIn
  ),
  GetPage(
      name: PsnBPageName.dogWin,
      page: ()=> PsnBDogWin(),
      transition: Transition.fadeIn
  ),
  GetPage(
      name: PsnBPageName.kingCard,
      page: ()=> PsnBKingCard(),
      transition: Transition.fadeIn
  ),
  GetPage(
      name: PsnBPageName.fruit,
      page: ()=> PsnBFruitPage(),
      transition: Transition.fadeIn
  ),
  GetPage(
      name: PsnBPageName.number,
      page: ()=> PsnBNumberPage(),
      transition: Transition.fadeIn
  ),
];