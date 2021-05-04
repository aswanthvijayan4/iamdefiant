// import 'package:moor/moor.dart';

// import '../MoorDBHelper.dart';

// part 'UOMMoor.g.dart';

// class UomListMaster extends Table {
//   @override
//   String get tableName => 'UOMList';
//   IntColumn get UOM_id => integer().autoIncrement()();
//   TextColumn get uom_Name => text().withLength(min: 1, max: 20)();
//   TextColumn get uom_symbol => text().withLength(min: 1, max: 20)();
//   IntColumn get UOM_decimal_Points => integer()();
//   TextColumn get UOM_Narration => text().nullable()();
//   DateTimeColumn get timestamp => dateTime().nullable()();
// }

// @UseDao(tables: [UomListMaster])
// class UOMDao extends DatabaseAccessor<MoorDatabase> with _$UOMDaoMixin {
//   final MoorDatabase db;

//   UOMDao(this.db) : super(db);

//   Future<int> addUom(UomListMasterCompanion entity) {
//     return into(uomListMaster).insert(entity);
//   }

//   Future updateUOM(UomListMasterCompanion entity) {
//     return update(uomListMaster).replace(entity);
//   }
// }
