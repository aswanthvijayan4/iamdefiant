final String columnAccid = "_id";
final String columngroupName = "Group_Name";
final String columngroupNameArabic = "groupNameArabic";
final String columngroupID = "Group_ID";
final String columngroupType = "Group_Type";
final String columngroupAlias = "groupAlias";
final String columncategory = "category";
final String columnparentGroupId = "Parent_ID";
final String columnparentGroupName = "parentGroupName";
final String columnfromExternal = "";
final String columnaction = "";

final String tableNameAccountGroups = "Account_Groups";

class AccountGroupDataModel {
  String groupName;
  String groupNameArabic;
  String groupID;
  String groupType;
  String groupAlias;
  String category;
  String parentGroupId;
  String parentGroupName;

  bool fromExternal = false;
  int action;
  AccountGroupDataModel.blank();
  AccountGroupDataModel(
    this.groupName,
    this.groupNameArabic,
    this.groupID,
    this.groupType,
    this.groupAlias,
    this.category,
    this.parentGroupId,
    this.parentGroupName,
    this.fromExternal,
    this.action,
  );
  AccountGroupDataModel.fromMapDef(Map map) {
    //E_Id=map[columnEmployeeId];

    groupName = map[columngroupName];
    groupNameArabic = map[columngroupNameArabic];
    groupID = map[columngroupID];
    groupType = map[columngroupType];
    groupAlias = map[columngroupAlias];
    category = map[columncategory];
    fromExternal = map[columnfromExternal];
    action = map[columnaction];
  }

  Map<String, dynamic> toMapDef() {
    Map<String, dynamic> map = {
      columngroupID: groupID,
      columngroupName: groupName,
      columnparentGroupId: parentGroupId,
      columngroupNameArabic: groupNameArabic,
      columngroupType: groupType,
      columngroupAlias: groupAlias,
      columncategory: category,
      columnparentGroupName: parentGroupName,
    };

    return map;
  }
}
