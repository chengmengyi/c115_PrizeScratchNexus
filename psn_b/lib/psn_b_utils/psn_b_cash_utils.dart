
import 'package:psn_b/psn_b_bean/psn_cash_task_bean.dart';
import 'package:psn_b/psn_b_utils/psn_b_event_code.dart';
import 'package:psn_b/psn_b_utils/psn_b_value_utils.dart';
import 'package:psn_root/psn_root_event/psn_root_event_utils.dart';
import 'package:psn_root/psn_root_utils/psn_root_sql/psn_root_sql_name.dart';
import 'package:psn_root/psn_root_utils/psn_root_sql/psn_root_sql_utils.dart';

class CashType{
  static const String pay="pay";
  static const String cash="cash";
  static const String pag="pag";
  static const String pix="pix";
}

class TaskType{
  static const String card="card";
  static const String wheel="wheel";
  static const String lucky="lucky";
  static const String ad="ad";
}

class PsnBCashUtils{
  static final PsnBCashUtils _utils=PsnBCashUtils();
  static PsnBCashUtils get instance => _utils;


  Future<PsnCashTaskBean?> queryCashTaskByMoneyAndType(int cashMoney,String cashType)async{
    var database = await PsnRootSqlUtils.instance.initSql();
    var list = await database.query(PsnRootSqlName.bCashTask,where: '"cashType" = ? AND "cashMoney" = ?',whereArgs: [cashType,cashMoney]);
    if(list.isEmpty){
      return null;
    }
    return PsnCashTaskBean.fromJson(list.first);
  }

  Future<bool> createCashTask(int cashMoney,String cashType)async{
    var database = await PsnRootSqlUtils.instance.initSql();
    var list = await database.query(PsnRootSqlName.bCashTask,where: '"cashType" = ? AND "cashMoney" = ?',whereArgs: [cashType,cashMoney]);
    if(list.isNotEmpty){
      return false;
    }
    var cashTaskConfig = PsnBValueUtils.instance.getFirstCashTaskConfig();
    if(null==cashTaskConfig){
      return false;
    }
    var cashTaskBean = PsnCashTaskBean(
      cashType: cashType,
      cashMoney: cashMoney,
      completed: 0,
      cashTaskId: cashTaskConfig.id,
      currentProgress: 0,
      totalProgress: cashTaskConfig.count,
    );
    await database.insert(PsnRootSqlName.bCashTask, cashTaskBean.toJson());
    PsnRootEventUtils.instance.sendEvent(code: PsnBEventCode.updateCashList);
    return true;
  }

  updateCashTask(String taskType)async{
    var database = await PsnRootSqlUtils.instance.initSql();
    var list = await database.query(PsnRootSqlName.bCashTask);
    if(list.isEmpty){
      return;
    }
    for (var value in list) {
      var cashTaskBean = PsnCashTaskBean.fromJson(value);
      var withdrawTask = PsnBValueUtils.instance.getCashTaskConfigByID(cashTaskBean.cashTaskId);
      if(withdrawTask?.type==taskType){
        cashTaskBean.currentProgress=(cashTaskBean.currentProgress??0)+1;
        if((cashTaskBean.currentProgress??0)>=(cashTaskBean.totalProgress??0)){
          var nextCashTaskConfig = PsnBValueUtils.instance.getNextCashTaskConfigByID(cashTaskBean.cashTaskId);
          if(null==nextCashTaskConfig){
            cashTaskBean.completed=1;
          }else{
            cashTaskBean.currentProgress=0;
            cashTaskBean.cashTaskId=nextCashTaskConfig.id;
            cashTaskBean.totalProgress=nextCashTaskConfig.count??0;
          }
        }
        await database.update(PsnRootSqlName.bCashTask, cashTaskBean.toJson(),where: '"id" = ?',whereArgs: [value["id"]]);
      }
    }
    PsnRootEventUtils.instance.sendEvent(code: PsnBEventCode.updateCashList);
  }

  deleteCashTask(PsnCashTaskBean? cashTaskBean)async{
    var database = await PsnRootSqlUtils.instance.initSql();
    var list = await database.query(PsnRootSqlName.bCashTask,where: '"cashType" = ? AND "cashMoney" = ? AND completed = 1',whereArgs: [cashTaskBean?.cashType,cashTaskBean?.cashMoney]);
    if(list.isEmpty){
      return;
    }
    for (var value in list) {
      await database.delete(PsnRootSqlName.bCashTask,where: '"id" = ?',whereArgs: [value["id"]]);
    }
    PsnRootEventUtils.instance.sendEvent(code: PsnBEventCode.updateCashList);
  }
}