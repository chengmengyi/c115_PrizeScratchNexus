import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_custom_facebook/flutter_custom_facebook.dart';
import 'package:psn_root/psn_root_utils/psn_local_info.dart';
import 'package:psn_root/psn_root_utils/psn_root_storage.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';

class PsnFbUtils{
  static final PsnFbUtils _utils=PsnFbUtils();
  static PsnFbUtils get instance => _utils;

  var _initResult=false;

  initFb()async{
    if(kDebugMode&&Platform.isAndroid){
      return;
    }
    var data = psnFacebookConfig.getData();
    if(data.isEmpty){
      data=PsnLocalInfo.fbLocalStrBase64.base64();
    }
    var json = jsonDecode(data);
    _initResult = await FlutterCustomFacebook.instance.initFaceBook(facebookId: json["app_id"], facebookToken: json["client_token"], facebookAppName: json["app_name"],);
  }

  logPurchase(double amount){
    if(!_initResult){
      return;
    }
    FlutterCustomFacebook.instance.logPurchase(amount: amount, currency: "USD");
  }
}