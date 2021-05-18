import 'dart:convert';

final String column_sl_no = "sl_no";
final String column_LEDGER_ID = "LEDGER_ID";
final String column_Ledger_Name = "Ledger_Name";
final String column_Ledger_Type = "Ledger_Type";
final String column_Group_Id = "Group_Id";
final String column_Opening_Balance = "Opening_Balance";
final String column_Opening_Balance_Date = "Opening_Balance_Date";
final String column_Closing_Balance = "Closing_Balance";
final String column_Turn_Over = "Turn_Over";
final String column_isIndividual = "isIndividual";
final String column_Narration = "Narration";
final String column_City = "City";
final String column_Address = "Address";
final String column_Email = "Email";
final String column_Phone_Number = "Phone_Number";
final String column_Contact_Person_Name = "Contact_Person_Name";
final String column_Mobile_Number = "Mobile_Number";
final String column_Website = "Website";
final String column_Contact_Person = "Contact_Person";
final String column_Contant_Person_Number = "Contant_Person_Number";
final String column_PoBox = "PoBox";
final String column_Country = "Country";
final String column_Registration_Number = "Registration_Number";
final String column_Default_Price_List_Id = "Default_Price_List_Id";
final String column_State = "State";
final String column_Birth_Date = "Birth_Date";
final String column_Credit_Period = "Credit_Period";
final String column_ParentCompany = "ParentCompany";
final String column_Fax = "Fax";
final String column_creditAllowed = "creditAllowed";
final String column_paymentTerms = "paymentTerms";
final String column_Tax_Rate = "Tax_Rate";
final String column_Type_Of_Supply = "Type_Of_Supply";
final String column_Default_Tax_Ledger = "Default_Tax_Ledger";
final String column_TRN = "TRN";
final String column_DefaultRecord = "DefaultRecord";
final String column_DbName = "DbName";

const String TableName_Ledger_Master = "Ledger_Master";

class LedgerMasterDataModel {
  int sl_no;
  String LedgerID;
  String LedgerName;
  String ledgerNameArabic;
  String LedgerGroupId;
  String LedgerGroupName;
  double openingBalance;
  var openingBalanceDate;

  double closingBalance = 0; //calulate
  double totalTurnover = 0; //calulate

  String LedgerType;
  String narration;
  String City;
  String Address;
  String emailAddress;
  String phoneNumber;
  String fax;
  String parentCompany;
  String mobileNumber;
  String website;

  String ContactPersonName;
  String ContactPersonNumber;
  String ContactPersonEmail;
  String PoBox;
  String Country;
  String tRN;

  String defaultPriceListID;

  double amount = 0;

  int listid = -1;

  String state;
  DateTime birthDate;
  int creditPeriod;
  double creditAllowed;
  bool isIndividual;

  double crAmount = 0;
  double drAmount = 0;
  String voucherNo;
  var voucherDate;
  String voucherType;
  String voucherPrefix;

  DateTime timestamp;

  bool isInvoiceItem = false;

  String DefaultTaxLedger;
  String TypeOfSupply;
  double taxRate = 0;
  String AgainstLedger;
  bool hasBillwiseMappings = false;

  String dbName;

  bool fromExternal = false;
  int action;

  bool defaultRecord = false;

  String paymentTerms;
  String ParentCompany;
  LedgerMasterDataModel({
    this.sl_no,
    this.LedgerID,
    this.LedgerName,
    this.ledgerNameArabic,
    this.LedgerGroupId,
    this.LedgerGroupName,
    this.openingBalance,
    this.openingBalanceDate,
    this.closingBalance,
    this.totalTurnover,
    this.LedgerType,
    this.narration,
    this.City,
    this.Address,
    this.emailAddress,
    this.phoneNumber,
    this.fax,
    this.parentCompany,
    this.mobileNumber,
    this.website,
    this.ContactPersonName,
    this.ContactPersonNumber,
    this.ContactPersonEmail,
    this.PoBox,
    this.Country,
    this.tRN,
    this.defaultPriceListID,
    this.amount,
    this.listid,
    this.state,
    this.birthDate,
    this.creditPeriod,
    this.creditAllowed,
    this.isIndividual,
    this.crAmount,
    this.drAmount,
    this.voucherNo,
    this.voucherDate,
    this.voucherType,
    this.voucherPrefix,
    this.timestamp,
    this.isInvoiceItem,
    this.DefaultTaxLedger,
    this.TypeOfSupply,
    this.taxRate,
    this.AgainstLedger,
    this.hasBillwiseMappings,
    this.dbName,
    this.fromExternal,
    this.action,
    this.defaultRecord,
    this.paymentTerms,
    this.ParentCompany,
  });

  LedgerMasterDataModel.fromMap(Map map) {
    sl_no = map["sl_no"] as num;
    LedgerID = map["LEDGER_ID"];
    LedgerName = map["Ledger_Name"];
    LedgerType = map["Ledger_Type"];
    LedgerGroupId = map["Group_Id"];
    // openingBalance = map["Opening_Balance"] as num;
    openingBalanceDate =
        DateTime.parse(map["Opening_Balance_Date"] ?? '2000-01-01');
    closingBalance = map["Closing_Balance"] as num;
    totalTurnover = map["Turn_Over"] as num;
    isIndividual = map["isIndividual"] == 1 ? true : false;
    narration = map["Narration"];
    City = map["City"];
    Address = map["Address"];
    emailAddress = map["Email"];
    phoneNumber = map["Phone_Number"];
    ContactPersonName = map["Contact_Person_Name"];
    mobileNumber = map["Mobile_Number"];
    website = map["Website"];
    ContactPersonName = map["Contact_Person"];
    ContactPersonNumber = map["Contant_Person_Number"];
    PoBox = map["PoBox"];
    Country = map["Country"];
    tRN = map["Registration_Number"];
    defaultPriceListID = map["Default_Price_List_Id"];
    state = map["State"];
    birthDate = DateTime.parse(map["Birth_Date"] ?? '2000-01-01');
    creditPeriod = map["Credit_Period"] as num;
    ParentCompany = map["ParentCompany"];
    fax = map["Fax"];
    creditAllowed = map["creditAllowed"] as num;
    paymentTerms = map["paymentTerms"];
    taxRate = map["Tax_Rate"];
    TypeOfSupply = map["Type_Of_Supply"];
    DefaultTaxLedger = map["Default_Tax_Ledger"];
    tRN = map["TRN"];
    defaultRecord = map["DefaultRecord"] == 1 ? true : false;
    dbName = map["DbName"];
  }

  Map<String, dynamic> toMap() {
    return {
      'sl_no': sl_no,
      'LedgerID': LedgerID,
      'LedgerName': LedgerName,
      'ledgerNameArabic': ledgerNameArabic,
      'LedgerGroupId': LedgerGroupId,
      'LedgerGroupName': LedgerGroupName,
      'openingBalance': openingBalance,
      'openingBalanceDate': openingBalanceDate?.toMap(),
      'closingBalance': closingBalance,
      'totalTurnover': totalTurnover,
      'LedgerType': LedgerType,
      'narration': narration,
      'City': City,
      'Address': Address,
      'emailAddress': emailAddress,
      'phoneNumber': phoneNumber,
      'fax': fax,
      'parentCompany': parentCompany,
      'mobileNumber': mobileNumber,
      'website': website,
      'ContactPersonName': ContactPersonName,
      'ContactPersonNumber': ContactPersonNumber,
      'ContactPersonEmail': ContactPersonEmail,
      'PoBox': PoBox,
      'Country': Country,
      'tRN': tRN,
      'defaultPriceListID': defaultPriceListID,
      'amount': amount,
      'listid': listid,
      'state': state,
      'birthDate': birthDate?.millisecondsSinceEpoch,
      'creditPeriod': creditPeriod,
      'creditAllowed': creditAllowed,
      'isIndividual': isIndividual,
      'crAmount': crAmount,
      'drAmount': drAmount,
      'voucherNo': voucherNo,
      'voucherDate': voucherDate?.toMap(),
      'voucherType': voucherType,
      'voucherPrefix': voucherPrefix,
      'timestamp': timestamp?.millisecondsSinceEpoch,
      'isInvoiceItem': isInvoiceItem,
      'DefaultTaxLedger': DefaultTaxLedger,
      'TypeOfSupply': TypeOfSupply,
      'taxRate': taxRate,
      'AgainstLedger': AgainstLedger,
      'hasBillwiseMappings': hasBillwiseMappings,
      'dbName': dbName,
      'fromExternal': fromExternal,
      'action': action,
      'defaultRecord': defaultRecord,
      'paymentTerms': paymentTerms,
      'ParentCompany': ParentCompany,
    };
  }

  Map<String, dynamic> toMapForTransTest() {
    Map<String, dynamic> map = {
      'Ledger_Id': LedgerID,
      'Ledger_Name': LedgerName,
      'crAmount': crAmount,
      'drAmount': drAmount,
      'amount': amount,
    };
    return map;
  }

//new

  factory LedgerMasterDataModel.fromMapGen(Map<String, dynamic> map) {
    print('ledger : $map');
    if (map == null) return null;

    return LedgerMasterDataModel(
      LedgerID: map['Ledger_Id'],
      LedgerName: map['Ledger_Name'],
      crAmount: double.parse(map['crAmount'] ?? '0'),
      drAmount: double.parse(map['drAmount'] ?? '0'),
      amount: double.parse(map['amount'] ?? '0'),
    );
  }

  String toJson() => json.encode(toMapForTransTest());

  factory LedgerMasterDataModel.fromJson(String source) =>
      LedgerMasterDataModel.fromMapGen(json.decode(source));
}
