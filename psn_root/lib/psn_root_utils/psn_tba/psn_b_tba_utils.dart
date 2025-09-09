import 'dart:convert';

import 'package:applovin_max/applovin_max.dart';
import 'package:flutter_ad_ios_plugins/data/ad_info_data.dart';
import 'package:flutter_ad_ios_plugins/data/ad_money_info_bean.dart';
import 'package:flutter_ad_ios_plugins/hep/ad_num_hep.dart';
import 'package:flutter_ad_ios_plugins/hep/hep.dart';
import 'package:psn_root/psn_root_utils/psn_ad_event_enum.dart';
import 'package:psn_root/psn_root_utils/psn_fengk/psn_fengk_utils.dart';
import 'package:psn_root/psn_root_utils/psn_local_info.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_sql/psn_root_sql_name.dart';
import 'package:psn_root/psn_root_utils/psn_root_sql/psn_root_sql_utils.dart';
import 'package:psn_root/psn_root_utils/psn_tba/psn_b_ad_tba_bean.dart';
import 'package:psn_root/psn_root_utils/psn_tba/psn_b_base_tba_bean.dart';
import 'package:psn_root/psn_root_utils/psn_tba/psn_b_header_bean.dart';
import 'package:psn_root/psn_root_utils/psn_tba/psn_b_install_tba_bean.dart';
import 'package:psn_root/psn_root_utils/psn_tba/psn_b_point_tba_bean.dart';
import 'package:psn_root/psn_root_utils/psn_tba/psn_b_query_bean.dart';
import 'package:flutter_check_af/dio/dio_hep.dart';
import 'package:psn_root/psn_root_utils/psn_tba_point_enum.dart';


StorageData<bool> installEventStatus=StorageData<bool>(key: "installEventStatus", defaultValue: false);


class PsnBTbaUtils{
  static final PsnBTbaUtils _utils=PsnBTbaUtils();
  static PsnBTbaUtils get instance => _utils;

  final List<PsnTbaPointEnum> _filterFkPointList=[
    PsnTbaPointEnum.coin_pop,
    PsnTbaPointEnum.coin_pop_c,
    PsnTbaPointEnum.coin_pop_close,
  ];

  installEvent({int tryNum=5})async{
    if(installEventStatus.getData()){
      return;
    }
    var installMap = await PsnBInstallTbaBean().getInstallMap();
    var headerMap = await PsnBHeaderBean().getHeaderMap();
    var queryStr = await PsnBQueryBean().getQueryStr();
    "psn tba install ---> params--->$installMap".log();
    var dioResult = await DioHep.instance.requestPost(
      path: PsnLocalInfo.tbaUrl+queryStr,
      data: installMap,
      header: headerMap,
    );
    "psn tba install ---> result--->${dioResult.success}--->params--->$installMap".log();
    if(dioResult.success){
      installEventStatus.saveData(true);
    }else{
      if(tryNum>0){
        await Future.delayed(Duration(milliseconds: 1000));
        installEvent(tryNum: tryNum-1);
      }else{
        saveEventToSql(installMap);
      }
    }
  }

  sessionEvent({int tryNum=5})async{
    var baseMap = await PsnBBaseTbaBean().getBaseMap();
    baseMap["policy"]={};
    var headerMap = await PsnBHeaderBean().getHeaderMap();
    var queryStr = await PsnBQueryBean().getQueryStr();
    "psn tba session ---> params--->$baseMap".log();
    var dioResult = await DioHep.instance.requestPost(
      path: PsnLocalInfo.tbaUrl+queryStr,
      data: baseMap,
      header: headerMap,
    );
    "psn tba session ---> result--->${dioResult.success}--->params--->$baseMap".log();
    if(!dioResult.success){
      if(tryNum>0){
        await Future.delayed(Duration(milliseconds: 1000));
        sessionEvent(tryNum: tryNum-1);
      }else{
        saveEventToSql(baseMap);
      }
    }
  }

  adEvent({required AdMoneyInfoBean? ad,required PsnAdEventEnum adEventEnum,required AdInfoData? adInfoData,int tryNum=5})async{
    var adMap = await PsnBAdTbaBean().getAdMap(ad, adEventEnum, adInfoData);
    var headerMap = await PsnBHeaderBean().getHeaderMap();
    var queryStr = await PsnBQueryBean().getQueryStr();
    "psn tba ad ---> params--->$adMap".log();
    var dioResult = await DioHep.instance.requestPost(
      path: PsnLocalInfo.tbaUrl+queryStr,
      data: adMap,
      header: headerMap,
    );
    "psn tba ad ---> result--->${dioResult.success}--->params--->$adMap".log();
    if(!dioResult.success){
      if(tryNum>0){
        await Future.delayed(Duration(milliseconds: 1000));
        adEvent(ad: ad, adEventEnum: adEventEnum, adInfoData: adInfoData,tryNum: tryNum-1);
      }else{
        saveEventToSql(adMap);
      }
    }
  }

  pointEvent({required PsnTbaPointEnum pointEnum,Map<String,dynamic>? params,int tryNum=5})async{
    if(_filterFkPointList.contains(pointEnum)&&PsnFengkUtils.instance.isFk()){
      return;
    }
    var pointMap = await PsnBPointTbaBean().getPointMap(pointEnum, params);
    var headerMap = await PsnBHeaderBean().getHeaderMap();
    var queryStr = await PsnBQueryBean().getQueryStr();
    "psn tba point ---> params--->$pointMap".log();
    var dioResult = await DioHep.instance.requestPost(
      path: PsnLocalInfo.tbaUrl+queryStr,
      data: pointMap,
      header: headerMap,
    );
    "psn tba point ---> result--->${dioResult.success}--->params--->$pointMap".log();
    if(!dioResult.success){
      if(tryNum>0){
        await Future.delayed(Duration(milliseconds: 1000));
        pointEvent(pointEnum: pointEnum,params: params,tryNum: tryNum-1);
      }else{
        saveEventToSql(pointMap);
      }
    }
  }

  saveEventToSql(Map<String,dynamic> map)async{
    print("kk=====saveEventToSql=${map}");
    var database = await PsnRootSqlUtils.instance.initSql();
    database.insert(PsnRootSqlName.bTbaSql, {"jsonMap":jsonEncode(map)});
  }

  uploadSqlTbaInfo()async{
    var database = await PsnRootSqlUtils.instance.initSql();
    var list = await database.query(PsnRootSqlName.bTbaSql);
    if(list.isEmpty){
      return;
    }
    print("kk==uploadSqlTbaInfo===${list}");
    List<Map<String,dynamic>> resultList=[];
    for (var value in list) {
      var jsonMap = value["jsonMap"] as String;
      resultList.add(jsonDecode(jsonMap));
    }
    var headerMap = await PsnBHeaderBean().getHeaderMap();
    headerMap["Content-Encoding"]="gzip";
    var queryStr = await PsnBQueryBean().getQueryStr();
    "psn tba uploadSqlTbaInfo ---> params--->$resultList".log();
    var dioResult = await DioHep.instance.requestPost(
      path: PsnLocalInfo.tbaUrl+queryStr,
      data: resultList,
      header: headerMap,
      contentType: "application/json",
    );
    "psn tba uploadSqlTbaInfo ---> result--->${dioResult.success}--->params--->$resultList".log();
    if(dioResult.success){
      database.delete(PsnRootSqlName.bTbaSql);
    }
  }
}