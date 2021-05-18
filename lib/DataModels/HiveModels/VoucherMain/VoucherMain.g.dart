// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'VoucherMain.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VoucherMainHiveAdapter extends TypeAdapter<VoucherMainHive> {
  @override
  final int typeId = 100;

  @override
  VoucherMainHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VoucherMainHive(
      Voucher_No: fields[0] as String,
      Voucher_Prefix: fields[1] as String,
      Date_Created: fields[2] as DateTime,
      Voucher_Date: fields[3] as DateTime,
      TimeStamp: fields[4] as DateTime,
      Last_Updated: fields[5] as DateTime,
      Ledger_ID: fields[6] as String,
      Billing_Name: fields[7] as String,
      Total: fields[8] as double,
      Discount_in_Amount: fields[9] as double,
      Discount_in_Percent: fields[10] as double,
      Narration: fields[11] as String,
      Added_By: fields[12] as String,
      delivery_date: fields[13] as DateTime,
      Completion_Probability: fields[14] as double,
      Credit_Period: fields[15] as String,
      POC_Name: fields[16] as String,
      POC_Phone: fields[17] as String,
      POC_Email: fields[18] as String,
      Project_ID: fields[19] as String,
      Revision_Number: fields[20] as String,
      Converted_To_Sales_Order: fields[21] as String,
      Quotation_Dropped: fields[22] as bool,
      VoucherStatus: fields[23] as String,
      Quotation_Dropped_Reason: fields[24] as String,
      Requirement_Voucher_No: fields[25] as String,
      Salesman_ID: fields[26] as String,
      PaymentCompleted: fields[27] as String,
      LPO_Ref: fields[28] as String,
      MODE_OF_SERVICE: fields[29] as String,
      Vat_Amount: fields[30] as double,
      Gross_Total: fields[31] as double,
      ContactID: fields[32] as int,
      Reference: fields[33] as String,
      Currency: fields[34] as String,
      Boxes_Count: fields[35] as int,
      Total_Weight: fields[36] as double,
      LR_No: fields[37] as String,
      Voucher_No_Display: fields[38] as String,
      Requirement_Voucher_List: fields[39] as String,
      Origin: fields[40] as int,
      Round_Off: fields[41] as double,
      TransactionId: fields[42] as String,
      Customer_Expected_Date: fields[43] as DateTime,
      PaymentSplit: fields[44] as bool,
      From_Location: fields[45] as String,
      To_Location: fields[46] as String,
      items: (fields[47] as List)?.cast<VoucherItemDetailHive>(),
      ledgers: (fields[48] as List)?.cast<VoucherLedgerDetailHive>(),
    );
  }

  @override
  void write(BinaryWriter writer, VoucherMainHive obj) {
    writer
      ..writeByte(49)
      ..writeByte(0)
      ..write(obj.Voucher_No)
      ..writeByte(1)
      ..write(obj.Voucher_Prefix)
      ..writeByte(2)
      ..write(obj.Date_Created)
      ..writeByte(3)
      ..write(obj.Voucher_Date)
      ..writeByte(4)
      ..write(obj.TimeStamp)
      ..writeByte(5)
      ..write(obj.Last_Updated)
      ..writeByte(6)
      ..write(obj.Ledger_ID)
      ..writeByte(7)
      ..write(obj.Billing_Name)
      ..writeByte(8)
      ..write(obj.Total)
      ..writeByte(9)
      ..write(obj.Discount_in_Amount)
      ..writeByte(10)
      ..write(obj.Discount_in_Percent)
      ..writeByte(11)
      ..write(obj.Narration)
      ..writeByte(12)
      ..write(obj.Added_By)
      ..writeByte(13)
      ..write(obj.delivery_date)
      ..writeByte(14)
      ..write(obj.Completion_Probability)
      ..writeByte(15)
      ..write(obj.Credit_Period)
      ..writeByte(16)
      ..write(obj.POC_Name)
      ..writeByte(17)
      ..write(obj.POC_Phone)
      ..writeByte(18)
      ..write(obj.POC_Email)
      ..writeByte(19)
      ..write(obj.Project_ID)
      ..writeByte(20)
      ..write(obj.Revision_Number)
      ..writeByte(21)
      ..write(obj.Converted_To_Sales_Order)
      ..writeByte(22)
      ..write(obj.Quotation_Dropped)
      ..writeByte(23)
      ..write(obj.VoucherStatus)
      ..writeByte(24)
      ..write(obj.Quotation_Dropped_Reason)
      ..writeByte(25)
      ..write(obj.Requirement_Voucher_No)
      ..writeByte(26)
      ..write(obj.Salesman_ID)
      ..writeByte(27)
      ..write(obj.PaymentCompleted)
      ..writeByte(28)
      ..write(obj.LPO_Ref)
      ..writeByte(29)
      ..write(obj.MODE_OF_SERVICE)
      ..writeByte(30)
      ..write(obj.Vat_Amount)
      ..writeByte(31)
      ..write(obj.Gross_Total)
      ..writeByte(32)
      ..write(obj.ContactID)
      ..writeByte(33)
      ..write(obj.Reference)
      ..writeByte(34)
      ..write(obj.Currency)
      ..writeByte(35)
      ..write(obj.Boxes_Count)
      ..writeByte(36)
      ..write(obj.Total_Weight)
      ..writeByte(37)
      ..write(obj.LR_No)
      ..writeByte(38)
      ..write(obj.Voucher_No_Display)
      ..writeByte(39)
      ..write(obj.Requirement_Voucher_List)
      ..writeByte(40)
      ..write(obj.Origin)
      ..writeByte(41)
      ..write(obj.Round_Off)
      ..writeByte(42)
      ..write(obj.TransactionId)
      ..writeByte(43)
      ..write(obj.Customer_Expected_Date)
      ..writeByte(44)
      ..write(obj.PaymentSplit)
      ..writeByte(45)
      ..write(obj.From_Location)
      ..writeByte(46)
      ..write(obj.To_Location)
      ..writeByte(47)
      ..write(obj.items)
      ..writeByte(48)
      ..write(obj.ledgers);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VoucherMainHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
