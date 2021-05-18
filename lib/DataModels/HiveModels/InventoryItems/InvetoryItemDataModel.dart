import 'dart:convert';

import 'package:hive/hive.dart';

part 'InvetoryItemDataModel.g.dart';

@HiveType(typeId: 11)
class InventoryItemHive extends HiveObject {
  @HiveField(0)
  String Item_ID;
  @HiveField(1)
  String Item_Name;
  @HiveField(2)
  String Item_Alias;
  @HiveField(3)
  String Item_Code;
  @HiveField(4)
  String Group_Id;
  @HiveField(5)
  String Part_Number;
  @HiveField(6)
  double Price;
  @HiveField(7)
  double Opening_Stock;
  @HiveField(8)
  double Opening_Balance;
  @HiveField(9)
  DateTime Opening_Balance_Date;
  @HiveField(10)
  String Last_Modified_By;
  @HiveField(11)
  double Opening_Rate;
  @HiveField(12)
  double Opening_Value;
  @HiveField(13)
  String Narration;
  @HiveField(14)
  String Serial_Number;
  @HiveField(15)
  double Closing_Stock;
  @HiveField(16)
  double Reorder_Level;
  @HiveField(17)
  double Std_Cost;
  @HiveField(18)
  double Vat_Rate;
  @HiveField(19)
  int Default_UOM_ID;
  @HiveField(20)
  DateTime Last_Modified;
  @HiveField(21)
  DateTime Date_Created;
  @HiveField(22)
  DateTime Timestamp;
  @HiveField(23)
  int Warranty_Days;
  @HiveField(24)
  double Shelf_Life;
  @HiveField(25)
  String Brand_Id;
  @HiveField(26)
  String Item_Description;
  @HiveField(27)
  bool isCustomItem;
  @HiveField(28)
  String Dimension;
  @HiveField(29)
  bool isPurchaseItem;
  @HiveField(30)
  bool isSalesItem;
  @HiveField(31)
  String KOT_Printer;
  @HiveField(32)
  String Item_Name_Arabic;
  @HiveField(33)
  bool Favourite;
  @HiveField(34)
  bool IsStockItem;
  @HiveField(35)
  DateTime From_Time;
  @HiveField(36)
  DateTime To_Time;
  @HiveField(37)
  double Price_2;
  @HiveField(38)
  String HSN_CODE;
  @HiveField(39)
  String Section;
  @HiveField(40)
  String Flags;
  @HiveField(41)
  String Category;
  @HiveField(42)
  String DefaultLedgerID;

  InventoryItemHive({
    this.Item_ID,
    this.Item_Name,
    this.Item_Alias,
    this.Item_Code,
    this.Group_Id,
    this.Part_Number,
    this.Price,
    this.Opening_Stock,
    this.Opening_Balance,
    this.Opening_Balance_Date,
    this.Last_Modified_By,
    this.Opening_Rate,
    this.Opening_Value,
    this.Narration,
    this.Serial_Number,
    this.Closing_Stock,
    this.Reorder_Level,
    this.Std_Cost,
    this.Vat_Rate,
    this.Default_UOM_ID,
    this.Last_Modified,
    this.Date_Created,
    this.Timestamp,
    this.Warranty_Days,
    this.Shelf_Life,
    this.Brand_Id,
    this.Item_Description,
    this.isCustomItem,
    this.Dimension,
    this.isPurchaseItem,
    this.isSalesItem,
    this.KOT_Printer,
    this.Item_Name_Arabic,
    this.Favourite,
    this.IsStockItem,
    this.From_Time,
    this.To_Time,
    this.Price_2,
    this.HSN_CODE,
    this.Section,
    this.Flags,
    this.Category,
    this.DefaultLedgerID,
  });

  Map<String, dynamic> toMap() {
    return {
      'Item_ID': Item_ID,
      'Item_Name': Item_Name,
      'Item_Alias': Item_Alias,
      'Item_Code': Item_Code,
      'Group_Id': Group_Id,
      'Part_Number': Part_Number,
      'Price': Price,
      'Opening_Stock': Opening_Stock,
      'Opening_Balance': Opening_Balance,
      'Opening_Balance_Date': Opening_Balance_Date?.millisecondsSinceEpoch,
      'Last_Modified_By': Last_Modified_By,
      'Opening_Rate': Opening_Rate,
      'Opening_Value': Opening_Value,
      'Narration': Narration,
      'Serial_Number': Serial_Number,
      'Closing_Stock': Closing_Stock,
      'Reorder_Level': Reorder_Level,
      'Std_Cost': Std_Cost,
      'Vat_Rate': Vat_Rate,
      'Default_UOM_ID': Default_UOM_ID,
      'Last_Modified': Last_Modified?.millisecondsSinceEpoch,
      'Date_Created': Date_Created?.millisecondsSinceEpoch,
      'Timestamp': Timestamp?.millisecondsSinceEpoch,
      'Warranty_Days': Warranty_Days,
      'Shelf_Life': Shelf_Life,
      'Brand_Id': Brand_Id,
      'Item_Description': Item_Description,
      'isCustomItem': isCustomItem,
      'Dimension': Dimension,
      'isPurchaseItem': isPurchaseItem,
      'isSalesItem': isSalesItem,
      'KOT_Printer': KOT_Printer,
      'Item_Name_Arabic': Item_Name_Arabic,
      'Favourite': Favourite,
      'IsStockItem': IsStockItem,
      'From_Time': From_Time?.millisecondsSinceEpoch,
      'To_Time': To_Time?.millisecondsSinceEpoch,
      'Price_2': Price_2,
      'HSN_CODE': HSN_CODE,
      'Section': Section,
      'Flags': Flags,
      'Category': Category,
      'DefaultLedgerID': DefaultLedgerID,
    };
  }

  factory InventoryItemHive.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return InventoryItemHive(
      Item_ID: map['Item_ID'] ?? "",
      Item_Name: map['Item_Name'],
      Item_Alias: map['Item_Alias'],
      Item_Code: map['Item_Code'],
      Group_Id: map['Group_Id'],
      Part_Number: map['Part_Number'],
      Price: double.parse(map['Price'] ?? "0"),
      Opening_Stock: double.parse(map['Opening_Stock'] ?? "0"),
      Opening_Balance: double.parse(map['Opening_Balance'] ?? "0"),
      // Opening_Balance_Date:
      //     DateTime.fromMillisecondsSinceEpoch(map['Opening_Balance_Date']),
      Last_Modified_By: map['Last_Modified_By'],
      Opening_Rate: double.parse(map['Opening_Rate'] ?? "0"),
      Opening_Value: double.parse(map['Opening_Value'] ?? "0"),
      Narration: map['Narration'],
      Serial_Number: map['Serial_Number'],
      Closing_Stock: double.parse(map['Closing_Stock'] ?? "0"),
      Reorder_Level: double.parse(map['Reorder_Level'] ?? "0"),
      Std_Cost: double.parse(map['Std_Cost'] ?? "0"),
      Vat_Rate: double.parse(map['Vat_Rate'] ?? "0"),
      Default_UOM_ID: int.parse(map['Default_UOM_ID'] ?? "1"),
      // Last_Modified: DateTime.fromMillisecondsSinceEpoch(map['Last_Modified']),
      // Date_Created: DateTime.fromMillisecondsSinceEpoch(map['Date_Created']),
      // Timestamp: DateTime.fromMillisecondsSinceEpoch(map['Timestamp']),
      // Warranty_Days: int.parse(['Warranty_Days'] ?? "0"),
      // Shelf_Life: double.parse(map['Shelf_Life'] ?? "0"),
      // Brand_Id: map['Brand_Id'],
      // Item_Description: map['Item_Description'],
      // isCustomItem: map['isCustomItem'],
      // Dimension: map['Dimension'],
      // isPurchaseItem: map['isPurchaseItem'],
      // isSalesItem: map['isSalesItem'],
      // KOT_Printer: map['KOT_Printer'],
      // Item_Name_Arabic: map['Item_Name_Arabic'],
      // Favourite: map['Favourite'],
      // IsStockItem: map['IsStockItem'],
      // // From_Time: DateTime.fromMillisecondsSinceEpoch(map['From_Time']),
      // // To_Time: DateTime.fromMillisecondsSinceEpoch(map['To_Time']),
      // Price_2: double.parse(map['Price_2'] ?? "0"),
      // HSN_CODE: map['HSN_CODE'],
      // Section: map['Section'],
      // // Flags: map['Flags'],
      // Category: map['Category'],
      // DefaultLedgerID: map['DefaultLedgerID'],
    );
  }

  String toJson() => json.encode(toMap());

  factory InventoryItemHive.fromJson(String source) =>
      InventoryItemHive.fromMap(json.decode(source));
}
