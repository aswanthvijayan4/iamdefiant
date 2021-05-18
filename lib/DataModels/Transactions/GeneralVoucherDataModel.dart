import 'dart:convert';

import 'package:authentication_with_bloc/DataModels/Masters/Accounts/LedgerMasterDataModel.dart';
import 'package:authentication_with_bloc/DataModels/Masters/Inventory/CompoundItemDataModel.dart';
import 'package:authentication_with_bloc/DataModels/Masters/Inventory/InventoryItemDataModel.dart';
import 'package:authentication_with_bloc/Utils/Extensions/DoubleExtensions.dart';

class GeneralVoucherDataModel {
  String displayVoucherNumber;

  String voucherNumber;
  DateTime voucherDate;
  String voucherPrefix;
  String invoiceNumber;
  DateTime invoiceDate;
  DateTime dateCreated;
  DateTime timestamp;
  DateTime lastEditedDateTime;

  LedgerMasterDataModel ledgerObject = LedgerMasterDataModel();
  List<CompoundItemDataModel> InventoryItems = List<CompoundItemDataModel>();
  List<InventoryItemDataModel> deletedItems = List<InventoryItemDataModel>();
  List<LedgerMasterDataModel> ledgersList = List<LedgerMasterDataModel>();
  String narration;
  String priceListId;
  String priceListName;

  double discount = 0;
  double discountPercent = 0;

  double subTotal = 0;
  double grossTotal = 0;
  double discountinAmount = 0;
  double grandTotal = 0;
  double taxTotalAmount = 0;
  double otherLedgersTotal = 0;
  double cessAmount = 0;

  double currencyConversionRate = 1;
  String currency;
  String ProjectId;
  String AddedBy;
  int AddedById = 0;
  DateTime DeliveryDate;
  double CompletionProbability = 100;
  int CreditPeriod = 0;

  int RevisionNo = 0;
  String ConvertedToSalesOrder = "";
  bool QuotationPrepared;
  bool QuotationDropped;
  String QuotationDroppedReason;
  int SalesmanID = 0;
  String TermsAndConditionsID;
  String RequirementVoucherNo;

  var Contact;

  String LPO = "";
  String BillingName;

  String prevTransVouchers = "";
  double roundOff = 0;

  int status = 10;

  String voucherType;

  bool ManagerApprovalStatus = false;
  bool ClientApprovalStatus = false;

  int Pax = 0;
  int NoOfCopies = 0;
  int ModeOfService = 0;

  double quantityTotal = 0;

  double balanceAmount = 0;
  double paidAmount = 0;

  String reference;
  String Location;
  String POCName;
  String POCEmail;
  String POCPhone;
  String kotNumber;

  bool BillSplit = false;
  bool paymentSplit = false;

  double cashPaid = 0;
  double balance = 0;

  String fromGodownName, toGodownName;
//  QList<BillwiseRecordDataModel*> mapList;
//  ChequeDetail chequeEntry;

  double crTotal = 0;
  double drTotal = 0;
  double ledgersTotal = 0;
  bool fromExternal = false;
  bool sendFlag = false;
  bool voucherToExport = false;
  String TransactionId;

  int action;

  var CustomerExpectingDate;

  // NOT DONE
  String LRNO;
  int numBoxes = 0;
  double totalWeight = 0;
  int Origin = 0;
//    String Currency;
  int currencyDecimalPoints = 2;
  var ReqVoucherList;

  GeneralVoucherDataModel({
    this.displayVoucherNumber,
    this.voucherNumber,
    this.voucherDate,
    this.voucherPrefix,
    this.invoiceNumber,
    this.invoiceDate,
    this.dateCreated,
    this.timestamp,
    this.lastEditedDateTime,
    this.ledgerObject,
    this.InventoryItems,
    this.deletedItems,
    this.ledgersList,
    this.narration,
    this.priceListId,
    this.priceListName,
    this.discount,
    this.discountPercent,
    this.subTotal,
    this.grossTotal,
    this.discountinAmount,
    this.grandTotal,
    this.taxTotalAmount,
    this.otherLedgersTotal,
    this.cessAmount,
    this.currencyConversionRate,
    this.currency,
    this.ProjectId,
    this.AddedBy,
    this.AddedById,
    this.DeliveryDate,
    this.CompletionProbability,
    this.CreditPeriod,
    this.RevisionNo,
    this.ConvertedToSalesOrder,
    this.QuotationPrepared,
    this.QuotationDropped,
    this.QuotationDroppedReason,
    this.SalesmanID,
    this.TermsAndConditionsID,
    this.RequirementVoucherNo,
    this.Contact,
    this.LPO,
    this.BillingName,
    this.prevTransVouchers,
    this.roundOff,
    this.status,
    this.voucherType,
    this.ManagerApprovalStatus,
    this.ClientApprovalStatus,
    this.Pax,
    this.NoOfCopies,
    this.ModeOfService,
    this.quantityTotal,
    this.balanceAmount,
    this.paidAmount,
    this.reference,
    this.Location,
    this.POCName,
    this.POCEmail,
    this.POCPhone,
    this.kotNumber,
    this.BillSplit,
    this.paymentSplit,
    this.cashPaid,
    this.balance,
    this.toGodownName,
    this.crTotal,
    this.drTotal,
    this.ledgersTotal,
    this.fromExternal,
    this.sendFlag,
    this.voucherToExport,
    this.TransactionId,
    this.action,
    this.CustomerExpectingDate,
    this.LRNO,
    this.numBoxes,
    this.totalWeight,
    this.Origin,
    this.currencyDecimalPoints,
    this.ReqVoucherList,
  });

  GeneralVoucherDataModel.fromMapOLD(Map map) {
    //E_Id=map[columnEmployeeId];

    displayVoucherNumber = map["_DisplayVoucherNumber"];
    voucherNumber = map["Voucher_No"];

    voucherDate = map["Voucher_Date"];
    dateCreated = map["Date_Created"];
    voucherPrefix = map["Voucher_Prefix"];
    invoiceNumber = map["invoiceNumber"];
    invoiceDate = map["invoiceDate"];
    timestamp = map["Timestamp"];
    lastEditedDateTime = map["lastEditedDateTime"];
    ledgerObject = LedgerMasterDataModel.fromMap(map["ledgerObject"]);

//    QJsonArray InventoryItemsJArray = map["InventoryItems"].toArray();
//    for(QJsonValue invItem:InventoryItemsJArray)    {
//      InventoryItems.append(c.JsonToObj(invItem.toObject()));
//    }

//    QJsonArray ledgersJArray = map["ledgersList"].toArray();
//    for(QJsonValue led:ledgersJArray){
//      ledgersList.append(l.JsonToObj(led.toObject()));
//    }

    //  LedgerMasterDataModel.fromMap();
    var iList = map["InventoryItems"] as List;
    InventoryItems =
        iList.map((e) => CompoundItemDataModel.fromMap(e)).toList();
    var list = map["ledgersList"] as List;
    ledgersList = list.map((i) => LedgerMasterDataModel.fromMap(i)).toList();

    narration = map["Narration"];
    priceListId = map["priceListId"];
    priceListName = map["priceListName"];
    discount = map["discount"];
    discountPercent = map["discountPercent"];
    subTotal = map["subTotal"];
    grossTotal = map["grossTotal"];
    discountinAmount = map["discountinAmount"];
    grandTotal = map["grandTotal"];
    taxTotalAmount = map["taxTotalAmount"];
    otherLedgersTotal = map["otherLedgersTotal"];
    currencyConversionRate = map["currencyConversionRate"];
    currency = map["currency"];
    ProjectId = map["Project_ID"];
    AddedBy = map["AddedBy"];
    AddedById = map["AddedById"].toInt();
    DeliveryDate = map["DeliveryDate"];
    CompletionProbability = map["CompletionProbability"];
    RevisionNo = map["RevisionNo"].toInt();
    ConvertedToSalesOrder = map["ConvertedToSalesOrder"];
    QuotationPrepared = map["QuotationPrepared"];
    QuotationDropped = map["QuotationDropped"];
    QuotationDroppedReason = map["QuotationDroppedReason"];
    SalesmanID = map["Salesman_ID"].toInt();
    TermsAndConditionsID = map["TermsAndConditionsID"];
    RequirementVoucherNo = map["RequirementVoucherNo"];
    //AddressBookDataModel a;
//    Contact = a.JsonToObj(map["Contact"].toObject());
    LPO = map["LPO"];
    BillingName = map["BillingName"];
    prevTransVouchers = map["prevTransVouchers"];
    roundOff = map["roundOff"];
    status = map["status"].toInt();
    voucherType = map["Voucher_Type"];
    ManagerApprovalStatus = map["ManagerApprovalStatus"];
    ClientApprovalStatus = map["ClientApprovalStatus"];
    Pax = map["Pax"].toInt();
    NoOfCopies = map["NoOfCopies"].toInt();
    ModeOfService = map["ModeOfService"].toInt();
    quantityTotal = map["quantityTotal"];
    balanceAmount = map["BalanceAmount"];
    paidAmount = map["PaidAmount"];
    reference = map["reference"];
    Location = map["Location"];
    POCName = map["POCName"];
    POCEmail = map["POCEmail"];
    POCPhone = map["POCPhone"];
    kotNumber = map["kotNumber"];
    BillSplit = map["BillSplit"];
    paymentSplit = map["paymentSplit"];
    cashPaid = map["cashPaid"];
    balance = map["balance"];
    toGodownName = map["toGodownName"];
    fromGodownName = map["fromGodownName"];
    TransactionId = map["TransactionId"];
    fromExternal = true;
  }

  Map<String, dynamic> toMapForTransTest() {
    return {
      'Voucher_Date': voucherDate?.millisecondsSinceEpoch,
      'Voucher_Prefix': voucherPrefix,
      'Voucher_Type': voucherType,
      'Voucher_No': voucherNumber ?? '',
      'Narration': narration,
      'reference': reference,
      'InventoryItems':
          InventoryItems.map((e) => e.toMapForTransTest()).toList(),
      'ledgerObject': ledgerObject.toMapForTransTest(),
      'ledgersList': ledgersList.map((e) => e.toMapForTransTest()).toList(),
    };
  }

  factory GeneralVoucherDataModel.fromMapForTransTest(
      Map<String, dynamic> map) {
    print('voucher : $map');

    print(
        'Date is HERE : ${map['Voucher_Date']} as ${DateTime.fromMillisecondsSinceEpoch(int.parse(map['Voucher_Date'] ?? '0'))}');
    DateTime vDate = DateTime.fromMillisecondsSinceEpoch(
        int.parse(map['Voucher_Date'] ?? '0') * 1000);

    print(
        'Timestamp  is HERE : ${map['TimeStamp']} as ${DateTime.fromMillisecondsSinceEpoch(int.parse(map['TimeStamp'] ?? '0'))}');

    print(vDate);
    if (map == null) return null;
    return GeneralVoucherDataModel(
      voucherNumber: map['Voucher_No'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(
          int.parse(map['TimeStamp'] ?? '0') * 1000),
      voucherDate: vDate, //DateTime.parse(map['Voucher_Date']),
      //DateTime.fromMillisecondsSinceEpoch(map['Voucher_Date']),
      voucherPrefix: map['Voucher_Prefix'],
      InventoryItems: List<CompoundItemDataModel>.from(
        map['InventoryItems']?.map(
          (x) => CompoundItemDataModel.fromMapForTransTest(x),
        ),
      ),
      narration: map['Narration'],
      voucherType: map['Voucher_Type'],
      grandTotal: double.parse(map['grandTotal'] ?? "0"),
      // ledgerObject: LedgerMasterDataModel.fromMapGen(map['ledgerObject'] ?? ''),
      // ledgersList: List<LedgerMasterDataModel>.from(
      //   map['ledgersList']?.map(
      //     (x) => LedgerMasterDataModel.fromMapGen(x),
      //   ),
      // ),
    );
  }

  String toJson() => json.encode(toMapForTransTest());

  factory GeneralVoucherDataModel.fromJson(String source) =>
      GeneralVoucherDataModel.fromMapForTransTest(json.decode(source));

  num getItemCount(String itemID) {
    int count = 0;
    InventoryItems.forEach((element) {
      if (element.BaseItem.itemID == itemID) {
        count += element.BaseItem.quantity.toInt();
      }
    });
    return count;
  }

  void calculateVoucherSales() {
    subTotal = 0;
    taxTotalAmount = 0;
    discountinAmount = 0;
    grossTotal = 0;
    cessAmount = 0;
    quantityTotal = 0;
    Map<String, double> ledgersListTemp = Map();

    for (int i = 0; i < InventoryItems.length; i++) {
      double vatAmt = 0;
      double taxRate = 0;
      double subT = 0;
      double grandTotolItem = 0;
      double itemCess = 0;
      quantityTotal += InventoryItems[i].BaseItem.quantity;

      taxRate = InventoryItems[i].BaseItem.taxRate;
      print('TaxRate : $taxRate');
      //        subT = InventoryItems[i].BaseItem.price *InventoryItems[i].BaseItem.quantity ;
      subT = (InventoryItems[i].BaseItem.price) *
          InventoryItems[i].BaseItem.quantity;
      grandTotolItem = subT - InventoryItems[i].BaseItem.discountinAmount;

      if (taxRate >= 0) vatAmt = grandTotolItem * taxRate / 100;

      if (taxRate > 5 && ledgerObject?.tRN?.length < 3) {
        itemCess = grandTotolItem * 1 / 100;
        cessAmount += itemCess;
      }

      subTotal += subT;
      grossTotal += grandTotolItem;
      taxTotalAmount += vatAmt;
      discountinAmount += InventoryItems[i].BaseItem.discountinAmount;

      String SalesLedger = "";
      String CGSTLedger = "";
      String SGSTLedger = "";

      if (taxRate == 0) {
        SalesLedger = "0x7x3";
      } else if (taxRate == 5) {
        SalesLedger = "0x7xSV5";
        CGSTLedger = "0x2x14xOCG25";
        SGSTLedger = "0x2x14xOSG25";
      } else if (taxRate == 12) {
        SalesLedger = "0x7xSV12";
        CGSTLedger = "0x2x14xOCG6";
        SGSTLedger = "0x2x14xOSG6";
      } else if (taxRate == 18) {
        SalesLedger = "0x7xSV18";
        CGSTLedger = "0x2x14xOCG9";
        SGSTLedger = "0x2x14xOSG9";
      } else if (taxRate == 28) {
        SalesLedger = "0x7xSV28";
        CGSTLedger = "0x2x14xOCG14";
        SGSTLedger = "0x2x14xOSG14";
      }

      //Sales Ledgers

      if (ledgersListTemp.keys.contains(SalesLedger)) {
        ledgersListTemp[SalesLedger] += grandTotolItem;
      } else {
        if (SalesLedger.length > 0)
          ledgersListTemp[SalesLedger] = grandTotolItem;
      }

      //CGST
      if (ledgersListTemp.keys.contains(CGSTLedger)) {
        ledgersListTemp[CGSTLedger] += vatAmt / 2;
      } else {
        if (CGSTLedger.length > 0) ledgersListTemp[CGSTLedger] = vatAmt / 2;
      }

      //SGST
      if (ledgersListTemp.keys.contains(SGSTLedger)) {
        ledgersListTemp[SGSTLedger] += vatAmt / 2;
      } else {
        if (SGSTLedger.length > 0) ledgersListTemp[SGSTLedger] = vatAmt / 2;
      }

      InventoryItems[i].BaseItem.itemCess = itemCess;
      InventoryItems[i].BaseItem.subTotal = subT; //+vatAmt;
      InventoryItems[i].BaseItem.taxAmount = vatAmt;
      InventoryItems[i].BaseItem.grandTotal =
          grandTotolItem + vatAmt + itemCess;
    }

    print('Outside items Loop ');

    // subTotal = subTotal;
    grossTotal = subTotal - discountinAmount;
    grandTotal = grossTotal + taxTotalAmount + cessAmount;

    if (cessAmount > 0 && ledgerObject.tRN.length < 1) {
      ledgersListTemp["0x2x14xCess"] = cessAmount;
    }

    if (ledgersList != null)
      for (int i = 0; i < ledgersList.length; i++) {
        if (ledgersList[i].isInvoiceItem) {
          ledgersList.removeAt(i);
          i--;
        }
      }

    if (paymentSplit == false)
      for (int i = 0; i < ledgersList.length; i++) {
        print('i =$i');
        //            qDebug()<<" Total : "<<voucher->grandTotal << "Cr : "<<voucher->ledgersList[i].crAmount << "Dr : "<<voucher->ledgersList[i].drAmount;
        grandTotal += ledgersList[i].crAmount - ledgersList[i].drAmount;
      }

    // QMapIterator<String,double>iterator(ledgersListTemp);

    // LedgerMasterDatabaseHelper ledHelper;

    ledgersListTemp.forEach((key, value) {
      LedgerMasterDataModel ledger = LedgerMasterDataModel();
      ledger.crAmount = value;
      ledger.amount = value;
      ledger.LedgerID = key;
      ledger.isInvoiceItem = true;
      // ledger.LedgerName = ledHelper.getLedgerNameByID(ledger.LedgerID);
      ledgersList.add(ledger);
    });
    print('Total = $grandTotal');
    double round = grandTotal.roundToOne;
    print('Round = $round');

    roundOff = round - grandTotal;

    //    qDebug()<<"Round off : "<<voucher->roundOff << "Total : "<<voucher->grandTotal;

    LedgerMasterDataModel roundledger = LedgerMasterDataModel();

    if (roundOff > 0) {
      roundledger.crAmount = roundOff;
    } else {
      roundledger.drAmount = -roundOff;
    }

    roundledger.LedgerID = "0x12x11";

    roundledger.isInvoiceItem = true;

    if (roundOff != 0) {
      print('496');
      roundledger.amount = roundOff;
      roundledger.LedgerName = "Round Off";
      ledgersList.add(roundledger);
      grandTotal += roundOff;
    }

    ledgerObject.crAmount = grandTotal;
  }
}
