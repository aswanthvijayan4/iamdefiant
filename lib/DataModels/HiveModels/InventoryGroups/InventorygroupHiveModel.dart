import 'package:hive/hive.dart';

part 'InventorygroupHiveModel.g.dart';

@HiveType(typeId: 12)
class InventorygroupHiveModel extends HiveObject {
  @HiveField(0)
  String Group_ID;
  @HiveField(1)
  String Group_Name;
  @HiveField(2)
  String Parent_ID;
  @HiveField(3)
  String Group_Type;
  @HiveField(4)
  String GroupNameArabic;
  @HiveField(5)
  String Group_Name_Arabic;
}
