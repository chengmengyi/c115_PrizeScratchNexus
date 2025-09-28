
import 'dart:math';

import 'package:psn_b/psn_b_bean/psn_cash_task_bean.dart';
import 'package:psn_b/psn_b_bean/psn_rank_bean.dart';
import 'package:psn_b/psn_b_utils/psn_b_event_code.dart';
import 'package:psn_b/psn_b_utils/psn_b_value_utils.dart';
import 'package:psn_root/psn_root_event/psn_root_event_utils.dart';
import 'package:psn_root/psn_root_utils/psn_root_sql/psn_root_sql_name.dart';
import 'package:psn_root/psn_root_utils/psn_root_sql/psn_root_sql_utils.dart';
import 'package:psn_root/psn_root_utils/psn_tba/psn_b_tba_utils.dart';
import 'package:psn_root/psn_root_utils/psn_tba_point_enum.dart';

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

  Future<bool> createCashTask(int cashMoney,String cashType,String account)async{
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
    await database.insert(PsnRootSqlName.bCashAccount, {"cashType":cashType,"cashMoney":cashMoney,"account":account});
    PsnRootEventUtils.instance.sendEvent(code: PsnBEventCode.updateCashList);
    return true;
  }

  Future<String> queryAccount(int cashMoney,String cashType,)async{
    var database = await PsnRootSqlUtils.instance.initSql();
    var list = await database.query(PsnRootSqlName.bCashAccount,where: '"cashType" = ? AND "cashMoney" = ?',whereArgs: [cashType,cashMoney]);
    if(list.isEmpty){
      return "";
    }
    var account = list.first["account"] as String;
    if(account.length<=2){
      return account;
    }
    return "${account.substring(0,2)}***";
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
          PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.cash_task_complete,params: {"task_from":withdrawTask?.type});
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
  }

  Future<PsnRankBean?> queryRankProgress(int cashMoney,String cashType)async{
    var database = await PsnRootSqlUtils.instance.initSql();
    var list = await database.query(PsnRootSqlName.bCashRank,where: '"cashType" = ? AND "cashMoney" = ?',whereArgs: [cashType,cashMoney]);
    if(list.isEmpty){
      return null;
    }
    var rankBean = PsnRankBean.fromJson(list.first);
    return rankBean;
  }

  createRankProgress(int cashMoney,String cashType)async{
    var database = await PsnRootSqlUtils.instance.initSql();
    var list = await database.query(PsnRootSqlName.bCashRank,where: '"cashType" = ? AND "cashMoney" = ?',whereArgs: [cashType,cashMoney]);
    if(list.isNotEmpty){
      return;
    }
    var rankBean = PsnRankBean(
      cashMoney: cashMoney,
      cashType: cashType,
      currentRank: PsnBValueUtils.instance.getCurrentRank()?.intCurrent,
      totalRank: PsnBValueUtils.instance.getAllRank()?.intAll,
    );
    await database.insert(PsnRootSqlName.bCashRank, rankBean.toJson());
  }

  Future<PsnRankBean?> updateRankProgress(PsnRankBean? bean)async{
    var database = await PsnRootSqlUtils.instance.initSql();
    var list = await database.query(PsnRootSqlName.bCashRank,where: '"cashType" = ? AND "cashMoney" = ?',whereArgs: [bean?.cashType,bean?.cashMoney]);
    if(list.isEmpty){
      return bean;
    }
    var reduceCurrent = randomInRange(PsnBValueUtils.instance.getCurrentRank()?.intCurrentDelete??[]);
    var reduceAll = randomInRange(PsnBValueUtils.instance.getAllRank()?.intAllDelete??[]);
    bean?.currentRank=(bean.currentRank??0)-reduceCurrent;
    bean?.totalRank=(bean.totalRank??0)-reduceAll;
    if((bean?.currentRank??0)<=0){
      bean?.currentRank=1;
    }
    if((bean?.totalRank??0)<=0){
      bean?.totalRank=1;
    }
    await database.update(PsnRootSqlName.bCashRank, bean?.toJson()??{},where: '"id" = ?',whereArgs: [list.first["id"]]);
    PsnRootEventUtils.instance.sendEvent(code: PsnBEventCode.updateCashList);
    return bean;
  }

  deleteRankProgress(PsnRankBean bean)async{
    var database = await PsnRootSqlUtils.instance.initSql();
    var list = await database.query(PsnRootSqlName.bCashRank,where: '"cashType" = ? AND "cashMoney" = ?',whereArgs: [bean.cashType,bean.cashMoney]);
    if(list.isEmpty){
      return;
    }
    await database.delete(PsnRootSqlName.bCashRank,where: '"id" = ?',whereArgs: [list.first["id"]]);
    PsnRootEventUtils.instance.sendEvent(code: PsnBEventCode.updateCashList);
  }

  int randomInRange(List<int> list) {
    if(list.isEmpty){
      return 0;
    }
    if(list.length==1){
      return list.first;
    }
    var min = list.first;
    var max = list.last;
    final random = Random();
    return min + random.nextInt(max - min + 1);
  }
}