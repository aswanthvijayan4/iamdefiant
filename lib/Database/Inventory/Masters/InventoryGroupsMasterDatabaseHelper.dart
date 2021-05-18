import 'package:authentication_with_bloc/DataModels/Masters/Inventory/InventoryGroupsDataModel.dart';
import 'package:authentication_with_bloc/Database/DatabaseHelper.dart';
import 'package:authentication_with_bloc/Database/core/MasterDBAbstract.dart';

class InventoryGroupDBHelper extends MasterDBAbstract {
  final DatabaseHelper _db = DatabaseHelper.get();

  InventoryGroupDBHelper();

  Future<int> getMaxCount() async {
    String qStr = 'SELECT MAX($column_Inv_ID) from $TableName_InventoryGroups';
    int n = await _db.getSingleTonResult(qStr);
    print('next = $n');
    return n;
  }

  Future<List<Map>> getAllGroups([String filter = ""]) async {
    print("Test  at Database filter : $filter");
    String qStr = "SELECT ";
    qStr +=
        "$column_Inv_GroupID as 'id' ,$column_Inv_GroupName as 'Name',$column_Inv_ParentGroupID as '1st',";
    qStr += "(Select $column_Inv_GroupName from $TableName_InventoryGroups ";
    qStr += "where Gr.$column_Inv_ParentGroupID = $column_Inv_GroupID) ";
    qStr += "as '2nd' ";
    qStr += " FROM $TableName_InventoryGroups Gr ";
    if (filter.length > 0)
      qStr += " WHERE $column_Inv_GroupName LIKE '%$filter%'";
    qStr += " order by 2";
    print('Query : $qStr');
    var res = await _db.getqueryResult(qStr);
    print(res);

    return res;
  }

  //TO DO

  Future<bool> upsertInventoryGroup(InventoryGroupDataModel group) async {
    print('at insert');
    await _db.startTransaction();
    Map<String, dynamic> map = Map();
    map[column_Inv_GroupID] = group.GroupID;
    map[column_Inv_GroupName] = group.GroupName;
    map[column_Inv_ParentGroupID] = group.ParentGroupId;
    map[column_Inv_GroupType] = group.GroupType;
    try {
      if (!await exists(group.GroupID)) {
        print('Insert Inv Group');
        group.GroupID = group.ParentGroupId + 'x' + getMaxCount().toString();
        map[column_Inv_GroupID] = group.GroupID;
        await _db.insertRecords(
            data: map, tablename: TableName_InventoryGroups);
      } else {
        print('Updating Inv Group');
        Map<String, dynamic> mapClause = Map();
        mapClause[column_Inv_GroupID] = group.GroupID;
        await _db.updateRecords(
            data: map, clause: mapClause, tablename: TableName_InventoryGroups);
      }

      await _db.commitTransaction();
    } catch (Ex) {
      print(Ex.toString());
      return false;
    }
    return true;
  }

  Future<int> deleteInventoryGroup(String itemID) async {
    Map<String, dynamic> map = Map();
    map[column_Inv_GroupID] = itemID;
    await _db.deleteRecords(clause: map, tablename: TableName_InventoryGroups);
    return 0;
  }

  Future<bool> exists(String id) async {
    if (id == null) return false;
    String qStr =
        "SELECT * FROM  $TableName_InventoryGroups where $column_Inv_GroupID = ?";
    Map map = await _db.getSingleRowQueryResult(qStr, [id]);
    if (map.length > 0) return true;
    return false;
  }

  Future<String> getGroupNameByID(String ID) async {
    String str;

    return str;
  }

  Future<InventoryGroupDataModel> getGroupByID(String id) async {
    String qStr = " SELECT * ";

    qStr += " from " + TableName_InventoryGroups;
    qStr += " where ";
    qStr += column_Inv_GroupID + "=?";
    Map map = await _db.getSingleRowQueryResult(qStr, [id]);
    return InventoryGroupDataModel.fromMap(map);
  }

  Future<String> getGroupIdByName(String ID) async {
    String qStr = " SELECT ";
    qStr += " from " + TableName_InventoryGroups;
    qStr += " where ";
    return _db.getSingleTonResult(qStr);
  }

  Future<List<InventoryGroupDataModel>> getchildGroupsUnder(
      String groupID) async {
    print("Test  at Database");
    String qStr = "SELECT ";
    qStr +=
        "$column_Inv_GroupID,$column_Inv_GroupName,$column_Inv_ParentGroupID,";
    qStr += "(Select $column_Inv_GroupName from $TableName_InventoryGroups ";
    qStr += "where Gr.$column_Inv_GroupID = $column_Inv_GroupID) ";
    qStr += "as $column_Inv_parentGroupName ";
    qStr += " FROM $TableName_InventoryGroups Gr order by 2";

    List<InventoryGroupDataModel> itemsList = [];
    var res = await _db.getqueryResult(qStr);
    print("Result : $res");

    res.forEach((result) {
      print(result);
      itemsList.add(InventoryGroupDataModel.fromMap(result));
    });

    itemsList.forEach((element) {
      print("Name : ${element.GroupName}");
    });
    return itemsList;
  }

  @override
  Future<List<Map>> getAllEntitiesAsList(
      [int startIndex = -1, int limit = -1, String filter = ""]) async {
    print("Test  at Database filter : $filter");
    String qStr = "SELECT ";
    qStr +=
        "$column_Inv_GroupID as 'id' ,$column_Inv_GroupName as 'Name',$column_Inv_ParentGroupID as '1st',";
    qStr += "(Select $column_Inv_GroupName from $TableName_InventoryGroups ";
    qStr += "where Gr.$column_Inv_ParentGroupID = $column_Inv_GroupID) ";
    qStr += "as '2nd' ";
    qStr += " FROM $TableName_InventoryGroups Gr ";
    if (filter.length > 0)
      qStr += " WHERE $column_Inv_GroupName LIKE '%$filter%'";
    qStr += " order by 2 ";
    // print('Query : $qStr');
    var res = await _db.getqueryResult(qStr);
    // print(res);

    return res;
  }

  @override
  Future<int> getMax() async {
    String qStr = 'SELECT MAX($column_Inv_ID) from $TableName_InventoryGroups';
    int n = await _db.getCount(qStr);
    print('next = $n');
    return n;
  }

  @override
  Future<bool> idExists(String id) async {
    if (id == null) return false;
    String qStr =
        'SELECT COUNT(*) FROM $TableName_InventoryGroups where $column_Inv_GroupID =?';
    int count = await _db.getCount(qStr, [id]);
    print('Found count :$count');
    if (count > 0) return true;
    return false;
  }

  @override
  Future<bool> upsertEntity(entity) async {
    print('at insert');
    InventoryGroupDataModel group = entity as InventoryGroupDataModel;
    await _db.startTransaction();
    Map<String, dynamic> map = group.toMap(); //();

    print('TO UPDATE $map');

    try {
      if (!await idExists(group.GroupID)) {
        print('Insert Inv Group');
        int t = await getMax();
        group.GroupID = group.ParentGroupId + 'x$t';
        map[column_Inv_GroupID] = group.GroupID;
        await _db.insertRecords(
            data: map, tablename: TableName_InventoryGroups);
      } else {
        print('Updating Inv Group 189');
        Map<String, dynamic> mapClause = new Map();
        mapClause[column_Inv_GroupID] = group.GroupID;
        print("Ready to UPdate");
        await _db.updateRecords(
            data: map, clause: mapClause, tablename: TableName_InventoryGroups);
      }

      await _db.commitTransaction();
    } catch (Ex) {
      print(Ex.toString());
      return false;
    }
    return true;
  }

  @override
  Future<dynamic> getEntityByID(String id) async {
    // TODO: implement getEntityByID
    String qStr = " SELECT  ";
    qStr += column_Inv_GroupID + ",";
    qStr += column_Inv_GroupName + ",";
    qStr += column_Inv_ParentGroupID + ",";
    qStr += column_Inv_GroupType + ",";
    qStr += "(Select $column_Inv_GroupName from $TableName_InventoryGroups ";
    qStr +=
        "where Gr.$column_Inv_ParentGroupID = $column_Inv_GroupID) as $column_Inv_parentGroupName";

    qStr += " from " + TableName_InventoryGroups;
    qStr += " Gr where ";
    qStr += column_Inv_GroupID + "=?";

    Map map = await _db.getSingleRowQueryResult(qStr, [id]);

    return InventoryGroupDataModel.fromMap(map);
  }

  @override
  Future<String> getNameByID(String id) {
    // TODO: implement getNameByID
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteEntity(String id) {
    // TODO: implement deleteEntity
    throw UnimplementedError();
  }
}
