import 'dart:math';

class PsnBValueUtils {
  static final PsnBValueUtils _utils=PsnBValueUtils();
  static PsnBValueUtils get instance => _utils;

  double getBoxReward()=>0.05;

  bool getLucky7Point()=>Random().nextInt(100)<25;
  bool getCollectorPoint1()=>Random().nextInt(100)<30;
  bool getCollectorPoint2()=>Random().nextInt(100)<30;
  bool getCollectorPoint3()=>Random().nextInt(100)<20;
  bool getCollectorPoint4()=>Random().nextInt(100)<10;

  int getReward()=>1;
}