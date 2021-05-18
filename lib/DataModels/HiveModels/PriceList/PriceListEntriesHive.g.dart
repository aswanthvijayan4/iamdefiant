// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PriceListEntriesHive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PriceListEntriesHiveAdapter extends TypeAdapter<PriceListEntriesHive> {
  @override
  final int typeId = 42;

  @override
  PriceListEntriesHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PriceListEntriesHive()
      ..Item_Id = fields[0] as String
      ..Price = fields[1] as String
      ..Price_List_ID = fields[2] as int
      ..timestamp = fields[3] as DateTime
      ..percent = fields[4] as double
      ..UOM_Id = fields[5] as String;
  }

  @override
  void write(BinaryWriter writer, PriceListEntriesHive obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.Item_Id)
      ..writeByte(1)
      ..write(obj.Price)
      ..writeByte(2)
      ..write(obj.Price_List_ID)
      ..writeByte(3)
      ..write(obj.timestamp)
      ..writeByte(4)
      ..write(obj.percent)
      ..writeByte(5)
      ..write(obj.UOM_Id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PriceListEntriesHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
