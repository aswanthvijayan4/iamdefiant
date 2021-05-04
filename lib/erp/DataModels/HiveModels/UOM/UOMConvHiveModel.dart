// UOMConvHiveModel.dart

import 'package:hive/hive.dart';
part 'UOMConvHiveModel.g.dart';

@HiveType(typeId: 32)
class UOMConvHiveModel extends HiveObject {
  int id;
  @HiveField(1)
  int baseUnit;
  @HiveField(2)
  int toUnit;
  @HiveField(3)
  double conValue;
  @HiveField(4)
  String itemID;
  @HiveField(5)
  String narration;
}
