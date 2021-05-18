import 'dart:convert';

const String TableNameUom = "Uomlist";
const String column_Uom_Id = "UOM_id";
const String column_Uom_Name = "uom_Name";
const String column_Uom_Symbol = "uom_symbol";
const String column_Uom_Decimal_Points = "UOM_decimal_Points";
const String column_Uom_Narration = "UOM_Narration";
const String column_Timestamp = "timestamp";

const String col_UOM_Conversion_TableName = "UOM_Conversion";
const String col_UOM_Conversion_id = "_id";
const String col_UOM_Conversion_BaseUnit = "BaseUnit";
const String col_UOM_Conversion_ToUnit = "ToUnit";
const String col_UOM_Conversion_Value = "ConValue";
const String col_UOM_Conversion_Narration = "Narration";
const String col_UOM_Conversion_ItemId = "itemID";

const String uom_subquery = " (SELECT distinct "
    " $col_UOM_Conversion_ItemId , "
    "+ $col_UOM_Conversion_ToUnit  as UOM, "
    " (SELECT  $column_Uom_Name  FROM  $TableNameUom   basetable where "
    " basetable.$column_Uom_Id  = contable.$col_UOM_Conversion_ToUnit ) as UomName, "
    " (SELECT $column_Uom_Symbol FROM $TableNameUom  basetable where "
    " basetable.$column_Uom_Id = contable.$col_UOM_Conversion_ToUnit "
    " ) as UomSymbol, $col_UOM_Conversion_Value  FROM $col_UOM_Conversion_TableName "
    " contable  UNION SELECT B.$col_UOM_Conversion_ItemId ,  case when cast(A."
    " $col_UOM_Conversion_BaseUnit as int) = cast(B.$col_UOM_Conversion_ToUnit "
    " as int) then A.$col_UOM_Conversion_ToUnit when cast(A.$col_UOM_Conversion_ToUnit "
    " as int) = cast(B.$col_UOM_Conversion_ToUnit  as int) then "
    " A.$col_UOM_Conversion_BaseUnit else '' END as UOM,  case when "
    " A.$col_UOM_Conversion_BaseUnit = B.$col_UOM_Conversion_ToUnit "
    " then (SELECT $column_Uom_Name FROM $TableNameUom "
    " basetable where basetable.$column_Uom_Id  = A.$col_UOM_Conversion_ToUnit "
    " ) when A.\$col_UOM_Conversion_ToUnit = B.$col_UOM_Conversion_ToUnit "
    " then (SELECT $column_Uom_Name FROM $TableNameUom  basetable where "
    " basetable.$column_Uom_Id = A.$col_UOM_Conversion_BaseUnit ) "
    " else '' END as UomName, case when A.$col_UOM_Conversion_BaseUnit "
    " = B.$col_UOM_Conversion_ToUnit then (SELECT $column_Uom_Symbol "
    " FROM  $TableNameUom  basetable where basetable.$column_Uom_Id "
    " = A.$col_UOM_Conversion_ToUnit ) when A.$col_UOM_Conversion_ToUnit "
    " = B. $col_UOM_Conversion_ToUnit  then (SELECT $column_Uom_Symbol "
    " FROM  $TableNameUom basetable where basetable.$column_Uom_Id "
    " = A.$col_UOM_Conversion_BaseUnit )  else '' END as UomSymbol, "
    " case when cast(A.$col_UOM_Conversion_BaseUnit as int) = cast(B."
    " $col_UOM_Conversion_ToUnit as int) then B.$col_UOM_Conversion_Value "
    " * A.$col_UOM_Conversion_Value when cast(A.$col_UOM_Conversion_ToUnit "
    " as int) = cast(B.$col_UOM_Conversion_ToUnit as int) then cast(B."
    "$col_UOM_Conversion_Value / A.$col_UOM_Conversion_Value as decimal(10,3))"
    " else 1 END FROM $col_UOM_Conversion_TableName  A  INNER JOIN "
    " $col_UOM_Conversion_TableName  B ON ( cast(A.$col_UOM_Conversion_BaseUnit "
    " as int) = cast(B.$col_UOM_Conversion_ToUnit  as int) OR cast(A."
    "$col_UOM_Conversion_ToUnit as int) = cast(B.$col_UOM_Conversion_ToUnit "
    " as int)) AND A.$col_UOM_Conversion_ItemId  = '' )";

class UOMDataModel {
  int id;
  String uomName;
  String uomSymbol;
  bool compoundIsTrue;
  int decimalPoints = 0;
  double convRate = 1;
  String baseItem;
  String compundName;
  String narration;
  DateTime timestamp;

  bool fromExternal = false;
  int action;

  UOMDataModel({
    this.id,
    this.uomName,
    this.uomSymbol,
    this.compoundIsTrue,
    this.decimalPoints,
    this.convRate,
    this.baseItem,
    this.compundName,
    this.narration,
    this.timestamp,
    this.fromExternal,
    this.action,
  });

  Map<String, dynamic> toMapForMasterInsert() {
    Map<String, dynamic> map = {
      column_Uom_Id: id,
      column_Uom_Name: uomName,
      column_Uom_Decimal_Points: decimalPoints,
      column_Uom_Symbol: uomSymbol,
      column_Uom_Narration: narration,
    };
    return map;
  }

  UOMDataModel.fromMapForMaster(Map map) {
    id = map[column_Uom_Id];
    uomName = map[column_Uom_Name];
    uomSymbol = map[column_Uom_Symbol];
    compoundIsTrue = map["compoundIsTrue"];
    decimalPoints = map[column_Uom_Decimal_Points];
    convRate = map["convRate"];
    baseItem = map["baseItem"];
    compundName = map["compundName"];
    narration = map[column_Uom_Narration];
  }

  Map<String, dynamic> toMapFull() {
    return {
      'id': id,
      column_Uom_Name: uomName,
      'uomSymbol': uomSymbol,
      'compoundIsTrue': compoundIsTrue,
      'decimalPoints': decimalPoints,
      'convRate': convRate,
      'baseItem': baseItem,
      'compundName': compundName,
      'narration': narration,
      'timestamp': timestamp?.millisecondsSinceEpoch,
    };
  }

  factory UOMDataModel.fromMapFull(Map<String, dynamic> map) {
    if (map == null) return null;

    return UOMDataModel(
      id: map['id'],
      uomName: map['uomName'],
      uomSymbol: map['uomSymbol'],
      compoundIsTrue: map['compoundIsTrue'],
      decimalPoints: map['decimalPoints'],
      convRate: map['convRate'],
      baseItem: map['baseItem'],
      compundName: map['compundName'],
      narration: map['narration'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp']),
    );
  }

  String toJson() => json.encode(toMapFull());

  factory UOMDataModel.fromJson(String source) =>
      UOMDataModel.fromMapFull(json.decode(source));
}
