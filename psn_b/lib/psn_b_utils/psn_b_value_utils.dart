import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:psn_b/psn_b_bean/psb_b_value_bean.dart';
import 'package:psn_b/psn_b_storage/psn_b_storage.dart';
import 'package:psn_b/psn_b_utils/pns_b_card_type_enum.dart';
import 'package:psn_b/psn_b_utils/psn_b_utils.dart';
import 'package:psn_root/psn_root_utils/psn_firebase_utils.dart';
import 'package:psn_root/psn_root_utils/psn_local_info.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';

class PsnBValueUtils {
  static final PsnBValueUtils _utils=PsnBValueUtils();
  static PsnBValueUtils get instance => _utils;

  PsbBValueBean? _valueBean;

  setCallbackAndInit(){
    PsnFirebaseUtils.instance.valueCallback=(){
      initValue();
    };
    initValue();
  }

  initValue(){
    try{
      var data = psnValueConfigStr.getData();
      if(data.isEmpty){
        data = PsnLocalInfo.valueStr.base64();
      }
      _valueBean=PsbBValueBean.fromJson(jsonDecode(data));
    }catch(e){
      _valueBean=PsbBValueBean.fromJson(jsonDecode(PsnLocalInfo.valueStr.base64()));
    }
  }

  bool showAd(AdType type){
    if(kDebugMode){
      return false;
    }
    if(type==AdType.reward){
      return true;
    }
    var list = _valueBean?.adIncentives??[];
    if(list.isEmpty){
      return false;
    }
    var last = list.last;
    var coinsNum = bUserCoins.getData();
    if(coinsNum>=(last.upperBound??1000)){
      return Random().nextInt(100)<(last.points??60);
    }
    for (var value in list) {
      if(coinsNum>=(value.lowerBound??0)&&coinsNum<(value.upperBound??0)){
        return Random().nextInt(100)<(value.points??60);
      }
    }
    return true;
  }

  List<int> getCashList()=>[1000,2000,3000,5000,10000];

  double getBoxReward()=>_getReward(_valueBean?.loginBonuses??[]);

  bool getLucky7Point()=>Random().nextInt(100)<(_valueBean?.lucky7Reward?.point??25);
  bool getCollectorPoint1()=>Random().nextInt(100)<(_valueBean?.collectorWinReward?.point1??30);
  bool getCollectorPoint2()=>Random().nextInt(100)<(_valueBean?.collectorWinReward?.point2??30);
  bool getCollectorPoint3()=>Random().nextInt(100)<(_valueBean?.collectorWinReward?.point3??20);
  bool getCollectorPoint4()=>Random().nextInt(100)<(_valueBean?.collectorWinReward?.point4??10);

  List<Map<int, double>> getDogPoint(){
    var point3 = _valueBean?.dogWinningReward?.point3??10;
    var point4 = _valueBean?.dogWinningReward?.point4??20;
    var point5 = _valueBean?.dogWinningReward?.point5??20;
    var point6 = _valueBean?.dogWinningReward?.point6??20;
    var point7 = _valueBean?.dogWinningReward?.point7??2;
    var point8 = _valueBean?.dogWinningReward?.point8??1;
    var point9 = _valueBean?.dogWinningReward?.point9??0.2;
    var point10 = _valueBean?.dogWinningReward?.point10??10;
    var point2 = 100-point3-point4-point5-point6-point7-point8-point9-point10;
    return [
      {2: point2},
      {3: point3},
      {4: point4},
      {5: point5},
      {6: point6},
      {7: point7},
      {8: point8},
      {9: point9},
      {10: point10},
    ];
  }

  List<Map<int, double>> getKingPoint()=>[
    {1: _valueBean?.cardKingReward?.point1??30},
    {2: _valueBean?.cardKingReward?.point2??30},
    {3: _valueBean?.cardKingReward?.point3??30},
    {4: _valueBean?.cardKingReward?.point4??10},
  ];

  List<Map<int, double>> getFruitPoint()=>[
    {1: _valueBean?.fruitLineupReward?.point1??30},
    {2: _valueBean?.fruitLineupReward?.point2??30},
    {3: _valueBean?.fruitLineupReward?.point3??30},
    {4: _valueBean?.fruitLineupReward?.point4??10},
  ];

  List<Map<int, double>> getNumberPoint()=>[
    {1: _valueBean?.numberWinnerReward?.point1??20},
    {2: _valueBean?.numberWinnerReward?.point2??20},
    {3: _valueBean?.numberWinnerReward?.point3??30},
    {4: _valueBean?.numberWinnerReward?.point4??20},
    {5: _valueBean?.numberWinnerReward?.point4??10},
  ];

  //获取刮卡奖励
  double getCardReward(PsnBCardTypeEnum type){
    switch(type){
      case PsnBCardTypeEnum.collectorWin:
        return _getReward(_valueBean?.collectorWinReward?.reward??[]);
      case PsnBCardTypeEnum.dogWinning:
        return _getReward(_valueBean?.dogWinningReward?.reward??[]);
      case PsnBCardTypeEnum.fruitLineup:
        return _getReward(_valueBean?.fruitLineupReward?.reward??[]);
      case PsnBCardTypeEnum.kingOfCards:
        return _getReward(_valueBean?.cardKingReward?.reward??[]);
      case PsnBCardTypeEnum.lucky7:
        return _getReward(_valueBean?.lucky7Reward?.reward??[]);
      case PsnBCardTypeEnum.numberWinner:
        return _getReward(_valueBean?.numberWinnerReward?.reward??[]);
    }
  }

  double _getReward(List<Reward> list){
    if(list.isEmpty){
      return 0.0;
    }
    var last = list.last;
    var coinsNum = bUserCoins.getData();
    if(coinsNum>=(last.upperBound??1000)){
      return _getRandomDouble(last.reward??[]);
    }
    for (var value in list) {
      if(coinsNum>=(value.lowerBound??0)&&coinsNum<(value.upperBound??0)){
        return _getRandomDouble(value.reward??[]);
      }
    }
    return 0.0;
  }

  double _getRandomDouble(List<int> list) {
    if(list.isEmpty){
      return 0.0;
    }
    if(list.length==1){
      return list.first.toDouble();
    }
    var min = list.first;
    var max = list.last;
    final random = Random();
    double value = min + random.nextDouble() * (max - min);
    return value.toStringAsFixed(2).toDouble();
  }

  WithdrawTask? getFirstCashTaskConfig(){
    var list = _valueBean?.withdrawTask??[];
    if(list.isEmpty){
      return null;
    }
    return list.first;
  }

  WithdrawTask? getCashTaskConfigByID(int? id){
    var list = _valueBean?.withdrawTask??[];
    var indexWhere = list.indexWhere((value)=>value.id==id);
    if(indexWhere>=0){
      return list[indexWhere];
    }
    return null;
  }

  WithdrawTask? getNextCashTaskConfigByID(int? id){
    var list = _valueBean?.withdrawTask??[];
    var indexWhere = list.indexWhere((value)=>value.id==id);
    try{
      if(indexWhere>=0){
        return list[indexWhere+1];
      }
      return null;
    }catch(e){
      return null;
    }
  }

  double getWheelReward()=>_getReward(_valueBean?.spinWheelPrizes??[]);

  double getLuckyCardReward()=>_getReward(_valueBean?.luckyCardPrizes??[]);

  int getUpLevelReward(){
    try{
      var bean = calculateLevel();
      var list = _valueBean?.levelUpPrizes??[];
      return list[bean.level-1];
    }catch(e){
      var list = _valueBean?.levelUpPrizes??[];
      if(list.isEmpty){
        return 0;
      }
      return list.last;
    }
  }
}