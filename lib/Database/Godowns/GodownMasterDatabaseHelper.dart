import 'package:authentication_with_bloc/DataModels/Masters/Godown/GodownDataModel.dart';
import 'package:authentication_with_bloc/Database/DatabaseHelper.dart';
import 'package:authentication_with_bloc/Database/core/MasterDBAbstract.dart';

class GodownDatabaseHelper implements MasterDBAbstract {
  final DatabaseHelper _db = DatabaseHelper.get();

  GodownDatabaseHelper();
  @override
  Future<List<Map>> getAllEntitiesAsList(
      [int startIndex = -1, int limit = -1, String filter = ""]) async {
    print("Test  at Database filter : $filter");
    String qStr = "SELECT ";
    qStr +=
        "$column_Godown_GodownID as 'id' ,$column_GodownName as 'Name',$column_GodownNarration as '1st',";
    qStr += "$column_GodownLocation";
    qStr += "as '2nd' ";
    qStr += " FROM $Tablename_Godown Gr ";
    if (filter.length > 0) qStr += " WHERE $column_GodownName LIKE '%$filter%'";
    qStr += " order by 2 ";
    if (limit > -1) qStr += " LIMIT $limit OFFSET $startIndex";
    print('Query : $qStr');
    var res = await _db.getqueryResult(qStr);
    // print(res);

    return res;
  }

  @override
  Future<dynamic> getEntityByID(String id) async {
    GodownDataModel godown;
  }

  @override
  Future<int> getMax() async {
    String qStr = 'SELECT MAX($column_Godown_id) from $Tablename_Godown';
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
        'SELECT COUNT(*) FROM $Tablename_Godown where $column_Godown_GodownID =?';
    int count = await _db.getCount(qStr, [id]);
    print('Found count :$count');
    if (count > 0) return true;
    return false;
  }

  @override
  Future<bool> upsertEntity(enitity) {
    // TODO: implement upsertEntity
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteEntity(String id) async {
    // TODO: implement deleteEntity
    throw UnimplementedError();
  }
}
