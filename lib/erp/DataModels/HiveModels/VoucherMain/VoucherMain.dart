import 'dart:convert';

import 'package:hive/hive.dart';

import 'package:authentication_with_bloc/erp/DataModels/HiveModels/VoucherItemDetail/VoucherItemDetail.dart';
import 'package:authentication_with_bloc/erp/DataModels/HiveModels/VoucherLedgerDetail/VoucherLedgerDetail.dart';

part 'VoucherMain.g.dart';

@HiveType(typeId: 100)
class VoucherMainHive extends HiveObject {
  @HiveField(0)
  String Voucher_No;
  @HiveField(1)
  String Voucher_Prefix;
  @HiveField(2)
  DateTime Date_Created;
  @HiveField(3)
  DateTime Voucher_Date;
  @HiveField(4)
  DateTime TimeStamp;
  @HiveField(5)
  DateTime Last_Updated;
  @HiveField(6)
  String Ledger_ID;
  @HiveField(7)
  String Billing_Name;
  @HiveField(8)
  double Total;
  @HiveField(9)
  double Discount_in_Amount;
  @HiveField(10)
  double Discount_in_Percent;
  @HiveField(11)
  String Narration;
  @HiveField(12)
  String Added_By;
  @HiveField(13)
  DateTime delivery_date;
  @HiveField(14)
  double Completion_Probability;
  @HiveField(15)
  String Credit_Period;
  @HiveField(16)
  String POC_Name;
  @HiveField(17)
  String POC_Phone;
  @HiveField(18)
  String POC_Email;
  @HiveField(19)
  String Project_ID;
  @HiveField(20)
  String Revision_Number;
  @HiveField(21)
  String Converted_To_Sales_Order;
  @HiveField(22)
  bool Quotation_Dropped;
  @HiveField(23)
  String VoucherStatus;
  @HiveField(24)
  String Quotation_Dropped_Reason;
  @HiveField(25)
  String Requirement_Voucher_No;
  @HiveField(26)
  String Salesman_ID;
  @HiveField(27)
  String PaymentCompleted;
  @HiveField(28)
  String LPO_Ref;
  @HiveField(29)
  String MODE_OF_SERVICE;
  @HiveField(30)
  double Vat_Amount;
  @HiveField(31)
  double Gross_Total;
  @HiveField(32)
  int ContactID;
  @HiveField(33)
  String Reference;
  @HiveField(34)
  String Currency;
  @HiveField(35)
  int Boxes_Count;
  @HiveField(36)
  double Total_Weight;
  @HiveField(37)
  String LR_No;
  @HiveField(38)
  String Voucher_No_Display;
  @HiveField(39)
  String Requirement_Voucher_List;
  @HiveField(40)
  int Origin;
  @HiveField(41)
  double Round_Off;
  @HiveField(42)
  String TransactionId;
  @HiveField(43)
  DateTime Customer_Expected_Date;
  @HiveField(44)
  bool PaymentSplit;
  @HiveField(45)
  String From_Location;
  @HiveField(46)
  String To_Location;
  @HiveField(47)
  List<VoucherItemDetailHive> items;
  @HiveField(48)
  List<VoucherLedgerDetailHive> ledgers;
  VoucherMainHive({
    this.Voucher_No,
    this.Voucher_Prefix,
    this.Date_Created,
    this.Voucher_Date,
    this.TimeStamp,
    this.Last_Updated,
    this.Ledger_ID,
    this.Billing_Name,
    this.Total,
    this.Discount_in_Amount,
    this.Discount_in_Percent,
    this.Narration,
    this.Added_By,
    this.delivery_date,
    this.Completion_Probability,
    this.Credit_Period,
    this.POC_Name,
    this.POC_Phone,
    this.POC_Email,
    this.Project_ID,
    this.Revision_Number,
    this.Converted_To_Sales_Order,
    this.Quotation_Dropped,
    this.VoucherStatus,
    this.Quotation_Dropped_Reason,
    this.Requirement_Voucher_No,
    this.Salesman_ID,
    this.PaymentCompleted,
    this.LPO_Ref,
    this.MODE_OF_SERVICE,
    this.Vat_Amount,
    this.Gross_Total,
    this.ContactID,
    this.Reference,
    this.Currency,
    this.Boxes_Count,
    this.Total_Weight,
    this.LR_No,
    this.Voucher_No_Display,
    this.Requirement_Voucher_List,
    this.Origin,
    this.Round_Off,
    this.TransactionId,
    this.Customer_Expected_Date,
    this.PaymentSplit,
    this.From_Location,
    this.To_Location,
    this.items,
    this.ledgers,
  });

  Map<String, dynamic> toMap() {
    return {
      'Voucher_No': Voucher_No,
      'Voucher_Prefix': Voucher_Prefix,
      'Date_Created': Date_Created?.millisecondsSinceEpoch,
      'Voucher_Date': Voucher_Date?.millisecondsSinceEpoch,
      'TimeStamp': TimeStamp?.millisecondsSinceEpoch,
      'Last_Updated': Last_Updated?.millisecondsSinceEpoch,
      'Ledger_ID': Ledger_ID,
      'Billing_Name': Billing_Name,
      'Total': Total,
      'Discount_in_Amount': Discount_in_Amount,
      'Discount_in_Percent': Discount_in_Percent,
      'Narration': Narration,
      'Added_By': Added_By,
      'delivery_date': delivery_date?.millisecondsSinceEpoch,
      'Completion_Probability': Completion_Probability,
      'Credit_Period': Credit_Period,
      'POC_Name': POC_Name,
      'POC_Phone': POC_Phone,
      'POC_Email': POC_Email,
      'Project_ID': Project_ID,
      'Revision_Number': Revision_Number,
      'Converted_To_Sales_Order': Converted_To_Sales_Order,
      'Quotation_Dropped': Quotation_Dropped,
      'VoucherStatus': VoucherStatus,
      'Quotation_Dropped_Reason': Quotation_Dropped_Reason,
      'Requirement_Voucher_No': Requirement_Voucher_No,
      'Salesman_ID': Salesman_ID,
      'PaymentCompleted': PaymentCompleted,
      'LPO_Ref': LPO_Ref,
      'MODE_OF_SERVICE': MODE_OF_SERVICE,
      'Vat_Amount': Vat_Amount,
      'Gross_Total': Gross_Total,
      'ContactID': ContactID,
      'Reference': Reference,
      'Currency': Currency,
      'Boxes_Count': Boxes_Count,
      'Total_Weight': Total_Weight,
      'LR_No': LR_No,
      'Voucher_No_Display': Voucher_No_Display,
      'Requirement_Voucher_List': Requirement_Voucher_List,
      'Origin': Origin,
      'Round_Off': Round_Off,
      'TransactionId': TransactionId,
      'Customer_Expected_Date': Customer_Expected_Date?.millisecondsSinceEpoch,
      'PaymentSplit': PaymentSplit,
      'From_Location': From_Location,
      'To_Location': To_Location,
      'items': items?.map((x) => x?.toMap())?.toList(),
      'ledgers': ledgers?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory VoucherMainHive.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return VoucherMainHive(
      Voucher_No: map['Voucher_No'],
      Voucher_Prefix: map['Voucher_Prefix'],
      Date_Created: DateTime.fromMillisecondsSinceEpoch(map['Date_Created']),
      Voucher_Date: DateTime.fromMillisecondsSinceEpoch(map['Voucher_Date']),
      TimeStamp: DateTime.fromMillisecondsSinceEpoch(map['TimeStamp']),
      Last_Updated: DateTime.fromMillisecondsSinceEpoch(map['Last_Updated']),
      Ledger_ID: map['Ledger_ID'],
      Billing_Name: map['Billing_Name'],
      Total: map['Total'],
      Discount_in_Amount: map['Discount_in_Amount'],
      Discount_in_Percent: map['Discount_in_Percent'],
      Narration: map['Narration'],
      Added_By: map['Added_By'],
      delivery_date: DateTime.fromMillisecondsSinceEpoch(map['delivery_date']),
      Completion_Probability: map['Completion_Probability'],
      Credit_Period: map['Credit_Period'],
      POC_Name: map['POC_Name'],
      POC_Phone: map['POC_Phone'],
      POC_Email: map['POC_Email'],
      Project_ID: map['Project_ID'],
      Revision_Number: map['Revision_Number'],
      Converted_To_Sales_Order: map['Converted_To_Sales_Order'],
      Quotation_Dropped: map['Quotation_Dropped'],
      VoucherStatus: map['VoucherStatus'],
      Quotation_Dropped_Reason: map['Quotation_Dropped_Reason'],
      Requirement_Voucher_No: map['Requirement_Voucher_No'],
      Salesman_ID: map['Salesman_ID'],
      PaymentCompleted: map['PaymentCompleted'],
      LPO_Ref: map['LPO_Ref'],
      MODE_OF_SERVICE: map['MODE_OF_SERVICE'],
      Vat_Amount: map['Vat_Amount'],
      Gross_Total: map['Gross_Total'],
      ContactID: map['ContactID'],
      Reference: map['Reference'],
      Currency: map['Currency'],
      Boxes_Count: map['Boxes_Count'],
      Total_Weight: map['Total_Weight'],
      LR_No: map['LR_No'],
      Voucher_No_Display: map['Voucher_No_Display'],
      Requirement_Voucher_List: map['Requirement_Voucher_List'],
      Origin: map['Origin'],
      Round_Off: map['Round_Off'],
      TransactionId: map['TransactionId'],
      Customer_Expected_Date:
          DateTime.fromMillisecondsSinceEpoch(map['Customer_Expected_Date']),
      PaymentSplit: map['PaymentSplit'],
      From_Location: map['From_Location'],
      To_Location: map['To_Location'],
      items: List<VoucherItemDetailHive>.from(
          map['items']?.map((x) => VoucherItemDetailHive.fromMap(x))),
      ledgers: List<VoucherLedgerDetailHive>.from(
          map['ledgers']?.map((x) => VoucherLedgerDetailHive.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory VoucherMainHive.fromJson(String source) =>
      VoucherMainHive.fromMap(json.decode(source));
}
