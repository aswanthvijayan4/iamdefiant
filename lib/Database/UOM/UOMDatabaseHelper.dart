import 'package:authentication_with_bloc/DataModels/Masters/UOM/UOMDataModel.dart';
import 'package:authentication_with_bloc/Database/DatabaseHelper.dart';
import 'package:authentication_with_bloc/Database/core/MasterDBAbstract.dart';

class UOMDatabaseHelper implements MasterDBAbstract {
  final DatabaseHelper _db = DatabaseHelper.get();

  UOMDatabaseHelper();

  Future<List<UOMDataModel>> getAllUom() async {
    print("Test  at Database");
    String qStr = "SELECT ";
    qStr += "$column_Uom_Id,$column_Uom_Name";
    qStr += " FROM $TableNameUom Gr order by 2";

    List<UOMDataModel> uomList = [];
    var res = await _db.getqueryResult(qStr);

    res.forEach((result) {
      print(result);
      uomList.add(UOMDataModel.fromMapForMaster(result));
    });

    uomList.forEach((element) {
      print("Name : ${element.uomName}");
    });
    return uomList;
  }

  //TO DO

  Future<int> upsertUOM(UOMDataModel uom) async {
    await _db.startTransaction();
    Map<String, dynamic> map = Map();
    map[column_Uom_Id] = uom.id;
    map[column_Uom_Id] = uom.uomName;
    map[column_Uom_Decimal_Points] = uom.decimalPoints;
    map[column_Uom_Symbol] = uom.uomSymbol;
    map[column_Uom_Narration] = uom.narration;

    if (uom != null) {
      await _db.insertRecords(data: map, tablename: TableNameUom);
    } else {
      Map<String, dynamic> mapClause = Map();
      mapClause[column_Uom_Id] = uom.id;
      await _db.updateRecords(
          data: map, clause: mapClause, tablename: TableNameUom);
    }
    await _db.commitTransaction();
    return 0;
  }

  Future<int> deleteUOM(String itemID) async {
    Map<String, dynamic> map = Map();
    map[column_Uom_Id] = itemID;
    await _db.deleteRecords(clause: map, tablename: TableNameUom);
    return 0;
  }

  Future<String> getUOMNameByID(String ID) async {
    String str;

    return str;
  }

  Future<String> getUOMIdByName(String ID) async {
    String qStr = " SELECT ";
    qStr += " from " + TableNameUom;
    qStr += " where ";
    return _db.getSingleTonResult(qStr);
  }

  @override
  Future<List<Map>> getAllEntitiesAsList(
      [int startIndex = -1, int limit = -1, String filter = ""]) async {
    print("Test  at Database filter : $filter");
    String qStr = "SELECT ";
    qStr +=
        "$column_Uom_Id as 'id' ,$column_Uom_Name as 'Name',$column_Uom_Symbol as '1st',";
    qStr += "$column_Uom_Narration";
    qStr += "as '2nd' ";
    qStr += " FROM $TableNameUom Gr ";
    if (filter.length > 0) qStr += " WHERE $column_Uom_Name LIKE '%$filter%'";
    qStr += " order by 2 ";
    if (limit > -1) qStr += " LIMIT $limit OFFSET $startIndex";
    print('Query : $qStr');
    var res = await _db.getqueryResult(qStr);
    // print(res);

    return res;
  }

  @override
  Future<dynamic> getEntityByID(String id) async {
    String qStr = " SELECT * ";
    qStr += " from " + TableNameUom;
    qStr += " where $column_Uom_Id = ?";

    return UOMDataModel.fromMapForMaster(
        await _db.getSingleRowQueryResult(qStr, [id as int]));
  }

  @override
  Future<int> getMax() async {
    String qStr = 'SELECT MAX($column_Uom_Id) from $TableNameUom';
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
    String qStr = 'SELECT COUNT(*) FROM $TableNameUom where $column_Uom_Id =?';
    int count = await _db.getCount(qStr, [id as int]);
    print('Found count :$count');
    if (count > 0) return true;
    return false;
  }

  @override
  Future<bool> upsertEntity(entity) async {
    print('at insert');
    UOMDataModel object = entity as UOMDataModel;
    await _db.startTransaction();
    Map<String, dynamic> map = object.toMapForMasterInsert(); //();

    print('TO UPDATE $map');

    try {
      if (!await idExists(object.id as String)) {
        print('Insert Inv Group');
        int t = await getMax();
        object.id = t + 1;
        map[column_Uom_Id] = object.id;
        await _db.insertRecords(data: map, tablename: TableNameUom);
      } else {
        print('Updating Inv Group 189');
        Map<String, dynamic> mapClause = new Map();
        mapClause[column_Uom_Id] = object.id;
        print("Ready to UPdate");
        await _db.updateRecords(
            data: map, clause: mapClause, tablename: TableNameUom);
      }

      await _db.commitTransaction();
    } catch (Ex) {
      print(Ex.toString());
      return false;
    }
    return true;
  }

  @override
  Future<bool> deleteEntity(String id) {
    // TODO: implement deleteEntity
    throw UnimplementedError();
  }
}
