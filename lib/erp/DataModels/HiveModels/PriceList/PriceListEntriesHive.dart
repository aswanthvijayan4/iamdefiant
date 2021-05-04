import 'package:hive/hive.dart';

part 'PriceListEntriesHive.g.dart';

@HiveType(typeId: 42)
class PriceListEntriesHive extends HiveObject {
  @HiveField(0)
  String Item_Id;
  @HiveField(1)
  String Price;
  @HiveField(2)
  int Price_List_ID;
  @HiveField(3)
  DateTime timestamp;
  @HiveField(4)
  double percent;
  @HiveField(5)
  String UOM_Id;
}
