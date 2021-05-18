// // GENERATED CODE - DO NOT MODIFY BY HAND

// part of 'MoorDBHelper.dart';

// // **************************************************************************
// // MoorGenerator
// // **************************************************************************

// // ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
// class UomListMasterData extends DataClass
//     implements Insertable<UomListMasterData> {
//   final int UOM_id;
//   final String uom_Name;
//   final String uom_symbol;
//   final int UOM_decimal_Points;
//   final String UOM_Narration;
//   final DateTime timestamp;
//   UomListMasterData(
//       {@required this.UOM_id,
//       @required this.uom_Name,
//       @required this.uom_symbol,
//       @required this.UOM_decimal_Points,
//       this.UOM_Narration,
//       this.timestamp});
//   factory UomListMasterData.fromData(
//       Map<String, dynamic> data, GeneratedDatabase db,
//       {String prefix}) {
//     final effectivePrefix = prefix ?? '';
//     final intType = db.typeSystem.forDartType<int>();
//     final stringType = db.typeSystem.forDartType<String>();
//     final dateTimeType = db.typeSystem.forDartType<DateTime>();
//     return UomListMasterData(
//       UOM_id:
//           intType.mapFromDatabaseResponse(data['${effectivePrefix}u_o_m_id']),
//       uom_Name: stringType
//           .mapFromDatabaseResponse(data['${effectivePrefix}uom_name']),
//       uom_symbol: stringType
//           .mapFromDatabaseResponse(data['${effectivePrefix}uom_symbol']),
//       UOM_decimal_Points: intType.mapFromDatabaseResponse(
//           data['${effectivePrefix}u_o_m_decimal_points']),
//       UOM_Narration: stringType
//           .mapFromDatabaseResponse(data['${effectivePrefix}u_o_m_narration']),
//       timestamp: dateTimeType
//           .mapFromDatabaseResponse(data['${effectivePrefix}timestamp']),
//     );
//   }
//   @override
//   Map<String, Expression> toColumns(bool nullToAbsent) {
//     final map = <String, Expression>{};
//     if (!nullToAbsent || UOM_id != null) {
//       map['u_o_m_id'] = Variable<int>(UOM_id);
//     }
//     if (!nullToAbsent || uom_Name != null) {
//       map['uom_name'] = Variable<String>(uom_Name);
//     }
//     if (!nullToAbsent || uom_symbol != null) {
//       map['uom_symbol'] = Variable<String>(uom_symbol);
//     }
//     if (!nullToAbsent || UOM_decimal_Points != null) {
//       map['u_o_m_decimal_points'] = Variable<int>(UOM_decimal_Points);
//     }
//     if (!nullToAbsent || UOM_Narration != null) {
//       map['u_o_m_narration'] = Variable<String>(UOM_Narration);
//     }
//     if (!nullToAbsent || timestamp != null) {
//       map['timestamp'] = Variable<DateTime>(timestamp);
//     }
//     return map;
//   }

//   UomListMasterCompanion toCompanion(bool nullToAbsent) {
//     return UomListMasterCompanion(
//       UOM_id:
//           UOM_id == null && nullToAbsent ? const Value.absent() : Value(UOM_id),
//       uom_Name: uom_Name == null && nullToAbsent
//           ? const Value.absent()
//           : Value(uom_Name),
//       uom_symbol: uom_symbol == null && nullToAbsent
//           ? const Value.absent()
//           : Value(uom_symbol),
//       UOM_decimal_Points: UOM_decimal_Points == null && nullToAbsent
//           ? const Value.absent()
//           : Value(UOM_decimal_Points),
//       UOM_Narration: UOM_Narration == null && nullToAbsent
//           ? const Value.absent()
//           : Value(UOM_Narration),
//       timestamp: timestamp == null && nullToAbsent
//           ? const Value.absent()
//           : Value(timestamp),
//     );
//   }

//   factory UomListMasterData.fromJson(Map<String, dynamic> json,
//       {ValueSerializer serializer}) {
//     serializer ??= moorRuntimeOptions.defaultSerializer;
//     return UomListMasterData(
//       UOM_id: serializer.fromJson<int>(json['UOM_id']),
//       uom_Name: serializer.fromJson<String>(json['uom_Name']),
//       uom_symbol: serializer.fromJson<String>(json['uom_symbol']),
//       UOM_decimal_Points: serializer.fromJson<int>(json['UOM_decimal_Points']),
//       UOM_Narration: serializer.fromJson<String>(json['UOM_Narration']),
//       timestamp: serializer.fromJson<DateTime>(json['timestamp']),
//     );
//   }
//   @override
//   Map<String, dynamic> toJson({ValueSerializer serializer}) {
//     serializer ??= moorRuntimeOptions.defaultSerializer;
//     return <String, dynamic>{
//       'UOM_id': serializer.toJson<int>(UOM_id),
//       'uom_Name': serializer.toJson<String>(uom_Name),
//       'uom_symbol': serializer.toJson<String>(uom_symbol),
//       'UOM_decimal_Points': serializer.toJson<int>(UOM_decimal_Points),
//       'UOM_Narration': serializer.toJson<String>(UOM_Narration),
//       'timestamp': serializer.toJson<DateTime>(timestamp),
//     };
//   }

//   UomListMasterData copyWith(
//           {int UOM_id,
//           String uom_Name,
//           String uom_symbol,
//           int UOM_decimal_Points,
//           String UOM_Narration,
//           DateTime timestamp}) =>
//       UomListMasterData(
//         UOM_id: UOM_id ?? this.UOM_id,
//         uom_Name: uom_Name ?? this.uom_Name,
//         uom_symbol: uom_symbol ?? this.uom_symbol,
//         UOM_decimal_Points: UOM_decimal_Points ?? this.UOM_decimal_Points,
//         UOM_Narration: UOM_Narration ?? this.UOM_Narration,
//         timestamp: timestamp ?? this.timestamp,
//       );
//   @override
//   String toString() {
//     return (StringBuffer('UomListMasterData(')
//           ..write('UOM_id: $UOM_id, ')
//           ..write('uom_Name: $uom_Name, ')
//           ..write('uom_symbol: $uom_symbol, ')
//           ..write('UOM_decimal_Points: $UOM_decimal_Points, ')
//           ..write('UOM_Narration: $UOM_Narration, ')
//           ..write('timestamp: $timestamp')
//           ..write(')'))
//         .toString();
//   }

//   @override
//   int get hashCode => $mrjf($mrjc(
//       UOM_id.hashCode,
//       $mrjc(
//           uom_Name.hashCode,
//           $mrjc(
//               uom_symbol.hashCode,
//               $mrjc(UOM_decimal_Points.hashCode,
//                   $mrjc(UOM_Narration.hashCode, timestamp.hashCode))))));
//   @override
//   bool operator ==(dynamic other) =>
//       identical(this, other) ||
//       (other is UomListMasterData &&
//           other.UOM_id == this.UOM_id &&
//           other.uom_Name == this.uom_Name &&
//           other.uom_symbol == this.uom_symbol &&
//           other.UOM_decimal_Points == this.UOM_decimal_Points &&
//           other.UOM_Narration == this.UOM_Narration &&
//           other.timestamp == this.timestamp);
// }

// class UomListMasterCompanion extends UpdateCompanion<UomListMasterData> {
//   final Value<int> UOM_id;
//   final Value<String> uom_Name;
//   final Value<String> uom_symbol;
//   final Value<int> UOM_decimal_Points;
//   final Value<String> UOM_Narration;
//   final Value<DateTime> timestamp;
//   const UomListMasterCompanion({
//     this.UOM_id = const Value.absent(),
//     this.uom_Name = const Value.absent(),
//     this.uom_symbol = const Value.absent(),
//     this.UOM_decimal_Points = const Value.absent(),
//     this.UOM_Narration = const Value.absent(),
//     this.timestamp = const Value.absent(),
//   });
//   UomListMasterCompanion.insert({
//     this.UOM_id = const Value.absent(),
//     @required String uom_Name,
//     @required String uom_symbol,
//     @required int UOM_decimal_Points,
//     this.UOM_Narration = const Value.absent(),
//     this.timestamp = const Value.absent(),
//   })  : uom_Name = Value(uom_Name),
//         uom_symbol = Value(uom_symbol),
//         UOM_decimal_Points = Value(UOM_decimal_Points);
//   static Insertable<UomListMasterData> custom({
//     Expression<int> UOM_id,
//     Expression<String> uom_Name,
//     Expression<String> uom_symbol,
//     Expression<int> UOM_decimal_Points,
//     Expression<String> UOM_Narration,
//     Expression<DateTime> timestamp,
//   }) {
//     return RawValuesInsertable({
//       if (UOM_id != null) 'u_o_m_id': UOM_id,
//       if (uom_Name != null) 'uom_name': uom_Name,
//       if (uom_symbol != null) 'uom_symbol': uom_symbol,
//       if (UOM_decimal_Points != null)
//         'u_o_m_decimal_points': UOM_decimal_Points,
//       if (UOM_Narration != null) 'u_o_m_narration': UOM_Narration,
//       if (timestamp != null) 'timestamp': timestamp,
//     });
//   }

//   UomListMasterCompanion copyWith(
//       {Value<int> UOM_id,
//       Value<String> uom_Name,
//       Value<String> uom_symbol,
//       Value<int> UOM_decimal_Points,
//       Value<String> UOM_Narration,
//       Value<DateTime> timestamp}) {
//     return UomListMasterCompanion(
//       UOM_id: UOM_id ?? this.UOM_id,
//       uom_Name: uom_Name ?? this.uom_Name,
//       uom_symbol: uom_symbol ?? this.uom_symbol,
//       UOM_decimal_Points: UOM_decimal_Points ?? this.UOM_decimal_Points,
//       UOM_Narration: UOM_Narration ?? this.UOM_Narration,
//       timestamp: timestamp ?? this.timestamp,
//     );
//   }

//   @override
//   Map<String, Expression> toColumns(bool nullToAbsent) {
//     final map = <String, Expression>{};
//     if (UOM_id.present) {
//       map['u_o_m_id'] = Variable<int>(UOM_id.value);
//     }
//     if (uom_Name.present) {
//       map['uom_name'] = Variable<String>(uom_Name.value);
//     }
//     if (uom_symbol.present) {
//       map['uom_symbol'] = Variable<String>(uom_symbol.value);
//     }
//     if (UOM_decimal_Points.present) {
//       map['u_o_m_decimal_points'] = Variable<int>(UOM_decimal_Points.value);
//     }
//     if (UOM_Narration.present) {
//       map['u_o_m_narration'] = Variable<String>(UOM_Narration.value);
//     }
//     if (timestamp.present) {
//       map['timestamp'] = Variable<DateTime>(timestamp.value);
//     }
//     return map;
//   }

//   @override
//   String toString() {
//     return (StringBuffer('UomListMasterCompanion(')
//           ..write('UOM_id: $UOM_id, ')
//           ..write('uom_Name: $uom_Name, ')
//           ..write('uom_symbol: $uom_symbol, ')
//           ..write('UOM_decimal_Points: $UOM_decimal_Points, ')
//           ..write('UOM_Narration: $UOM_Narration, ')
//           ..write('timestamp: $timestamp')
//           ..write(')'))
//         .toString();
//   }
// }

// class $UomListMasterTable extends UomListMaster
//     with TableInfo<$UomListMasterTable, UomListMasterData> {
//   final GeneratedDatabase _db;
//   final String _alias;
//   $UomListMasterTable(this._db, [this._alias]);
//   final VerificationMeta _UOM_idMeta = const VerificationMeta('UOM_id');
//   GeneratedIntColumn _UOM_id;
//   @override
//   GeneratedIntColumn get UOM_id => _UOM_id ??= _constructUOMId();
//   GeneratedIntColumn _constructUOMId() {
//     return GeneratedIntColumn('u_o_m_id', $tableName, false,
//         hasAutoIncrement: true, declaredAsPrimaryKey: true);
//   }

//   final VerificationMeta _uom_NameMeta = const VerificationMeta('uom_Name');
//   GeneratedTextColumn _uom_Name;
//   @override
//   GeneratedTextColumn get uom_Name => _uom_Name ??= _constructUomName();
//   GeneratedTextColumn _constructUomName() {
//     return GeneratedTextColumn('uom_name', $tableName, false,
//         minTextLength: 1, maxTextLength: 20);
//   }

//   final VerificationMeta _uom_symbolMeta = const VerificationMeta('uom_symbol');
//   GeneratedTextColumn _uom_symbol;
//   @override
//   GeneratedTextColumn get uom_symbol => _uom_symbol ??= _constructUomSymbol();
//   GeneratedTextColumn _constructUomSymbol() {
//     return GeneratedTextColumn('uom_symbol', $tableName, false,
//         minTextLength: 1, maxTextLength: 20);
//   }

//   final VerificationMeta _UOM_decimal_PointsMeta =
//       const VerificationMeta('UOM_decimal_Points');
//   GeneratedIntColumn _UOM_decimal_Points;
//   @override
//   GeneratedIntColumn get UOM_decimal_Points =>
//       _UOM_decimal_Points ??= _constructUOMDecimalPoints();
//   GeneratedIntColumn _constructUOMDecimalPoints() {
//     return GeneratedIntColumn(
//       'u_o_m_decimal_points',
//       $tableName,
//       false,
//     );
//   }

//   final VerificationMeta _UOM_NarrationMeta =
//       const VerificationMeta('UOM_Narration');
//   GeneratedTextColumn _UOM_Narration;
//   @override
//   GeneratedTextColumn get UOM_Narration =>
//       _UOM_Narration ??= _constructUOMNarration();
//   GeneratedTextColumn _constructUOMNarration() {
//     return GeneratedTextColumn(
//       'u_o_m_narration',
//       $tableName,
//       true,
//     );
//   }

//   final VerificationMeta _timestampMeta = const VerificationMeta('timestamp');
//   GeneratedDateTimeColumn _timestamp;
//   @override
//   GeneratedDateTimeColumn get timestamp => _timestamp ??= _constructTimestamp();
//   GeneratedDateTimeColumn _constructTimestamp() {
//     return GeneratedDateTimeColumn(
//       'timestamp',
//       $tableName,
//       true,
//     );
//   }

//   @override
//   List<GeneratedColumn> get $columns => [
//         UOM_id,
//         uom_Name,
//         uom_symbol,
//         UOM_decimal_Points,
//         UOM_Narration,
//         timestamp
//       ];
//   @override
//   $UomListMasterTable get asDslTable => this;
//   @override
//   String get $tableName => _alias ?? 'UOMList';
//   @override
//   final String actualTableName = 'UOMList';
//   @override
//   VerificationContext validateIntegrity(Insertable<UomListMasterData> instance,
//       {bool isInserting = false}) {
//     final context = VerificationContext();
//     final data = instance.toColumns(true);
//     if (data.containsKey('u_o_m_id')) {
//       context.handle(_UOM_idMeta,
//           UOM_id.isAcceptableOrUnknown(data['u_o_m_id'], _UOM_idMeta));
//     }
//     if (data.containsKey('uom_name')) {
//       context.handle(_uom_NameMeta,
//           uom_Name.isAcceptableOrUnknown(data['uom_name'], _uom_NameMeta));
//     } else if (isInserting) {
//       context.missing(_uom_NameMeta);
//     }
//     if (data.containsKey('uom_symbol')) {
//       context.handle(
//           _uom_symbolMeta,
//           uom_symbol.isAcceptableOrUnknown(
//               data['uom_symbol'], _uom_symbolMeta));
//     } else if (isInserting) {
//       context.missing(_uom_symbolMeta);
//     }
//     if (data.containsKey('u_o_m_decimal_points')) {
//       context.handle(
//           _UOM_decimal_PointsMeta,
//           UOM_decimal_Points.isAcceptableOrUnknown(
//               data['u_o_m_decimal_points'], _UOM_decimal_PointsMeta));
//     } else if (isInserting) {
//       context.missing(_UOM_decimal_PointsMeta);
//     }
//     if (data.containsKey('u_o_m_narration')) {
//       context.handle(
//           _UOM_NarrationMeta,
//           UOM_Narration.isAcceptableOrUnknown(
//               data['u_o_m_narration'], _UOM_NarrationMeta));
//     }
//     if (data.containsKey('timestamp')) {
//       context.handle(_timestampMeta,
//           timestamp.isAcceptableOrUnknown(data['timestamp'], _timestampMeta));
//     }
//     return context;
//   }

//   @override
//   Set<GeneratedColumn> get $primaryKey => {UOM_id};
//   @override
//   UomListMasterData map(Map<String, dynamic> data, {String tablePrefix}) {
//     final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
//     return UomListMasterData.fromData(data, _db, prefix: effectivePrefix);
//   }

//   @override
//   $UomListMasterTable createAlias(String alias) {
//     return $UomListMasterTable(_db, alias);
//   }
// }

// abstract class _$MoorDatabase extends GeneratedDatabase {
//   _$MoorDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
//   $UomListMasterTable _uomListMaster;

//   $UomListMasterTable get uomListMaster =>
//       _uomListMaster ??= $UomListMasterTable(this);
//   UOMDao _uOMDao;
//   UOMDao get uOMDao => _uOMDao ??= UOMDao(this as MoorDatabase);
//   @override
//   Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
//   @override
//   List<DatabaseSchemaEntity> get allSchemaEntities => [uomListMaster];
// }
