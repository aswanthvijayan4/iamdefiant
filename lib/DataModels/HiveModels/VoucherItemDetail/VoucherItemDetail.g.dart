// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'VoucherItemDetail.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VoucherItemDetailHiveAdapter extends TypeAdapter<VoucherItemDetailHive> {
  @override
  final int typeId = 101;

  @override
  VoucherItemDetailHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VoucherItemDetailHive(
      Inventory_Item_ID: fields[3] as String,
      Quantity: fields[4] as double,
      Price: fields[5] as double,
      UOM_id: fields[6] as String,
      PriceLevel: fields[7] as String,
      isCompoundItem: fields[8] as bool,
      subItemOff_list_ID: fields[9] as String,
      Discount_Percent: fields[10] as double,
      Discount_Amount: fields[11] as double,
      Subtotal: fields[12] as double,
      Dimension: fields[13] as String,
      Project_ID: fields[14] as String,
      Item_Narration: fields[15] as String,
      Item_Description: fields[16] as String,
      Salesman_ID: fields[17] as String,
      Requirement_ItemID: fields[18] as String,
      Length: fields[19] as double,
      Time: fields[20] as DateTime,
      ItemVoucherStatus: fields[21] as double,
      itemProductionStatus: fields[22] as double,
      Tax_Rate: fields[23] as double,
      Tax_Amount: fields[24] as double,
      Quantity_Full: fields[25] as double,
      Quantity_Disc: fields[26] as double,
      fromGodown: fields[27] as String,
      toGodown: fields[28] as String,
      crQty: fields[29] as double,
      drQty: fields[30] as double,
      crAmount: fields[31] as double,
      drAmount: fields[32] as double,
      printedName: fields[33] as String,
    );
  }

  @override
  void write(BinaryWriter writer, VoucherItemDetailHive obj) {
    writer
      ..writeByte(31)
      ..writeByte(3)
      ..write(obj.Inventory_Item_ID)
      ..writeByte(4)
      ..write(obj.Quantity)
      ..writeByte(5)
      ..write(obj.Price)
      ..writeByte(6)
      ..write(obj.UOM_id)
      ..writeByte(7)
      ..write(obj.PriceLevel)
      ..writeByte(8)
      ..write(obj.isCompoundItem)
      ..writeByte(9)
      ..write(obj.subItemOff_list_ID)
      ..writeByte(10)
      ..write(obj.Discount_Percent)
      ..writeByte(11)
      ..write(obj.Discount_Amount)
      ..writeByte(12)
      ..write(obj.Subtotal)
      ..writeByte(13)
      ..write(obj.Dimension)
      ..writeByte(14)
      ..write(obj.Project_ID)
      ..writeByte(15)
      ..write(obj.Item_Narration)
      ..writeByte(16)
      ..write(obj.Item_Description)
      ..writeByte(17)
      ..write(obj.Salesman_ID)
      ..writeByte(18)
      ..write(obj.Requirement_ItemID)
      ..writeByte(19)
      ..write(obj.Length)
      ..writeByte(20)
      ..write(obj.Time)
      ..writeByte(21)
      ..write(obj.ItemVoucherStatus)
      ..writeByte(22)
      ..write(obj.itemProductionStatus)
      ..writeByte(23)
      ..write(obj.Tax_Rate)
      ..writeByte(24)
      ..write(obj.Tax_Amount)
      ..writeByte(25)
      ..write(obj.Quantity_Full)
      ..writeByte(26)
      ..write(obj.Quantity_Disc)
      ..writeByte(27)
      ..write(obj.fromGodown)
      ..writeByte(28)
      ..write(obj.toGodown)
      ..writeByte(29)
      ..write(obj.crQty)
      ..writeByte(30)
      ..write(obj.drQty)
      ..writeByte(31)
      ..write(obj.crAmount)
      ..writeByte(32)
      ..write(obj.drAmount)
      ..writeByte(33)
      ..write(obj.printedName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VoucherItemDetailHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
