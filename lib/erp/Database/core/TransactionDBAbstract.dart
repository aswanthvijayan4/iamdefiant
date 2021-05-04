import 'package:authentication_with_bloc/erp/DataModels/Transactions/GeneralVoucherDataModel.dart';
import 'package:authentication_with_bloc/erp/Database/DatabaseHelper.dart';

abstract class TransactionDBAbstract {
  TransactionDBAbstract(
      this.voucherDateColumn,
      this.colSecond,
      this.colThrid,
      this.colFourth,
      this.colFifth,
      this.mainTableName,
      this.detailsTableName,
      this.voucherNoColumn,
      this.voucherPrefixColumn,
      this.voucherTyperAbstract,
      this._db);

  Future<bool> upsertVoucher(GeneralVoucherDataModel voucher);
  Future<bool> deleteVoucher(String voucherNo, String voucherPrefix) async {
    Map clause = Map();
    clause[voucherNoColumn] = voucherNo;
    clause[voucherPrefixColumn] = voucherPrefix;
    try {
      _db.startTransaction();
      await _db.deleteRecords(tablename: mainTableName, clause: clause);
      await _db.deleteRecords(tablename: detailsTableName, clause: clause);
      _db.commitTransaction();
    } catch (Ex) {
      print(Ex.toString());
      return false;
    }
    return true;
  }

  Future<int> getMax(String voucherPrefix) async {
    String qStr =
        'SELECT MAX($voucherNoColumn) from $mainTableName where $voucherPrefixColumn = ?';
    int n = await _db.getCount(qStr, [voucherPrefixColumn]);
    print('next = $n');
    return n;
  }

  Future<bool> exists(String voucherNo, String voucherPrefix) async {
    if (voucherNo == null || voucherPrefix == null) return false;
    String qStr =
        'SELECT COUNT(*) FROM $mainTableName where $voucherNoColumn =? AND $voucherPrefixColumn = ?';
    int count = await _db.getCount(qStr, [voucherNo, voucherPrefix]);
    print('Found count :$count');
    if (count > 0) return true;
    return false;
  }

  Future<List<Map>> getVoucherListbyDate(
      DateTime dateFrom, DateTime dateTo, int startIndex,
      [int limit = 40]) async {
    String qStr = "SELECT ";
    qStr += "$voucherDateColumn as 'Date' ,";
    qStr += "$colSecond as '2nd' ,";
    qStr += "$colThrid as '3rd' ,";
    qStr += "$colFourth as '4th' ,";
    qStr += "$colFifth as '5th' ";

    qStr += " FROM $mainTableName ";
    qStr += " WHERE ";
    qStr += " ${DatabaseHelper.colToDate(voucherDateColumn)}  > ";
    qStr += " ${DatabaseHelper.dateTimetoString(dateFrom)}  ";
    qStr += " AND ";
    qStr += " ${DatabaseHelper.colToDate(voucherDateColumn)}  <";
    qStr += "${DatabaseHelper.dateTimetoString(dateTo)} ";

    List<Map> res = await _db.getqueryResult(qStr);
    // print(res);

    return res;
  }

  Future<GeneralVoucherDataModel> getVoucherByVoucherNo(
      String voucherNo, String voucherPrefix);

  final String voucherDateColumn;
  final String colSecond;
  final String colThrid;
  final String colFourth;
  final String colFifth;

  final String mainTableName;
  final String detailsTableName;

  final String voucherNoColumn;
  final String voucherPrefixColumn;
  final String voucherTyperAbstract;

  final DatabaseHelper _db;
}
