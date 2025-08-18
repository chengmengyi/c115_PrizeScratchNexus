import 'package:psn_root/psn_root_utils/psn_root_sql/psn_root_sql_name.dart';
import 'package:sqflite/sqflite.dart';

class PsnRootSqlUtils {
  static final PsnRootSqlUtils _utils = PsnRootSqlUtils();
  static PsnRootSqlUtils get instance => _utils;

  Future<Database> initSql() async => await openDatabase(
      "psn.db",
      version: 2,
      onCreate: (db,version)async{
        db.execute('CREATE TABLE ${PsnRootSqlName.aCardNum} (id INTEGER PRIMARY KEY AUTOINCREMENT, cardType TEXT, cardNum INTEGER, unlock INTEGER)');
        _createVersion2DB(db);
      },
      onUpgrade: (db,oldVersion,newVersion){
        if(newVersion==2){
          _createVersion2DB(db);
        }
      }
  );

  _createVersion2DB(Database db){
    db.execute('CREATE TABLE ${PsnRootSqlName.bCardNum} (id INTEGER PRIMARY KEY AUTOINCREMENT, cardType TEXT, cardNum INTEGER, unlock INTEGER)');
    db.execute('CREATE TABLE ${PsnRootSqlName.bCashTask} (id INTEGER PRIMARY KEY AUTOINCREMENT, cashType TEXT, cashMoney INTEGER, completed INTEGER, cashTaskId INTEGER, currentProgress INTEGER, totalProgress INTEGER)');
    db.execute('CREATE TABLE ${PsnRootSqlName.bWheelInfo} (id INTEGER PRIMARY KEY AUTOINCREMENT, timer TEXT, wheelNum INTEGER)');
  }
}