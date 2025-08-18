import 'package:psn_b/psn_b_utils/psn_b_event_code.dart';
import 'package:psn_root/psn_root_event/psn_root_event_utils.dart';
import 'package:psn_root/psn_root_utils/psn_root_sql/psn_root_sql_name.dart';
import 'package:psn_root/psn_root_utils/psn_root_sql/psn_root_sql_utils.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';

class PsnWheelUtils{
  static final PsnWheelUtils _utils=PsnWheelUtils();
  static PsnWheelUtils get instance => _utils;

  initWheelInfo()async{
    var database = await PsnRootSqlUtils.instance.initSql();
    var list = await database.query(PsnRootSqlName.bWheelInfo,where: '"timer" = ?',whereArgs: [getTodayTimeStr()]);
    if(list.isNotEmpty){
      return;
    }
    database.insert(PsnRootSqlName.bWheelInfo, {"timer":getTodayTimeStr(),"wheelNum":3});
  }

  Future<int> getWheelNum()async{
    var database = await PsnRootSqlUtils.instance.initSql();
    var list = await database.query(PsnRootSqlName.bWheelInfo,where: '"timer" = ?',whereArgs: [getTodayTimeStr()]);
    if(list.isEmpty){
      return 0;
    }
    return list.first["wheelNum"] as int;
  }

  updateWheelNum(int updateNum)async{
    var database = await PsnRootSqlUtils.instance.initSql();
    var list = await database.query(PsnRootSqlName.bWheelInfo,where: '"timer" = ?',whereArgs: [getTodayTimeStr()]);
    if(list.isEmpty){
      return;
    }
    var map = Map<String,Object?>.from(list.first);
    var wheelNum = map["wheelNum"] as int;
    map["wheelNum"]=wheelNum+updateNum;
    await database.update(PsnRootSqlName.bWheelInfo,map,where: '"id" = ?',whereArgs: [map["id"]]);
    PsnRootEventUtils.instance.sendEvent(code: PsnBEventCode.updateWheelNum);
  }
}