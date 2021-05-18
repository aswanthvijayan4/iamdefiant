import 'package:hive/hive.dart';
part 'TransactionLedgerHiveModel.g.dart';

@HiveType(typeId: 3)
class TransactionLedgerHiveModel extends HiveObject {
  @HiveField(0)
  String Voucher_Type;
  @HiveField(1)
  String Voucher_Prefix;
  @HiveField(2)
  String Project_ID;
  @HiveField(3)
  String Voucher_ID;
  @HiveField(4)
  DateTime Voucher_Date;
  @HiveField(5)
  double Transaction_Amount;
  @HiveField(6)
  String Credit_Ledger_ID;
  @HiveField(7)
  String Debit_Ledger_ID;
  @HiveField(8)
  String Narration;
  @HiveField(9)
  String Salesman_ID;
  @HiveField(10)
  DateTime TIMESTAMP;
  @HiveField(11)
  bool isAdditional;
  @HiveField(12)
  double Debit_Amount;
  @HiveField(13)
  double Credit_Amount;
  @HiveField(14)
  String Ledger_ID;
  @HiveField(15)
  String Against_Ledger;
  @HiveField(16)
  String isProfitCentre;
}
