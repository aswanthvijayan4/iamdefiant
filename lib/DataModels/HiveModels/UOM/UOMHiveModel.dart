import 'package:hive/hive.dart';

part 'UOMHiveModel.g.dart';

@HiveType(typeId: 31)
class UOMHiveMOdel extends HiveObject {
  @HiveField(0)
  int UOM_id;
  @HiveField(1)
  String uom_Name;
  @HiveField(2)
  String uom_symbol;
  @HiveField(3)
  int UOM_decimal_Points;
  @HiveField(4)
  String UOM_Narration;
  @HiveField(5)
  DateTime timestamp;
}
