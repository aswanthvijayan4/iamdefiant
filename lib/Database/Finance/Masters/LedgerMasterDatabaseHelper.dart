import 'package:authentication_with_bloc/DataModels/Masters/Accounts/AccountGroupDataModel.dart';
import 'package:authentication_with_bloc/DataModels/Masters/Accounts/LedgerMasterDataModel.dart';
import 'package:authentication_with_bloc/Database/DatabaseHelper.dart';
import 'package:authentication_with_bloc/Database/core/MasterDBAbstract.dart';

class LedgerMasterDatabaseHelper implements MasterDBAbstract {
  final DatabaseHelper _db = DatabaseHelper.get();

  LedgerMasterDatabaseHelper();

  //'package:authentication_with_bloc/erp/DataModels/Masters/Ac';

  Future<List<LedgerMasterDataModel>> getAllLedgers() async {
    print("Test  at Database");
    String qStr = "SELECT * ";
    qStr += column_LEDGER_ID + ", ";
    qStr += column_Ledger_Name + ", ";
    qStr +=
        "(Select $columngroupName From $tableNameAccountGroups where $columngroupID = tab.$column_Group_Id) as Group_Name";
    qStr += " FROM $TableName_Ledger_Master Gr o";

    //  var r =  await _db.runRawQuery("UPDATE `ledger_master` SET `Birth_Date`='2000-01-01';");
    //  getqueryResult("desc Ledger_master");

    // print(r);

    List<LedgerMasterDataModel> itemsList = [];
    var res = await _db.getqueryResult(qStr);
    // print("Result : $res");

    res[0].forEach((key, value) {
      print('$key = $value');
    });

    res.forEach((result) {
      itemsList.add(LedgerMasterDataModel.fromMap(result));
    });

    // itemsList.forEach((element) {
    //   print("Name : ${element.LedgerName}");
    // });
    return itemsList;
  }

  //TO DO

  Future<List<LedgerMasterDataModel>> getLedgersUnderGroup(
      String groupID) async {
    print("Test  at Database");
    String qStr = "SELECT ";
    qStr += "$column_LEDGER_ID,$column_Ledger_Name, ";
    qStr += "(Select $columngroupName from $tableNameAccountGroups ";
    qStr += "where Gr.$columngroupID = $columngroupID) ";
    qStr += "as $columngroupName ";
    qStr += " FROM $TableName_Ledger_Master Gr order by 2";

    List<LedgerMasterDataModel> itemsList = [];
    var res = await _db.getqueryResult(qStr);
    print("Result : $res");

    res.forEach((result) {
      print(result);
      itemsList.add(LedgerMasterDataModel.fromMap(result));
    });

    itemsList.forEach((element) {
      print("Name : ${element.LedgerName}");
    });
    return itemsList;
  }

  @override
  Future<List<Map>> getAllEntitiesAsList(
      [int startIndex = -1, int limit = -1, String filter = ""]) async {
    print("Test  at Database filter : $filter");
    String qStr = "SELECT ";
    qStr +=
        "$column_LEDGER_ID as 'id' ,$column_Ledger_Name as 'Name',' ' as '1st',";
    qStr += "(Select $columngroupName from $tableNameAccountGroups ";
    qStr += "where Gr.$column_Group_Id = $columngroupID) ";
    qStr += "as '2nd' ";
    qStr += " FROM $TableName_Ledger_Master Gr ";
    if (filter.length > 0)
      qStr += " WHERE $column_Ledger_Name LIKE '%$filter%'";
    qStr += " order by 2 ";
    if (limit > -1) qStr += " LIMIT $limit OFFSET $startIndex";
    print('Query : $qStr');
    var res = await _db.getqueryResult(qStr);
    // print(res);

    return res;
  }

  @override
  Future<dynamic> getEntityByID(String id) async {
    // TODO: implement getEntityByID
    throw UnimplementedError();
  }

  @override
  Future<int> getMax() async {
    String qStr = 'SELECT MAX($column_sl_no) from $TableName_Ledger_Master';
    int n = await _db.getCount(qStr);
    print('next = $n');
    return n;
  }

  @override
  Future<String> getNameByID(String id) async {
    // TODO: implement getNameByID
    throw UnimplementedError();
  }

  @override
  Future<bool> idExists(String id) async {
    if (id == null) return false;
    String qStr =
        'SELECT COUNT(*) FROM $TableName_Ledger_Master where $column_LEDGER_ID =?';
    int count = await _db.getCount(qStr, [id]);
    print('Found count :$count');
    if (count > 0) return true;
    return false;
  }

  @override
  Future<bool> upsertEntity(entity) async {
    print('at insert');
    LedgerMasterDataModel object = entity as LedgerMasterDataModel;
    await _db.startTransaction();
    Map<String, dynamic> map = object.toMap(); //();

    print('TO UPDATE $map');

    try {
      if (!await idExists(object.LedgerID)) {
        print('Insert Inv Group');
        int t = await getMax();
        object.LedgerID = object.LedgerGroupId + 'x$t';
        map[column_LEDGER_ID] = object.LedgerID;
        await _db.insertRecords(data: map, tablename: TableName_Ledger_Master);
      } else {
        print('Updating Inv Group 189');
        Map<String, dynamic> mapClause = new Map();
        mapClause[column_LEDGER_ID] = object.LedgerID;
        print("Ready to UPdate");
        await _db.updateRecords(
            data: map, clause: mapClause, tablename: TableName_Ledger_Master);
      }

      await _db.commitTransaction();
    } catch (Ex) {
      print(Ex.toString());
      return false;
    }
    return true;
  }

  @override
  Future<bool> deleteEntity(String id) async {
    // TODO: implement deleteEntity
    throw UnimplementedError();
  }
}
