import 'dart:convert';

import 'package:hive/hive.dart';

part 'VoucherItemDetail.g.dart';

@HiveType(typeId: 101)
class VoucherItemDetailHive extends HiveObject {
  // @HiveField(0)
  // String Voucher_No;
  // @HiveField(1)
  // String Voucher_Prefix;
  // @HiveField(2)
  // DateTime Voucher_Date;
  @HiveField(3)
  String Inventory_Item_ID;
  @HiveField(4)
  double Quantity;
  @HiveField(5)
  double Price;
  @HiveField(6)
  String UOM_id;
  @HiveField(7)
  String PriceLevel;
  @HiveField(8)
  bool isCompoundItem;
  @HiveField(9)
  String subItemOff_list_ID;
  @HiveField(10)
  double Discount_Percent;
  @HiveField(11)
  double Discount_Amount;
  @HiveField(12)
  double Subtotal;
  @HiveField(13)
  String Dimension;
  @HiveField(14)
  String Project_ID;
  @HiveField(15)
  String Item_Narration;
  @HiveField(16)
  String Item_Description;
  @HiveField(17)
  String Salesman_ID;
  @HiveField(18)
  String Requirement_ItemID;
  @HiveField(19)
  double Length;
  @HiveField(20)
  DateTime Time;
  @HiveField(21)
  double ItemVoucherStatus;
  @HiveField(22)
  double itemProductionStatus;
  @HiveField(23)
  double Tax_Rate;
  @HiveField(24)
  double Tax_Amount;
  @HiveField(25)
  double Quantity_Full;
  @HiveField(26)
  double Quantity_Disc;
  @HiveField(27)
  String fromGodown;
  @HiveField(28)
  String toGodown;
  @HiveField(29)
  double crQty;
  @HiveField(30)
  double drQty;
  @HiveField(31)
  double crAmount;
  @HiveField(32)
  double drAmount;
  @HiveField(33)
  String printedName;

  VoucherItemDetailHive({
    this.Inventory_Item_ID,
    this.Quantity,
    this.Price,
    this.UOM_id,
    this.PriceLevel,
    this.isCompoundItem,
    this.subItemOff_list_ID,
    this.Discount_Percent,
    this.Discount_Amount,
    this.Subtotal,
    this.Dimension,
    this.Project_ID,
    this.Item_Narration,
    this.Item_Description,
    this.Salesman_ID,
    this.Requirement_ItemID,
    this.Length,
    this.Time,
    this.ItemVoucherStatus,
    this.itemProductionStatus,
    this.Tax_Rate,
    this.Tax_Amount,
    this.Quantity_Full,
    this.Quantity_Disc,
    this.fromGodown,
    this.toGodown,
    this.crQty,
    this.drQty,
    this.crAmount,
    this.drAmount,
    this.printedName,
  });

  Map<String, dynamic> toMap() {
    return {
      // 'Voucher_No': Voucher_No,
      // 'Voucher_Prefix': Voucher_Prefix,
      // 'Voucher_Date': Voucher_Date?.millisecondsSinceEpoch,
      'Inventory_Item_ID': Inventory_Item_ID,
      'Quantity': Quantity,
      'Price': Price,
      'UOM_id': UOM_id,
      'PriceLevel': PriceLevel,
      'isCompoundItem': isCompoundItem,
      'subItemOff_list_ID': subItemOff_list_ID,
      'Discount_Percent': Discount_Percent,
      'Discount_Amount': Discount_Amount,
      'Subtotal': Subtotal,
      'Dimension': Dimension,
      'Project_ID': Project_ID,
      'Item_Narration': Item_Narration,
      'Item_Description': Item_Description,
      'Salesman_ID': Salesman_ID,
      'Requirement_ItemID': Requirement_ItemID,
      'Length': Length,
      'Time': Time?.millisecondsSinceEpoch,
      'ItemVoucherStatus': ItemVoucherStatus,
      'itemProductionStatus': itemProductionStatus,
      'Tax_Rate': Tax_Rate,
      'Tax_Amount': Tax_Amount,
      'Quantity_Full': Quantity_Full,
      'Quantity_Disc': Quantity_Disc,
    };
  }

  factory VoucherItemDetailHive.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return VoucherItemDetailHive(
      // Voucher_No: map['Voucher_No'],
      // Voucher_Prefix: map['Voucher_Prefix'],
      // Voucher_Date: DateTime.fromMillisecondsSinceEpoch(map['Voucher_Date']),
      Inventory_Item_ID: map['Inventory_Item_ID'],
      Quantity: map['Quantity'],
      Price: map['Price'],
      UOM_id: map['UOM_id'],
      PriceLevel: map['PriceLevel'],
      isCompoundItem: map['isCompoundItem'],
      subItemOff_list_ID: map['subItemOff_list_ID'],
      Discount_Percent: map['Discount_Percent'],
      Discount_Amount: map['Discount_Amount'],
      Subtotal: map['Subtotal'],
      Dimension: map['Dimension'],
      Project_ID: map['Project_ID'],
      Item_Narration: map['Item_Narration'],
      Item_Description: map['Item_Description'],
      Salesman_ID: map['Salesman_ID'],
      Requirement_ItemID: map['Requirement_ItemID'],
      Length: map['Length'],
      Time: DateTime.fromMillisecondsSinceEpoch(map['Time']),
      ItemVoucherStatus: map['ItemVoucherStatus'],
      itemProductionStatus: map['itemProductionStatus'],
      Tax_Rate: map['Tax_Rate'],
      Tax_Amount: map['Tax_Amount'],
      Quantity_Full: map['Quantity_Full'],
      Quantity_Disc: map['Quantity_Disc'],
    );
  }

  String toJson() => json.encode(toMap());

  factory VoucherItemDetailHive.fromJson(String source) =>
      VoucherItemDetailHive.fromMap(json.decode(source));
}
