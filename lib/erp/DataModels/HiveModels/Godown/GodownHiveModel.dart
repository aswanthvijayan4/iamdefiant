import 'package:hive/hive.dart';

part 'GodownHiveModel.g.dart';

@HiveType(typeId: 61)
class GodownHiveModel extends HiveObject {

  @HiveField(0)
  String Godown_ID;
  @HiveField(1)
  String Godown_Name;
  @HiveField(2)
  String Godown_Location;
  @HiveField(3)
  String Godown_Narration;
  @HiveField(4)
  bool isProfitCentre;
}
