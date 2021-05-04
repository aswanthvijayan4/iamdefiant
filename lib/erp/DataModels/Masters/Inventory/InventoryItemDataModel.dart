import 'dart:convert';

import 'package:flutter/foundation.dart';
// import 'package:hive/hive.dart';

import 'package:authentication_with_bloc/erp/DataModels/Masters/UOM/UOMDataModel.dart';

final String TableName_InventoryItems = "Sales_Inventory_Items";

final String column_id = "_id";
final String column_Item_ID = "Item_ID";
final String column_Item_Name = "Item_Name";
final String column_Item_Alias = "Item_Alias";
final String column_Item_Code = "Item_Code";
final String column_Item_Group_Id = "Group_Id";
final String column_Item_Group_Name = "Group_Name";
final String column_Item_Part_Number = "Part_Number";
final String column_Item_Price = "Price";
final String column_Opening_Stock = "Opening_Stock";
final String column_Opening_Balance_Date = "Opening_Balance_Date";
final String column_Last_Modified_By = "Last_Modified_By";
final String column_Opening_Rate = "Opening_Rate";
final String column_Opening_Value = "Opening_Value";
final String column_Narration = "Narration";
final String column_Serial_Number = "Serial_Number";
final String column_Closing_Stock = "Closing_Stock";
final String column_Reorder_Level = "Reorder_Level";
final String column_Std_Cost = "Std_Cost";
final String column_Default_Sales_Ledger_id = "Default_Sales_Ledger_id";
final String column_Default_PurchaseLedger_id = "Default_PurchaseLedger_id";
final String column_Default_Input_Tax_Ledger = "Default_Input_Tax_Ledger";
final String column_Default_Output_Tax_Ledger = "Default_Output_Tax_Ledger";
final String column_Default_Sales_Return_Ledger = "Default_Sales_Return_Ledger";
final String column_Default_Purchase_Return_Ledger =
    "Default_Purchase_Return_Ledger";
final String column_Vat_Rate = "Vat_Rate";
final String column_Default_UOM_ID = "Default_UOM_ID";
final String column_Last_Modified = "Last_Modified";
final String column_Date_Created = "Date_Created";
final String column_Timestamp = "Timestamp";
final String column_Warranty_Days = "Warranty_Days";
final String column_Shelf_Life = "Shelf_Life";
final String column_Brand_Id = "Brand_Id";
final String column_Item_Description = "Item_Description";
final String column_isCustomItem = "isCustomItem";
final String column_Dimension = "Dimension";
final String column_isPurchaseItem = "isPurchaseItem";
final String column_isSalesItem = "isSalesItem";
final String column_KOT_Printer = "KOT_Printer";
final String column_Item_Name_Arabic = "Item_Name_Arabic";
final String column_Favourite = "Favourite";
final String column_IsStockItem = "IsStockItem";
final String column_From_Time = "From_Time";
final String column_To_Time = "To_Time";
final String column_Price_2 = "Price_2";
final String column_HSN_CODE = "HSN_CODE";
final String column_Section = "Section";
final String column_Flags = "Flags";
final String column_Category = "Category";
final String column_DefaultLedgerID = "DefaultLedgerID";

class InventoryItemDataModel {
  int id;
  String itemName;
  String itemNameArabic;
  String groupName;
  String groupID;
  String itemID = "";
  String itemAlias;
  String itemCode;
  String narration;
  double stdCost = 0;
  String dimension;
  double price = 0;
  double price_1 = 0;
  double price_2 = 0;
  double quantity = 0;
  double discount = 0;
  double discountinAmount = 0;
  double discountPercentage = 0;
  double subTotal = 0;
  double grandTotal = 0;
  double moq = 0;

  double currentQty = 0;

  var requirementItemIdOld = 0;
  String ItemReqUuid = "X";
  double maxQuantity = 99999;
  int listId = 0;

  String fromGodownID;
  String toGodownID;

  String PriceLevel;
  String PartNumber;
  String SerailNumber;
  double openingStock = 0;
  double closingStock = 0;
  var OpeningStockDate;
  double OpeningStockValue = 0;
  double OpeningStockPrice = 0;
  double ReorderLevel = 0;
  double discQuantity = 0;
  String defaultSalesLedgerID;
  String defaultPurchaseLedgerID;

  int brandID = 0;
  String brandName;

  double taxRate = 0;
  double taxAmount = 0;

  double itemCess = 0;

  int defaultUOMID;
  UOMDataModel uomObject;
  String priceListID;
  String priceListName;
  bool customItem;
  int lastModifiedBy;
  DateTime lastModified;
  DateTime dateCreated;
  DateTime fromTime;
  DateTime toTime;
  int createdBy;
  String itemDescription;
  double length = 1;
  int warrantyDays = 0;
  double shelfLife = 0;
  bool isCompoundItem = false;
  bool isCustomItem = false;
  bool isPurchaseItem = false;
  bool isSalesItem = false;

  bool favo = false;
  String kOTPrinter;

  int itemProductionStatus = 0;
  int itemVoucherStatus = 0;
  String defaultInputTaxLedgerID;
  String defaultOutputTaxLedgerID;
  String defaultSalesReturnLedgerID;
  String defaultPurchaseReturnLedgerID;

  double drQty = 0;
  double crQty = 0;
  double consumedQty = 0;

  // TO BE PREP
  String hsnCode;
  double prevQty = 0;
  String section;
  Map flags;
  String salesManId;

  bool fromExternal = false;
  int action;

  double calculatedQty = 0;
  double requestQty = 0;
  var orderCompletedDate;

  bool isStockItem = true;
  String category;
  String defaultLedgerId;
//  List<ItemFifoDataModel*> fifoList;

  InventoryItemDataModel({
    this.id,
    this.itemName = '',
    this.itemNameArabic = '',
    this.groupName = '',
    this.groupID = '',
    this.itemID = '',
    this.itemAlias,
    this.itemCode = '',
    this.narration = '',
    this.stdCost = 0,
    this.dimension,
    this.price = 0,
    this.price_1 = 0,
    this.price_2 = 0,
    this.quantity = 0,
    this.discount = 0,
    this.discountinAmount = 0,
    this.discountPercentage = 0,
    this.subTotal = 0,
    this.grandTotal = 0,
    this.moq,
    this.requirementItemIdOld,
    this.ItemReqUuid,
    this.maxQuantity,
    this.listId,
    this.fromGodownID,
    this.toGodownID,
    this.PriceLevel,
    this.PartNumber,
    this.SerailNumber,
    this.openingStock,
    this.closingStock,
    this.OpeningStockDate,
    this.OpeningStockValue,
    this.OpeningStockPrice,
    this.ReorderLevel,
    this.discQuantity,
    this.defaultSalesLedgerID,
    this.defaultPurchaseLedgerID,
    this.brandID,
    this.brandName,
    this.taxRate = 0,
    this.taxAmount = 0,
    this.defaultUOMID = 1,
    this.uomObject,
    this.priceListID,
    this.priceListName,
    this.customItem,
    this.lastModifiedBy,
    this.lastModified,
    this.dateCreated,
    this.fromTime,
    this.toTime,
    this.createdBy,
    this.itemDescription,
    this.length,
    this.warrantyDays,
    this.shelfLife,
    this.isCompoundItem,
    this.isCustomItem,
    this.isPurchaseItem,
    this.isSalesItem,
    this.favo,
    this.kOTPrinter,
    this.itemProductionStatus,
    this.itemVoucherStatus,
    this.defaultInputTaxLedgerID,
    this.defaultOutputTaxLedgerID,
    this.defaultSalesReturnLedgerID,
    this.defaultPurchaseReturnLedgerID,
    this.drQty = 0,
    this.crQty = 0,
    this.consumedQty,
    this.hsnCode,
    this.prevQty = 0,
    this.section,
    this.flags,
    this.salesManId,
    this.fromExternal,
    this.action,
    this.calculatedQty = 0,
    this.requestQty = 0,
    this.orderCompletedDate,
    this.isStockItem,
    this.category,
    this.defaultLedgerId,
  });

  InventoryItemDataModel.fromMapMaster(Map map) {
    id = map[column_id] as num;
    itemID = map[column_Item_ID];
    itemName = map[column_Item_Name];
    itemAlias = map[column_Item_Alias];
    itemCode = map[column_Item_Code];
    groupID = map[column_Item_Group_Id];
    groupName = map[column_Item_Group_Name];
    PartNumber = map[column_Item_Part_Number];
    price = map[column_Item_Price] as num;
    openingStock = map[column_Opening_Stock];
    OpeningStockDate = map[column_Opening_Balance_Date];
    lastModifiedBy = map[column_Last_Modified_By];
    OpeningStockPrice = map[column_Opening_Rate];
    OpeningStockValue = map[column_Opening_Value];
    narration = map[column_Narration];
    SerailNumber = map[column_Serial_Number];
    closingStock = map[column_Closing_Stock];
    ReorderLevel = map[column_Reorder_Level];
    stdCost = map[column_Std_Cost];
    defaultSalesLedgerID = map[column_Default_Sales_Ledger_id];
    defaultPurchaseLedgerID = map[column_Default_PurchaseLedger_id];
    defaultInputTaxLedgerID = map[column_Default_Input_Tax_Ledger];
    defaultOutputTaxLedgerID = map[column_Default_Output_Tax_Ledger];
    defaultSalesReturnLedgerID = map[column_Default_Sales_Return_Ledger];
    defaultPurchaseReturnLedgerID = map[column_Default_Purchase_Return_Ledger];
    taxRate = map[column_Vat_Rate];
    defaultUOMID = int.parse(map[column_Default_UOM_ID]);
    lastModified = DateTime.parse(map[column_Last_Modified] ?? '2000-01-01');
    dateCreated = DateTime.parse(map[column_Date_Created] ?? '2000-01-01');
    // timestamp = map[column_Timestamp];
    warrantyDays = map[column_Warranty_Days];
    shelfLife = map[column_Shelf_Life];
    // brandID = map[column_Brand_Id];
    itemDescription = map[column_Item_Description];
    isCustomItem = map[column_isCustomItem] == 1 ? true : false;
    dimension = map[column_Dimension];
    isPurchaseItem = map[column_isPurchaseItem] == 1 ? true : false;
    isSalesItem = map[column_isSalesItem] == 1 ? true : false;
    kOTPrinter = map[column_KOT_Printer];
    itemNameArabic = map[column_Item_Name_Arabic];
    favo = map[column_Favourite] == 1 ? true : false;
    isStockItem = map[column_IsStockItem] == 1 ? true : false;
    //fromTime = DateTime.parse(map[column_From_Time] ?? '00:00:00');
    //toTime = DateTime.parse(map[column_To_Time] ?? '23:59:59');
    price_2 = map[column_Price_2];
    hsnCode = map[column_HSN_CODE];
    section = map[column_Section];
    // flags = map[column_Flags] as Map;
    category = map[column_Category];
    defaultLedgerId = map[column_DefaultLedgerID];
  }

  Map<String, dynamic> toMapForMasterInsert() {
    Map<String, dynamic> map = {};
    return map;
  }

  Map<String, dynamic> toMapForTransTest() {
    return {
      'Item_ID': itemID,
      'drQty': drQty,
      'crQty': crQty,
      'Quantity': quantity,
      'Price': price,
      'SubTotal': 0,
      'Requirement_ItemID': 'X',
      'Vat_Rate': taxRate,
      'Vat_Amount': taxAmount
    };
  }

  factory InventoryItemDataModel.fromMapForTransTest(Map<String, dynamic> map) {
    if (map == null) return null;
    print(
        'Item  ID is being converted : $map at qty : ${map['Quantity']} total : ${map['Subtotal']}');
    return InventoryItemDataModel(
      itemID: map['Item_ID'],
      itemName: map['Item_Name'] ?? '',
      drQty: double.parse(map['drQty'] ?? '0'),
      crQty: double.parse(map['crQty'] ?? '0'),
      quantity: double.parse(map['Quantity'] ?? '0'),
      price: double.parse(map['Price'] ?? '0'),
      taxRate: double.parse(map['Vat_Rate'] ?? '0'),
      subTotal: double.parse(map['Subtotal'] ?? '0'),
      closingStock: double.parse(map['ClosingStock'] ?? '0'),
    );
  }

  String toJson() => json.encode(toMapForTransTest());

  factory InventoryItemDataModel.fromJson(String source) =>
      InventoryItemDataModel.fromMapForTransTest(json.decode(source));

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is InventoryItemDataModel &&
        o.itemName == itemName &&
        o.itemNameArabic == itemNameArabic &&
        o.groupName == groupName &&
        o.groupID == groupID &&
        o.itemID == itemID &&
        o.itemAlias == itemAlias &&
        o.itemCode == itemCode &&
        o.narration == narration &&
        o.stdCost == stdCost &&
        o.dimension == dimension &&
        o.price == price &&
        o.price_1 == price_1 &&
        o.price_2 == price_2 &&
        o.quantity == quantity &&
        o.discount == discount &&
        o.discountinAmount == discountinAmount &&
        o.discountPercentage == discountPercentage &&
        o.subTotal == subTotal &&
        o.grandTotal == grandTotal &&
        o.moq == moq &&
        o.requirementItemIdOld == requirementItemIdOld &&
        o.ItemReqUuid == ItemReqUuid &&
        o.maxQuantity == maxQuantity &&
        o.listId == listId &&
        o.fromGodownID == fromGodownID &&
        o.toGodownID == toGodownID &&
        o.PriceLevel == PriceLevel &&
        o.PartNumber == PartNumber &&
        o.SerailNumber == SerailNumber &&
        o.openingStock == openingStock &&
        o.closingStock == closingStock &&
        o.OpeningStockDate == OpeningStockDate &&
        o.OpeningStockValue == OpeningStockValue &&
        o.OpeningStockPrice == OpeningStockPrice &&
        o.ReorderLevel == ReorderLevel &&
        o.discQuantity == discQuantity &&
        o.defaultSalesLedgerID == defaultSalesLedgerID &&
        o.defaultPurchaseLedgerID == defaultPurchaseLedgerID &&
        o.brandID == brandID &&
        o.brandName == brandName &&
        o.taxRate == taxRate &&
        o.taxAmount == taxAmount &&
        o.defaultUOMID == defaultUOMID &&
        o.uomObject == uomObject &&
        o.priceListID == priceListID &&
        o.priceListName == priceListName &&
        o.customItem == customItem &&
        o.lastModifiedBy == lastModifiedBy &&
        o.lastModified == lastModified &&
        o.dateCreated == dateCreated &&
        o.fromTime == fromTime &&
        o.toTime == toTime &&
        o.createdBy == createdBy &&
        o.itemDescription == itemDescription &&
        o.length == length &&
        o.warrantyDays == warrantyDays &&
        o.shelfLife == shelfLife &&
        o.isCompoundItem == isCompoundItem &&
        o.isCustomItem == isCustomItem &&
        o.isPurchaseItem == isPurchaseItem &&
        o.isSalesItem == isSalesItem &&
        o.favo == favo &&
        o.kOTPrinter == kOTPrinter &&
        o.itemProductionStatus == itemProductionStatus &&
        o.itemVoucherStatus == itemVoucherStatus &&
        o.defaultInputTaxLedgerID == defaultInputTaxLedgerID &&
        o.defaultOutputTaxLedgerID == defaultOutputTaxLedgerID &&
        o.defaultSalesReturnLedgerID == defaultSalesReturnLedgerID &&
        o.defaultPurchaseReturnLedgerID == defaultPurchaseReturnLedgerID &&
        o.drQty == drQty &&
        o.crQty == crQty &&
        o.consumedQty == consumedQty &&
        o.hsnCode == hsnCode &&
        o.prevQty == prevQty &&
        o.section == section &&
        o.salesManId == salesManId &&
        o.fromExternal == fromExternal &&
        o.action == action &&
        o.calculatedQty == calculatedQty &&
        o.requestQty == requestQty &&
        o.orderCompletedDate == orderCompletedDate &&
        o.isStockItem == isStockItem &&
        o.category == category &&
        o.defaultLedgerId == defaultLedgerId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        itemName.hashCode ^
        itemNameArabic.hashCode ^
        groupName.hashCode ^
        groupID.hashCode ^
        itemID.hashCode ^
        itemAlias.hashCode ^
        itemCode.hashCode ^
        narration.hashCode ^
        stdCost.hashCode ^
        dimension.hashCode ^
        price.hashCode ^
        price_1.hashCode ^
        price_2.hashCode ^
        quantity.hashCode ^
        discount.hashCode ^
        discountinAmount.hashCode ^
        discountPercentage.hashCode ^
        subTotal.hashCode ^
        grandTotal.hashCode ^
        moq.hashCode ^
        requirementItemIdOld.hashCode ^
        ItemReqUuid.hashCode ^
        maxQuantity.hashCode ^
        listId.hashCode ^
        fromGodownID.hashCode ^
        toGodownID.hashCode ^
        PriceLevel.hashCode ^
        PartNumber.hashCode ^
        SerailNumber.hashCode ^
        openingStock.hashCode ^
        closingStock.hashCode ^
        OpeningStockDate.hashCode ^
        OpeningStockValue.hashCode ^
        OpeningStockPrice.hashCode ^
        ReorderLevel.hashCode ^
        discQuantity.hashCode ^
        defaultSalesLedgerID.hashCode ^
        defaultPurchaseLedgerID.hashCode ^
        brandID.hashCode ^
        brandName.hashCode ^
        taxRate.hashCode ^
        taxAmount.hashCode ^
        defaultUOMID.hashCode ^
        uomObject.hashCode ^
        priceListID.hashCode ^
        priceListName.hashCode ^
        customItem.hashCode ^
        lastModifiedBy.hashCode ^
        lastModified.hashCode ^
        dateCreated.hashCode ^
        fromTime.hashCode ^
        toTime.hashCode ^
        createdBy.hashCode ^
        itemDescription.hashCode ^
        length.hashCode ^
        warrantyDays.hashCode ^
        shelfLife.hashCode ^
        isCompoundItem.hashCode ^
        isCustomItem.hashCode ^
        isPurchaseItem.hashCode ^
        isSalesItem.hashCode ^
        favo.hashCode ^
        kOTPrinter.hashCode ^
        itemProductionStatus.hashCode ^
        itemVoucherStatus.hashCode ^
        defaultInputTaxLedgerID.hashCode ^
        defaultOutputTaxLedgerID.hashCode ^
        defaultSalesReturnLedgerID.hashCode ^
        defaultPurchaseReturnLedgerID.hashCode ^
        drQty.hashCode ^
        crQty.hashCode ^
        consumedQty.hashCode ^
        hsnCode.hashCode ^
        prevQty.hashCode ^
        section.hashCode ^
        flags.hashCode ^
        salesManId.hashCode ^
        fromExternal.hashCode ^
        action.hashCode ^
        calculatedQty.hashCode ^
        requestQty.hashCode ^
        orderCompletedDate.hashCode ^
        isStockItem.hashCode ^
        category.hashCode ^
        defaultLedgerId.hashCode;
  }
}
