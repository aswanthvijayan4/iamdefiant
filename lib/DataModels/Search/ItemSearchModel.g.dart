// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ItemSearchModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItemSearchModelAdapter extends TypeAdapter<ItemSearchModel> {
  @override
  final int typeId = 1;

  @override
  ItemSearchModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ItemSearchModel(
      itemID: fields[0] as String,
      itemName: fields[1] as String,
      groupName: fields[2] as String,
      groupID: fields[3] as String,
      price: fields[4] as double,
      taxRate: fields[5] as double,
      defaultUomId: fields[6] as int,
      imageUrl: fields[7] as String,
      itemDescription: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ItemSearchModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.itemID)
      ..writeByte(1)
      ..write(obj.itemName)
      ..writeByte(2)
      ..write(obj.groupName)
      ..writeByte(3)
      ..write(obj.groupID)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.taxRate)
      ..writeByte(6)
      ..write(obj.defaultUomId)
      ..writeByte(7)
      ..write(obj.imageUrl)
      ..writeByte(8)
      ..write(obj.itemDescription);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemSearchModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
