import 'package:hive/hive.dart';

part 'PriceListMasterHive.g.dart';

@HiveType(typeId: 41)
class PriceListMasterHive extends HiveObject {
  @HiveField(0)
  int Price_List_ID;
  @HiveField(1)
  String Price_List_Name;
  @HiveField(2)
  DateTime Price_List_Start_Date;
  @HiveField(3)
  DateTime Price_List_End_Date;
  @HiveField(4)
  bool Price_List_Default;
}
