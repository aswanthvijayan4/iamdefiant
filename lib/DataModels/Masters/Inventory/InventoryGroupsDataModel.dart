import 'package:equatable/equatable.dart';

final String TableName_InventoryGroups = "Sales_Inventory_Groups";

final String column_Inv_ID = "_id";
final String column_Inv_GroupID = "Group_ID";
final String column_Inv_GroupName = "Group_Name";
final String column_Inv_GroupNameArabic = "GroupNameArabic";
final String column_Inv_ParentGroupID = "Parent_ID";
final String column_Inv_GroupType = "Group_Type";
final String column_Inv_fromExternal = "fromExternal";
final String column_Inv_action = "action";
final String column_Inv_parentGroupName = "parentGroupName";

class InventoryGroupDataModel extends Equatable {
  int _id;
  String GroupID;
  String GroupName;
  String GroupNameArabic;
  String ParentGroupId;
  String GroupType;
  String parentGroupName;

  bool fromExternal = false;
  int action;

  InventoryGroupDataModel();

  InventoryGroupDataModel.fromMap(Map map) {
    //E_Id=map[columnEmployeeId];
    _id = map[column_Inv_ID];
    GroupID = map[column_Inv_GroupID];
    GroupName = map[column_Inv_GroupName];
    GroupNameArabic = map[column_Inv_GroupNameArabic];
    ParentGroupId = map[column_Inv_ParentGroupID];
    GroupType = map[column_Inv_GroupType];
    parentGroupName = map[column_Inv_parentGroupName];
    fromExternal = map[column_Inv_fromExternal];
    action = map[column_Inv_action];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      column_Inv_GroupID: GroupID,
      column_Inv_GroupName: GroupName,
      column_Inv_ParentGroupID: ParentGroupId,
      column_Inv_GroupType: GroupType
    };
    return map;
  }

  @override
  List<Object> get props => [
        _id,
        GroupID,
        GroupName,
        GroupNameArabic,
        ParentGroupId,
        GroupType,
        parentGroupName
      ];
}
