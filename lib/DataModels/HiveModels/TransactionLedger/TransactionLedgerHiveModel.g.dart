// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TransactionLedgerHiveModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionLedgerHiveModelAdapter
    extends TypeAdapter<TransactionLedgerHiveModel> {
  @override
  final int typeId = 3;

  @override
  TransactionLedgerHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransactionLedgerHiveModel()
      ..Voucher_Type = fields[0] as String
      ..Voucher_Prefix = fields[1] as String
      ..Project_ID = fields[2] as String
      ..Voucher_ID = fields[3] as String
      ..Voucher_Date = fields[4] as DateTime
      ..Transaction_Amount = fields[5] as double
      ..Credit_Ledger_ID = fields[6] as String
      ..Debit_Ledger_ID = fields[7] as String
      ..Narration = fields[8] as String
      ..Salesman_ID = fields[9] as String
      ..TIMESTAMP = fields[10] as DateTime
      ..isAdditional = fields[11] as bool
      ..Debit_Amount = fields[12] as double
      ..Credit_Amount = fields[13] as double
      ..Ledger_ID = fields[14] as String
      ..Against_Ledger = fields[15] as String
      ..isProfitCentre = fields[16] as String;
  }

  @override
  void write(BinaryWriter writer, TransactionLedgerHiveModel obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.Voucher_Type)
      ..writeByte(1)
      ..write(obj.Voucher_Prefix)
      ..writeByte(2)
      ..write(obj.Project_ID)
      ..writeByte(3)
      ..write(obj.Voucher_ID)
      ..writeByte(4)
      ..write(obj.Voucher_Date)
      ..writeByte(5)
      ..write(obj.Transaction_Amount)
      ..writeByte(6)
      ..write(obj.Credit_Ledger_ID)
      ..writeByte(7)
      ..write(obj.Debit_Ledger_ID)
      ..writeByte(8)
      ..write(obj.Narration)
      ..writeByte(9)
      ..write(obj.Salesman_ID)
      ..writeByte(10)
      ..write(obj.TIMESTAMP)
      ..writeByte(11)
      ..write(obj.isAdditional)
      ..writeByte(12)
      ..write(obj.Debit_Amount)
      ..writeByte(13)
      ..write(obj.Credit_Amount)
      ..writeByte(14)
      ..write(obj.Ledger_ID)
      ..writeByte(15)
      ..write(obj.Against_Ledger)
      ..writeByte(16)
      ..write(obj.isProfitCentre);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionLedgerHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
