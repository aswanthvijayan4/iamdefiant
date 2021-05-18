// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'VoucherLedgerDetail.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VoucherLedgerDetailHiveAdapter
    extends TypeAdapter<VoucherLedgerDetailHive> {
  @override
  final int typeId = 102;

  @override
  VoucherLedgerDetailHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VoucherLedgerDetailHive(
      Ledger_ID: fields[3] as String,
      Amount: fields[4] as double,
      Cr_Amount: fields[5] as double,
      Dr_Amount: fields[6] as double,
    );
  }

  @override
  void write(BinaryWriter writer, VoucherLedgerDetailHive obj) {
    writer
      ..writeByte(4)
      ..writeByte(3)
      ..write(obj.Ledger_ID)
      ..writeByte(4)
      ..write(obj.Amount)
      ..writeByte(5)
      ..write(obj.Cr_Amount)
      ..writeByte(6)
      ..write(obj.Dr_Amount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VoucherLedgerDetailHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
