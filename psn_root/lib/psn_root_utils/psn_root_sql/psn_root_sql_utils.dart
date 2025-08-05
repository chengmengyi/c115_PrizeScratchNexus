import 'package:psn_root/psn_root_utils/psn_root_sql/psn_root_sql_name.dart';
import 'package:sqflite/sqflite.dart';

class PsnRootSqlUtils {
  static final PsnRootSqlUtils _utils = PsnRootSqlUtils();
  static PsnRootSqlUtils get instance => _utils;

  Future<Database> initSql() async => await openDatabase(
      "psn.db",
      version: 1,
      onCreate: (db,version)async{
        db.execute('CREATE TABLE ${PsnRootSqlName.aCardNum} (id INTEGER PRIMARY KEY AUTOINCREMENT, cardType TEXT, cardNum INTEGER, unlock INTEGER)');
      },
      onUpgrade: (db,oldVersion,newVersion){

      }
  );
}