import 'package:common_utils/common_utils.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:synchronized/synchronized.dart';

class DbHelper {
  DbHelper._privateConstructor();
  static final _lock = Lock();
  static final DbHelper instance = DbHelper._privateConstructor();

  //当前数据库版本
  int _version = 1;
  late Database _db;
  String _dbName = "lgy.db";
  final String TAG = "DbHelper";
  late List _sqllist;

  void initDB(String dbName, {required int version, required List sqllist}) {
    _lock.synchronized((){
      if (dbName == null) {
        _dbName = 'lgy.db';
      } else {
        _dbName = dbName;
      }
      if (version != null) {
        _version = version;
      }
      _sqllist = sqllist;
    });
  }

  //打开数据库
   Future<Database> openDB() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, _dbName);
    return _db = await openDatabase(
      path,
      onCreate: (Database db, int version) async {
        await db.transaction((trans) async{
          if (_sqllist != null) {
            for (int i = 0; i < _sqllist.length; i++) {
              LogUtil.d(_sqllist.length, tag: TAG);
              try {
                await trans.execute(_sqllist[i]);
              } catch (e) {
                LogUtil.d("error--:$e", tag: TAG);
                continue;
              }
            }
          }
        });

      },
      onUpgrade: (Database db,int oldVersion,int newVersion) async{
        LogUtil.d("old:$oldVersion,new:$newVersion", tag: TAG);
      },
      version: _version,
    );
  }


  Future<void> closeDB() {
    return _db.close();
  }
}
