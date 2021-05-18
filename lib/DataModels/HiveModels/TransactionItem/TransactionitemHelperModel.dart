import 'dart:convert';

import 'package:hive/hive.dart';

part 'TransactionitemHelperModel.g.dart';

@HiveType(typeId: 2)
class TransactionItemModel extends HiveObject {
  @HiveField(0)
  String itemID;
  @HiveField(1)
  String fromLedger;
  @HiveField(2)
  String toLedger;
  @HiveField(3)
  String voucherID;
  @HiveField(4)
  String voucherPrefix;
  @HiveField(5)
  String voucherDate;
  @HiveField(6)
  String voucherType;
  @HiveField(7)
  String fromLocation;
  @HiveField(8)
  String toLocation;
  @HiveField(9)
  double crQty;
  @HiveField(10)
  double drQty;
  @HiveField(11)
  double crAmount;
  @HiveField(12)
  double drAmount;
  @HiveField(13)
  String narration;
  @HiveField(14)
  DateTime vtime;
  @HiveField(15)
  String requirementItemID;
  @HiveField(16)
  double price;
  @HiveField(17)
  double consumed;
  @HiveField(18)
  String consumedReqId;
  @HiveField(19)
  String batchID;

  TransactionItemModel({
    this.itemID,
    this.fromLedger,
    this.toLedger,
    this.voucherID,
    this.voucherPrefix,
    this.voucherDate,
    this.voucherType,
    this.fromLocation,
    this.toLocation,
    this.crQty,
    this.drQty,
    this.crAmount,
    this.drAmount,
    this.narration,
    this.vtime,
    this.requirementItemID,
    this.price,
    this.consumed,
    this.consumedReqId,
    this.batchID,
  });

  Map<String, dynamic> toMap() {
    return {
      'ItemID': itemID,
      'From_Ledger': fromLedger,
      'To_Ledger': toLedger,
      'VoucherID': voucherID,
      'VoucherPrefix': voucherPrefix,
      'VoucherDate': voucherDate,
      'VoucherType': voucherType,
      'From_Location:': fromLocation,
      'To_Location': toLocation,
      'Cr_Qty': crQty,
      'Dr_Qty': drQty,
      'Cr_Amount': crAmount,
      'Dr_Amount': drAmount,
      'Narration': narration,
      'Time': vtime?.millisecondsSinceEpoch,
      'Requirement_ItemID': requirementItemID,
      'Price': price,
      'Consumed': consumed,
      'Consumed_ReqId': consumedReqId,
      'batchID': batchID,
    };
  }

  factory TransactionItemModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return TransactionItemModel(
      itemID: map['ItemID'],
      fromLedger: map['From_Ledger'],
      toLedger: map['To_Ledger'],
      voucherID: map['VoucherID'],
      voucherPrefix: map['VoucherPrefix'],
      voucherDate: map['VoucherDate:'],
      voucherType: map['VoucherType'],
      fromLocation: map['From_Location:'],
      toLocation: map['To_Location'],
      crQty: double.parse(map['Cr_Qty'] ?? "0"),
      drQty: double.parse(map['Dr_Qty'] ?? "0"),
      crAmount: double.parse(map['Cr_Amount'] ?? "0"),
      drAmount: double.parse(map['Dr_Amount'] ?? "0"),
      narration: map['Narration'],
      // vtime: DateTime.fromMillisecondsSinceEpoch(map['Time']),
      requirementItemID: map['Requirement_ItemID'],
      price: double.parse(map['Price'] ?? "0"),
      consumed: double.parse(map['Consumed'] ?? "0"),
      consumedReqId: map['Consumed_ReqId'],
      batchID: map['batchID'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionItemModel.fromJson(String source) =>
      TransactionItemModel.fromMap(json.decode(source));
}
