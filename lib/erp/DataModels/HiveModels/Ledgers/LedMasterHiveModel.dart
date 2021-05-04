import 'package:hive/hive.dart';

part 'LedMasterHiveModel.g.dart';

@HiveType(typeId: 21)
class LedMasterHiveModel extends HiveObject {
  @HiveField(36)
  String LEDGER_ID;
  @HiveField(1)
  String Ledger_Name;
  @HiveField(2)
  String Ledger_Type;
  @HiveField(3)
  String Group_Id;
  @HiveField(4)
  String Opening_Balance;
  @HiveField(5)
  DateTime Opening_Balance_Date;
  @HiveField(6)
  double Closing_Balance;
  @HiveField(7)
  double Turn_Over;
  @HiveField(8)
  bool isIndividual;
  @HiveField(9)
  String Narration;
  @HiveField(10)
  String City;
  @HiveField(11)
  String Address;
  @HiveField(12)
  String Email;
  @HiveField(13)
  String Phone_Number;
  @HiveField(14)
  String Contact_Person_Name;
  @HiveField(15)
  String Mobile_Number;
  @HiveField(16)
  String Website;
  @HiveField(17)
  String Contact_Person;
  @HiveField(18)
  String Contant_Person_Number;
  @HiveField(19)
  String PoBox;
  @HiveField(20)
  String Country;
  @HiveField(21)
  String Registration_Number;
  @HiveField(22)
  String Default_Price_List_Id;
  @HiveField(23)
  String State;
  @HiveField(24)
  String Birth_Date;
  @HiveField(25)
  int Credit_Period;
  @HiveField(26)
  String ParentCompany;
  @HiveField(27)
  String Fax;
  @HiveField(28)
  double creditAllowed;
  @HiveField(29)
  String paymentTerms;
  @HiveField(30)
  double Tax_Rate;
  @HiveField(31)
  String Type_Of_Supply;
  @HiveField(32)
  String Default_Tax_Ledger;
  @HiveField(33)
  String TRN;
  @HiveField(34)
  bool DefaultRecord;
  @HiveField(35)
  String DbName;
}
