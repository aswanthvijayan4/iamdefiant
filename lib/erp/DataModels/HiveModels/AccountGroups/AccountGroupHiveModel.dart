import 'package:hive/hive.dart';

part 'AccountGroupHiveModel.g.dart';

@HiveType(typeId: 2)
class AccountGroupHiveModel extends HiveObject {
  @HiveField(0)
  String Group_ID;
  @HiveField(1)
  String Group_Name;
  @HiveField(2)
  String Parent_ID;
  @HiveField(3)
  String Group_Type;
  @HiveField(4)
  String Group_Category;
  @HiveField(5)
  bool DefaultRecord;
}
