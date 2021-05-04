import 'package:authentication_with_bloc/erp/DataModels/Masters/Employee/EmployeeDataModel.dart';
import 'package:authentication_with_bloc/erp/Database/DatabaseHelper.dart';
import 'package:authentication_with_bloc/erp/Database/core/MasterDBAbstract.dart';

class EmployeeDBHelper extends MasterDBAbstract {
  final DatabaseHelper _db = DatabaseHelper.get();

  EmployeeDBHelper();

  @override
  Future<List<Map>> getAllEntitiesAsList(
      [int startIndex = -1, int limit = -1, String filter = ""]) async {
    print("Test  at Database filter : $filter");
    String qStr = "SELECT ";
    qStr +=
        "$column_Employee_Details_id as 'id' ,$column_Employee_Details_Name as 'Name',' ' as '1st',";
    qStr += "$column_Employee_Details_Designation ";
    qStr += "as '2nd' ";
    qStr += " FROM $TableName_Employee_Details Gr ";
    if (filter.length > 0)
      qStr += " WHERE $column_Employee_Details_Name LIKE '%$filter%'";
    qStr += " order by 2 ";
    if (limit > -1) qStr += " LIMIT $limit OFFSET $startIndex";
    print('Query : $qStr');
    var res = await _db.getqueryResult(qStr);
    // print(res);

    return res;
  }

  @override
  Future getEntityByID(String id) async {
    // TODO: implement getEntityByID
    throw UnimplementedError();
  }

  @override
  Future<int> getMax() async {
    String qStr =
        'SELECT MAX($column_Employee_Details_id) from $TableName_Employee_Details';
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
        'SELECT COUNT(*) FROM $TableName_Employee_Details where $column_Employee_Details_id =?';
    int count = await _db.getCount(qStr, [id as int]);
    print('Found count :$count');
    if (count > 0) return true;
    return false;
  }

  @override
  Future<bool> upsertEntity(entity) async {
    print('at insert');
    EmployeeProfileDataModel object = entity as EmployeeProfileDataModel;
    await _db.startTransaction();
    Map<String, dynamic> map = object.toMapForMasterInsert(); //();

    print('TO UPDATE $map');

    try {
      if (!await idExists(object.id as String)) {
        print('Insert Inv Group');
        int t = await getMax();
        object.id = t + 1;
        map[column_Employee_Details_id] = object.id;
        await _db.insertRecords(
            data: map, tablename: TableName_Employee_Details);
      } else {
        print('Updating Inv Group 189');
        Map<String, dynamic> mapClause = new Map();
        mapClause[column_Employee_Details_id] = object.id;
        print("Ready to UPdate");
        await _db.updateRecords(
            data: map,
            clause: mapClause,
            tablename: TableName_Employee_Details);
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
