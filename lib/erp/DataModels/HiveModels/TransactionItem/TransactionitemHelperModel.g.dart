// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TransactionitemHelperModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionItemModelAdapter extends TypeAdapter<TransactionItemModel> {
  @override
  final int typeId = 2;

  @override
  TransactionItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransactionItemModel(
      itemID: fields[0] as String,
      fromLedger: fields[1] as String,
      toLedger: fields[2] as String,
      voucherID: fields[3] as String,
      voucherPrefix: fields[4] as String,
      voucherDate: fields[5] as String,
      voucherType: fields[6] as String,
      fromLocation: fields[7] as String,
      toLocation: fields[8] as String,
      crQty: fields[9] as double,
      drQty: fields[10] as double,
      crAmount: fields[11] as double,
      drAmount: fields[12] as double,
      narration: fields[13] as String,
      vtime: fields[14] as DateTime,
      requirementItemID: fields[15] as String,
      price: fields[16] as double,
      consumed: fields[17] as double,
      consumedReqId: fields[18] as String,
      batchID: fields[19] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TransactionItemModel obj) {
    writer
      ..writeByte(20)
      ..writeByte(0)
      ..write(obj.itemID)
      ..writeByte(1)
      ..write(obj.fromLedger)
      ..writeByte(2)
      ..write(obj.toLedger)
      ..writeByte(3)
      ..write(obj.voucherID)
      ..writeByte(4)
      ..write(obj.voucherPrefix)
      ..writeByte(5)
      ..write(obj.voucherDate)
      ..writeByte(6)
      ..write(obj.voucherType)
      ..writeByte(7)
      ..write(obj.fromLocation)
      ..writeByte(8)
      ..write(obj.toLocation)
      ..writeByte(9)
      ..write(obj.crQty)
      ..writeByte(10)
      ..write(obj.drQty)
      ..writeByte(11)
      ..write(obj.crAmount)
      ..writeByte(12)
      ..write(obj.drAmount)
      ..writeByte(13)
      ..write(obj.narration)
      ..writeByte(14)
      ..write(obj.vtime)
      ..writeByte(15)
      ..write(obj.requirementItemID)
      ..writeByte(16)
      ..write(obj.price)
      ..writeByte(17)
      ..write(obj.consumed)
      ..writeByte(18)
      ..write(obj.consumedReqId)
      ..writeByte(19)
      ..write(obj.batchID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
