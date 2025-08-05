import 'package:get/get.dart';
import 'package:psn_a/psn_a_page/psn_a_collector_win/psn_a_collector_win.dart';
import 'package:psn_a/psn_a_page/psn_a_dog_win/psn_a_dog_win.dart';
import 'package:psn_a/psn_a_page/psn_a_fruit/psn_a_fruit_page.dart';
import 'package:psn_a/psn_a_page/psn_a_king_win/psn_a_king_card.dart';
import 'package:psn_a/psn_a_page/psn_a_lucky7/psn_a_lucky7_page.dart';
import 'package:psn_a/psn_a_page/psn_a_home/psn_a_home_page.dart';
import 'package:psn_a/psn_a_page/psn_a_number/psn_a_number_page.dart';

class PsnAPageName{
  static final String home="/a/home";
  static final String lucky7="/a/lucky7";
  static final String collectorWin="/a/collectorWin";
  static final String dogWin="/a/dogWin";
  static final String kingCard="/a/kingCard";
  static final String fruit="/a/fruit";
  static final String number="/a/number";
}

var aPageList=[
  GetPage(
      name: PsnAPageName.home,
      page: ()=> PsnAHomePage(),
      transition: Transition.fadeIn
  ),
  GetPage(
      name: PsnAPageName.lucky7,
      page: ()=> PsnALucky7Page(),
      transition: Transition.fadeIn
  ),
  GetPage(
      name: PsnAPageName.collectorWin,
      page: ()=> PsnACollectorWin(),
      transition: Transition.fadeIn
  ),
  GetPage(
      name: PsnAPageName.dogWin,
      page: ()=> PsnADogWin(),
      transition: Transition.fadeIn
  ),
  GetPage(
      name: PsnAPageName.kingCard,
      page: ()=> PsnAKingCard(),
      transition: Transition.fadeIn
  ),
  GetPage(
      name: PsnAPageName.fruit,
      page: ()=> PsnAFruitPage(),
      transition: Transition.fadeIn
  ),
  GetPage(
      name: PsnAPageName.number,
      page: ()=> PsnANumberPage(),
      transition: Transition.fadeIn
  ),
];