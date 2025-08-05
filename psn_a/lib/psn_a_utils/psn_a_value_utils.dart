import 'dart:math';

class PsnAValueUtils {
  static final PsnAValueUtils _utils=PsnAValueUtils();
  static PsnAValueUtils get instance => _utils;

  bool getLucky7Point()=>Random().nextInt(100)<25;
  bool getCollectorPoint1()=>Random().nextInt(100)<30;
  bool getCollectorPoint2()=>Random().nextInt(100)<30;
  bool getCollectorPoint3()=>Random().nextInt(100)<20;
  bool getCollectorPoint4()=>Random().nextInt(100)<10;

  int getReward(){
    final random = Random();
    return 500 + random.nextInt(501);
  }
}