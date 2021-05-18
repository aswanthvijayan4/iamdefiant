// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PriceListMasterHive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PriceListMasterHiveAdapter extends TypeAdapter<PriceListMasterHive> {
  @override
  final int typeId = 41;

  @override
  PriceListMasterHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PriceListMasterHive()
      ..Price_List_ID = fields[0] as int
      ..Price_List_Name = fields[1] as String
      ..Price_List_Start_Date = fields[2] as DateTime
      ..Price_List_End_Date = fields[3] as DateTime
      ..Price_List_Default = fields[4] as bool;
  }

  @override
  void write(BinaryWriter writer, PriceListMasterHive obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.Price_List_ID)
      ..writeByte(1)
      ..write(obj.Price_List_Name)
      ..writeByte(2)
      ..write(obj.Price_List_Start_Date)
      ..writeByte(3)
      ..write(obj.Price_List_End_Date)
      ..writeByte(4)
      ..write(obj.Price_List_Default);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PriceListMasterHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
