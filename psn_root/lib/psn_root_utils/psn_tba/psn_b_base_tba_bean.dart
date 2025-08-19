import 'dart:io';

import 'package:psn_root/psn_root_utils/psn_root_export.dart';

class PsnBBaseTbaBean{
  Future<Map<String,dynamic>> getBaseMap()async=>{
    "brock":{
      "hiroshi" : await FlutterTbaInfo.instance.getBundleId(),
      "blush" : Platform.isAndroid?"theft":"knoll",
      "wiry" : await FlutterTbaInfo.instance.getGaid(),
      "rarefy" : await FlutterTbaInfo.instance.getLogId(),
      "alumina" : await FlutterTbaInfo.instance.getDeviceModel(),
      "fallow" : await FlutterTbaInfo.instance.getOsVersion(),
      "coconut" : DateTime.now().millisecondsSinceEpoch,
      "add" : await FlutterTbaInfo.instance.getAppVersion(),
      "chariot" : await FlutterTbaInfo.instance.getOperator(),
      "wing" : await FlutterTbaInfo.instance.getBrand(),
      "kimball" : await FlutterTbaInfo.instance.getSystemLanguage(),
      "whack" : await FlutterTbaInfo.instance.getDistinctId(),
      "johnson" : await FlutterTbaInfo.instance.getManufacturer(),
      "ed" : await FlutterTbaInfo.instance.getNetworkType(),
      "compare" : await FlutterTbaInfo.instance.getIdfa(),
      "stead" : await FlutterTbaInfo.instance.getIdfv(),
      "mcintosh" : await FlutterTbaInfo.instance.getOsCountry(),
      "bernardo" : await FlutterTbaInfo.instance.getAndroidId(),
    }
  };
}