import 'package:hive/hive.dart';

@HiveType(typeId: 51)
class EmployeeHiveModel extends HiveObject {
  @HiveField(0)
  String Name;
  @HiveField(1)
  String Email;
  @HiveField(2)
  String Phone;
  @HiveField(3)
  String Address;
  @HiveField(4)
  String Employee_ID;
  @HiveField(5)
  String Designation;
  @HiveField(6)
  String Department;
  @HiveField(7)
  String UserName;
  @HiveField(8)
  String Password;
  @HiveField(9)
  int UserGroupID;
  @HiveField(10)
  int privilege;
  @HiveField(11)
  bool Show_Employee;
}
