import 'dart:io';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:synchronized/synchronized.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database _db;

  final _lock = new Lock();
  var batch;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    print('calling init 23');

    await _lock.synchronized(() async {
      if (_db == null) {
        _db = await initDb();
      }
    });
    return _db;
  }

  DatabaseHelper.internal();

  static DatabaseHelper get() {
    return _instance;
  }

  initDb() async {
    print('init db called value :' + didInit.toString());
    didInit = true;
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "ecusine.db");
    var ourDb =
        await openDatabase(path, version: 1, onCreate: this._onCreateTables);
    return ourDb;
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }

  bool didInit = false;

//  Future<Database> _getDb() async{
//    if(!didInit) {
//      print('Init DB fromgetDB');
//      await initDb();
//    }
//    return db;
//  }

  void _onCreateTables(Database db, int version) async {
    // await db.execute("CREATE_TABLE_EMP_DETAILS");
    // await db.execute("CREATE_TABLE_INVENTORY_ITEM");

    // await db.execute(''' CREATE TABLE TEST (COL TEXT)''');
    // await db.execute("CREATE_Json_Sync_table");

    print("Table Is Created");
  }

  Future<int> insertRecordsTest(List<Map> datum, String tablename,
      {bool withLog = true}) async {
    // var dbClient = await db;
    batch.rawQuery('delete from $tablename');
    int res = datum.length;
    datum.forEach((data) async {
      await batch.insert(tablename, data);
    });
    print("Records Saved : $res");
    return 0;
  }

  Future<int> insertRecords(
      {Map data, String tablename, bool withLog = true}) async {
    print('at insert to db');
    int res = 0;
    try {
      print(data);
      res = await batch.insert(tablename, data);
      print("Records Saved : $res");
    } catch (Ex) {
      print(Ex.toString());
      return 0;
    }
    return res;
  }

  Future<int> updateRecords(
      {Map data, Map clause, String tablename, bool withLog = true}) async {
    String where = '';
    List<dynamic> whereArgs = [];
    clause.forEach((key, value) {
      where = '$where,$key =?';
      whereArgs.add(value);
    });
    int res = -1;
    where = where.substring(1, where.length);

    print('Clause Length : ${clause.length}');
    print('Query -Where : $where');
    print("Args : $whereArgs");
    try {
      res = await batch.update(tablename, data,
          where: '$where', whereArgs: whereArgs);
    } catch (Ex) {
      print(Ex.toString());
      print('Query -Where : $where');
    }
    return res;
  }

  Future<int> deleteRecords(
      {Map clause, String tablename, bool withLog = true}) async {
    String where;
    List<dynamic> whereArgs = new List(clause.length);

    clause.forEach((key, value) {
      where = '$where,$key =?';
      whereArgs.add(value);
    });

    where = where.substring(1, where.length);
    int res = await batch.delete(tablename, where: where, whereArgs: whereArgs);
    return res;
  }

  Future<bool> startTransaction() async {
    var dbClient = await db;
    batch = dbClient.batch();
    return true;
  }

  Future<bool> commitTransaction() async {
    print('Commit batch ');
    await batch.commit(noResult: true);
    return true;
  }

  Future<List<Map>> getqueryResult(String qStr) async {
    var dbClient = await db;
    List<Map> list;
    try {
      list = await dbClient.rawQuery(qStr);
    } catch (Ex) {
      print(Ex.toString());
    }
    return list;
  }

  Future<Map> getSingleRowQueryResult(String qStr, [List args]) async {
    var dbClient = await db;
    List<Map> records;
    try {
      records = await dbClient.rawQuery(qStr, args);
    } catch (Ex) {
      print(Ex.toString());
      print('Str: $qStr , Args : $args');
    }
    return records.first;
  }

  Future<dynamic> getSingleTonResult(String qStr, [List args]) async {
    dynamic c;
    c = getSingleRowQueryResult(qStr, args);
    if (c.isNotEmpty) {
      return (c.values?.first);
    }
    return null;
  }

  Future<int> getCount(String qStr, [List args]) async {
    int c = 0;
    var dbClient = await db;
    c = Sqflite.firstIntValue(await dbClient.rawQuery(qStr, args));
    return c;
  }

  Future<void> runRawQuery(String str) async {
    var dbClient = await db;
    // print('Running : $str');
    try {
      await dbClient.execute(str);
    } catch (Ex) {
      print("Error at ${Ex.toString()}");
      print(str);
    }
  }

  Future<void> runTableCreateQuerywithDrop(String str, String table) async {
    var dbClient = await db;
    // print('Running : $str');
    try {
      // await dbClient.execute('DROP TABLE $table');
      await dbClient.execute(str);
    } catch (Ex) {
      print("Error at ${Ex.toString()}");
      print(str);
    }
  }

  void printTables() async {
    var dbClient = await db;
    // print('Running : $str');

    try {
      List<Map> list = await dbClient
          .rawQuery("select * from sales_inventory_items"); //ecusine.db
      print(list);
      print('group Length = ${list.length}');

      list.forEach((element) {
        print(' keys : $element');
        // print(' keys : ${'element.values'}');
      });
    } catch (Ex) {
      print("Error at ${Ex.toString()}");
    }
  }
// %d		day of month: 00
// %f		fractional seconds: SS.SSS
// %H		hour: 00-24
// %j		day of year: 001-366
// %J		Julian day number
// %m		month: 01-12
// %M		minute: 00-59
// %s		seconds since 1970-01-01
// %S		seconds: 00-59
// %w		day of week 0-6 with Sunday==0
// %W		week of year: 00-53
// %Y		year: 0000-9999

  static String dateTimetoString(DateTime dateTime) {
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
    return 'strftime("%Y-%m-%d %H:%M:%S","$formattedDate")';
  }

  static String datetoString(DateTime dateTime) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    return 'strftime("%Y-%m-%d","$formattedDate")';
  }

  static String colToDate(String colName) {
    return 'strftime("%Y-%m-%d","$colName")';
  }

  static String colToDateTime(String colName) {
    return 'strftime("%Y-%m-%d %H:%M:%S","$colName")';
  }

  static String castColumnAsInteger(String colName) {
    return 'CAST($colName AS  integer)';
  }
}
