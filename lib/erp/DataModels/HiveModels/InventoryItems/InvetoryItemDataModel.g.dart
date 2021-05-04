// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'InvetoryItemDataModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InventoryItemHiveAdapter extends TypeAdapter<InventoryItemHive> {
  @override
  final int typeId = 11;

  @override
  InventoryItemHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InventoryItemHive(
      Item_ID: fields[0] as String,
      Item_Name: fields[1] as String,
      Item_Alias: fields[2] as String,
      Item_Code: fields[3] as String,
      Group_Id: fields[4] as String,
      Part_Number: fields[5] as String,
      Price: fields[6] as double,
      Opening_Stock: fields[7] as double,
      Opening_Balance: fields[8] as double,
      Opening_Balance_Date: fields[9] as DateTime,
      Last_Modified_By: fields[10] as String,
      Opening_Rate: fields[11] as double,
      Opening_Value: fields[12] as double,
      Narration: fields[13] as String,
      Serial_Number: fields[14] as String,
      Closing_Stock: fields[15] as double,
      Reorder_Level: fields[16] as double,
      Std_Cost: fields[17] as double,
      Vat_Rate: fields[18] as double,
      Default_UOM_ID: fields[19] as int,
      Last_Modified: fields[20] as DateTime,
      Date_Created: fields[21] as DateTime,
      Timestamp: fields[22] as DateTime,
      Warranty_Days: fields[23] as int,
      Shelf_Life: fields[24] as double,
      Brand_Id: fields[25] as String,
      Item_Description: fields[26] as String,
      isCustomItem: fields[27] as bool,
      Dimension: fields[28] as String,
      isPurchaseItem: fields[29] as bool,
      isSalesItem: fields[30] as bool,
      KOT_Printer: fields[31] as String,
      Item_Name_Arabic: fields[32] as String,
      Favourite: fields[33] as bool,
      IsStockItem: fields[34] as bool,
      From_Time: fields[35] as DateTime,
      To_Time: fields[36] as DateTime,
      Price_2: fields[37] as double,
      HSN_CODE: fields[38] as String,
      Section: fields[39] as String,
      Flags: fields[40] as String,
      Category: fields[41] as String,
      DefaultLedgerID: fields[42] as String,
    );
  }

  @override
  void write(BinaryWriter writer, InventoryItemHive obj) {
    writer
      ..writeByte(43)
      ..writeByte(0)
      ..write(obj.Item_ID)
      ..writeByte(1)
      ..write(obj.Item_Name)
      ..writeByte(2)
      ..write(obj.Item_Alias)
      ..writeByte(3)
      ..write(obj.Item_Code)
      ..writeByte(4)
      ..write(obj.Group_Id)
      ..writeByte(5)
      ..write(obj.Part_Number)
      ..writeByte(6)
      ..write(obj.Price)
      ..writeByte(7)
      ..write(obj.Opening_Stock)
      ..writeByte(8)
      ..write(obj.Opening_Balance)
      ..writeByte(9)
      ..write(obj.Opening_Balance_Date)
      ..writeByte(10)
      ..write(obj.Last_Modified_By)
      ..writeByte(11)
      ..write(obj.Opening_Rate)
      ..writeByte(12)
      ..write(obj.Opening_Value)
      ..writeByte(13)
      ..write(obj.Narration)
      ..writeByte(14)
      ..write(obj.Serial_Number)
      ..writeByte(15)
      ..write(obj.Closing_Stock)
      ..writeByte(16)
      ..write(obj.Reorder_Level)
      ..writeByte(17)
      ..write(obj.Std_Cost)
      ..writeByte(18)
      ..write(obj.Vat_Rate)
      ..writeByte(19)
      ..write(obj.Default_UOM_ID)
      ..writeByte(20)
      ..write(obj.Last_Modified)
      ..writeByte(21)
      ..write(obj.Date_Created)
      ..writeByte(22)
      ..write(obj.Timestamp)
      ..writeByte(23)
      ..write(obj.Warranty_Days)
      ..writeByte(24)
      ..write(obj.Shelf_Life)
      ..writeByte(25)
      ..write(obj.Brand_Id)
      ..writeByte(26)
      ..write(obj.Item_Description)
      ..writeByte(27)
      ..write(obj.isCustomItem)
      ..writeByte(28)
      ..write(obj.Dimension)
      ..writeByte(29)
      ..write(obj.isPurchaseItem)
      ..writeByte(30)
      ..write(obj.isSalesItem)
      ..writeByte(31)
      ..write(obj.KOT_Printer)
      ..writeByte(32)
      ..write(obj.Item_Name_Arabic)
      ..writeByte(33)
      ..write(obj.Favourite)
      ..writeByte(34)
      ..write(obj.IsStockItem)
      ..writeByte(35)
      ..write(obj.From_Time)
      ..writeByte(36)
      ..write(obj.To_Time)
      ..writeByte(37)
      ..write(obj.Price_2)
      ..writeByte(38)
      ..write(obj.HSN_CODE)
      ..writeByte(39)
      ..write(obj.Section)
      ..writeByte(40)
      ..write(obj.Flags)
      ..writeByte(41)
      ..write(obj.Category)
      ..writeByte(42)
      ..write(obj.DefaultLedgerID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InventoryItemHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
