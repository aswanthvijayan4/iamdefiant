import 'dart:convert';

import 'package:hive/hive.dart';

part 'VoucherLedgerDetail.g.dart';

@HiveType(typeId: 102)
class VoucherLedgerDetailHive extends HiveObject {
  // @HiveField(0)
  // String Voucher_No;
  // @HiveField(1)
  // String Voucher_Prefix;
  // @HiveField(2)
  // DateTime Voucher_Date;
  @HiveField(3)
  String Ledger_ID;
  @HiveField(4)
  double Amount;
  @HiveField(5)
  double Cr_Amount;
  @HiveField(6)
  double Dr_Amount;
  VoucherLedgerDetailHive({
    this.Ledger_ID,
    this.Amount,
    this.Cr_Amount,
    this.Dr_Amount,
  });
  // @HiveField(7)
  // String Narration;
  // @HiveField(8)
  // String Project_ID;
  // @HiveField(9)
  // String Salesman_ID;

  Map<String, dynamic> toMap() {
    return {
      'Ledger_ID': Ledger_ID,
      'Amount': Amount,
      'Cr_Amount': Cr_Amount,
      'Dr_Amount': Dr_Amount,
    };
  }

  factory VoucherLedgerDetailHive.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return VoucherLedgerDetailHive(
      Ledger_ID: map['Ledger_ID'],
      Amount: map['Amount'],
      Cr_Amount: map['Cr_Amount'],
      Dr_Amount: map['Dr_Amount'],
    );
  }

  String toJson() => json.encode(toMap());

  factory VoucherLedgerDetailHive.fromJson(String source) =>
      VoucherLedgerDetailHive.fromMap(json.decode(source));
}
