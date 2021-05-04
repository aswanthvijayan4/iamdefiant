import 'package:authentication_with_bloc/erp/DataModels/Masters/Accounts/AccountGroupDataModel.dart';
import 'package:authentication_with_bloc/erp/DataModels/Masters/Inventory/InventoryGroupsDataModel.dart';
import 'package:authentication_with_bloc/erp/Database/DatabaseHelper.dart';
import 'package:authentication_with_bloc/erp/Database/core/MasterDBAbstract.dart';

class AccountGroupDBHelper implements MasterDBAbstract {
  final DatabaseHelper _db = DatabaseHelper.get();

  AccountGroupDBHelper();

  //'package:authentication_with_bloc/erp/DataModels/Masters/Ac';

  Future<List<AccountGroupDataModel>> getAllGroups() async {
    print("Test  at Database");
    String qStr = "SELECT ";
    qStr += "$columngroupID,$columngroupName,$columnparentGroupId,";
    qStr += "(Select $columngroupName from $tableNameAccountGroups";
    qStr += "where Gr.$columngroupID = $columngroupID) ";
    qStr += "as $columnparentGroupName ";
    qStr += " FROM $tableNameAccountGroups Gr order by 2";

    List<AccountGroupDataModel> itemsList = [];
    var res = await _db.getqueryResult(qStr);
    print("Result : $res");

    res.forEach((result) {
      print(result);
      itemsList.add(AccountGroupDataModel.fromMapDef(result));
    });

    itemsList.forEach((element) {
      print("Name : ${element.groupName}");
    });
    return itemsList;
  }

  //TO DO

  Future<String> getGroupNameByID(String id) async {
    String qStr = " SELECT $columngroupName";
    qStr += " from " + tableNameAccountGroups;
    qStr += " where ";
    qStr += "$columngroupID=?";
    return _db.getSingleTonResult(qStr, [id]);
  }

  Future<String> getGroupIdByName(String name) async {
    String qStr = " SELECT $columngroupID";
    qStr += " from " + tableNameAccountGroups;
    qStr += " where ";
    qStr += "$columngroupName=?";
    return _db.getSingleTonResult(qStr, [name]);
  }

  Future<List<AccountGroupDataModel>> getchildGroupsUnder(
      String groupID) async {
    print("Test  at Database");
    String qStr = "SELECT ";
    qStr += "$columngroupID,$columngroupName,$columnparentGroupId,";
    qStr += "(Select $columngroupName from $tableNameAccountGroups ";
    qStr += "where Gr.$columngroupID = $columngroupID) ";
    qStr += "as $columnparentGroupName ";
    qStr += " FROM $tableNameAccountGroups Gr order by 2";

    List<AccountGroupDataModel> itemsList = [];
    var res = await _db.getqueryResult(qStr);
    print("Result : $res");

    res.forEach((result) {
      print(result);
      itemsList.add(AccountGroupDataModel.fromMapDef(result));
    });

    itemsList.forEach((element) {
      print("Name : ${element.groupName}");
    });
    return itemsList;
  }

  @override
  Future<List<Map>> getAllEntitiesAsList(
      [int startIndex = -1, int limit = -1, String filter = ""]) async {
    print("Test  at Database filter : $filter");
    String qStr = "SELECT ";
    qStr += "$columngroupID as 'id' ,$columngroupName as 'Name',' ' as '1st',";
    qStr += "(Select $columngroupName from $tableNameAccountGroups ";
    qStr += "where Gr.$column_Inv_ParentGroupID = $columngroupID) ";
    qStr += "as '2nd' ";
    qStr += " FROM $tableNameAccountGroups Gr ";
    if (filter.length > 0) qStr += " WHERE $columngroupName LIKE '%$filter%'";
    qStr += " order by 2 ";
    if (limit > -1) qStr += " LIMIT $limit OFFSET $startIndex";
    print('Query : $qStr');
    var res = await _db.getqueryResult(qStr);
    // print(res);

    return res;
  }

  @override
  Future<dynamic> getEntityByID(String id) async {
    String qStr = " SELECT  ";
    qStr += columngroupID + ",";
    qStr += columngroupName + ",";
    qStr += columnparentGroupId + ",";
    qStr += columngroupType + ",";
    qStr += "(Select $columngroupName from $tableNameAccountGroups ";
    qStr +=
        "where Gr.$columnparentGroupId = $columngroupID) as $columnparentGroupName";

    qStr += " from " + tableNameAccountGroups;
    qStr += " Gr where ";
    qStr += columngroupID + "=?";

    Map map = await _db.getSingleRowQueryResult(qStr, [id]);

    return AccountGroupDataModel.fromMapDef(map);
  }

  @override
  Future<int> getMax() async {
    String qStr = 'SELECT MAX($columnAccid) from $tableNameAccountGroups';
    int n = await _db.getCount(qStr);
    print('next = $n');
    return n;
  }

  @override
  Future<String> getNameByID(String id) async {
    String qStr = " SELECT $columngroupName";
    qStr += " from " + tableNameAccountGroups;
    qStr += " where ";
    qStr += "$columngroupID=?";
    return _db.getSingleTonResult(qStr, [id]);
  }

  @override
  Future<bool> idExists(String id) async {
    if (id == null) return false;
    String qStr =
        'SELECT COUNT(*) FROM $tableNameAccountGroups where $columngroupID =?';
    int count = await _db.getCount(qStr, [id]);
    print('Found count :$count');
    if (count > 0) return true;
    return false;
  }

  @override
  Future<bool> upsertEntity(entity) async {
    print('at insert');
    AccountGroupDataModel object = entity as AccountGroupDataModel;
    await _db.startTransaction();
    Map<String, dynamic> map = object.toMapDef(); //();

    print('TO UPDATE $map');

    try {
      if (!await idExists(object.groupID)) {
        print('Insert Inv Group');
        int t = await getMax();
        object.groupID = object.parentGroupId + 'x$t';
        map[columngroupID] = object.groupID;
        await _db.insertRecords(data: map, tablename: tableNameAccountGroups);
      } else {
        print('Updating Inv Group 189');
        Map<String, dynamic> mapClause = new Map();
        mapClause[columngroupID] = object.groupID;
        print("Ready to UPdate");
        await _db.updateRecords(
            data: map, clause: mapClause, tablename: tableNameAccountGroups);
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
