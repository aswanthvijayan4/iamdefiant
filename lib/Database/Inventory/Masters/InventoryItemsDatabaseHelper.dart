import 'package:authentication_with_bloc/DataModels/Masters/Inventory/InventoryGroupsDataModel.dart';
import 'package:authentication_with_bloc/DataModels/Masters/Inventory/InventoryItemDataModel.dart';
import 'package:authentication_with_bloc/Database/DatabaseHelper.dart';
import 'package:authentication_with_bloc/Database/core/MasterDBAbstract.dart';
import 'package:authentication_with_bloc/Repositories/ItemMasterRepo.dart';

class InventoryItemsDBHelper implements MasterDBAbstract, ItemMasterRepo {
  final DatabaseHelper _db = DatabaseHelper.get();

  InventoryItemsDBHelper();

  Future<List<InventoryItemDataModel>> getAllItems() async {
    print("Test  at Database");
    String qStr = "SELECT  ";
    qStr += "$column_Item_ID,$column_Item_Name";
    // qStr += "(Select $columnGroupName from $TableName_InventoryGroups ";
    // qStr += "where Gr.$columnGroupID = $columnGroupID) ";
    // qStr += "as $columnparentGroupName ";
    qStr += " FROM $TableName_InventoryItems";

    List<InventoryItemDataModel> itemsList = [];
    var res = await _db.getqueryResult(qStr);

    res.forEach((result) {
      // print(result);
      // itemsList.add(InventoryItemDataModel.fromMap(result));
      print(result[column_Item_Name]);
    });

    itemsList.forEach((element) {
      print("Name : ${element.itemName}");
    });
    return itemsList;
  }

  //TO DO

  Future<int> upsertInventoryGroup(InventoryItemDataModel item) async {
    await _db.startTransaction();
    Map<String, dynamic> map = Map();

    if (item != null) {
      await _db.insertRecords(data: map, tablename: TableName_InventoryItems);
    } else {
      Map<String, dynamic> mapClause = Map();
      mapClause[column_Inv_GroupID] = item.itemID;
      await _db.updateRecords(
          data: map, clause: mapClause, tablename: TableName_InventoryItems);
    }
    await _db.commitTransaction();
    return 0;
  }

  Future<int> deleteInventoryGroup(String itemID) async {
    Map<String, dynamic> map = Map();
    map[column_Item_ID] = itemID;
    await _db.deleteRecords(clause: map, tablename: TableName_InventoryItems);
    return 0;
  }

  Future<String> getItemNameByID(String ID) async {
    String str;

    return str;
  }

  Future<String> getItemIdByName(String ID) async {
    String qStr = " SELECT ";
    qStr += " from " + TableName_InventoryItems;
    qStr += " where ";
    return await _db.getSingleTonResult(qStr);
  }

  Future<List<InventoryItemDataModel>> getAllItemsUnder(String groupID) async {
    print("Test  at Database");
    String qStr = "SELECT ";
    qStr += "$column_Item_ID,$column_Item_Name,$column_Item_Price,";
    qStr += " FROM $TableName_InventoryItems Gr order by 2";

    List<InventoryItemDataModel> itemsList = [];
    var res = await _db.getqueryResult(qStr);
    print("Result : $res");

    res.forEach((result) {
      print(result);
      itemsList.add(InventoryItemDataModel.fromMapMaster(result));
    });

    itemsList.forEach((element) {
      print("Name : ${element.itemName}");
    });
    return itemsList;
  }

  @override
  Future<List<Map>> getAllEntitiesAsList(
      [int startIndex = -1, int limit = -1, String filter = ""]) async {
    print("Test  at Database filter : $filter");
    String qStr = "SELECT ";
    qStr +=
        "$column_Item_ID as 'id' ,$column_Item_Name as 'Name',$column_Item_Price as '1st',";
    qStr += "(Select $column_Inv_GroupName from $TableName_InventoryGroups ";
    qStr += "where Gr.$column_Item_Group_Id = $column_Inv_GroupID) ";
    qStr += "as '2nd' ";
    qStr += " FROM $TableName_InventoryItems Gr ";
    if (filter.length > 0) qStr += " WHERE $column_Item_Name LIKE '%$filter%'";
    qStr += " order by 2 ";
    if (limit > -1) qStr += " LIMIT $limit OFFSET $startIndex";
    print('Query : $qStr');
    var res = await _db.getqueryResult(qStr);
    // print(res);

    return res;
  }

  @override
  Future<dynamic> getEntityByID(String id) async {
    String qStr = " SELECT  ";
    qStr += column_Item_ID + ", ";
    qStr += column_Item_Name + ", ";
    qStr += column_Item_Alias + ", ";
    qStr += column_Item_Code + ", ";
    qStr += column_Item_Group_Id + ", ";
    qStr += column_Item_Part_Number + ", ";
    qStr += column_Item_Price + ", ";
    qStr += column_Opening_Stock + ", ";
    qStr += column_Opening_Balance_Date + ", ";
    qStr += column_Last_Modified_By + ", ";
    qStr += column_Opening_Rate + ", ";
    qStr += column_Opening_Value + ", ";
    qStr += column_Narration + ", ";
    qStr += column_Serial_Number + ", ";
    qStr += column_Closing_Stock + ", ";
    qStr += column_Reorder_Level + ", ";
    qStr += column_Std_Cost + ", ";
    qStr += column_Default_Sales_Ledger_id + ", ";
    qStr += column_Default_PurchaseLedger_id + ", ";
    qStr += column_Default_Input_Tax_Ledger + ", ";
    qStr += column_Default_Output_Tax_Ledger + ", ";
    qStr += column_Default_Sales_Return_Ledger + ", ";
    qStr += column_Default_Purchase_Return_Ledger + ", ";
    qStr += column_Vat_Rate + ", ";
    qStr += column_Default_UOM_ID + ", ";
    qStr += column_Last_Modified + ", ";
    qStr += column_Date_Created + ", ";
    qStr += column_Timestamp + ", ";
    qStr += column_Warranty_Days + ", ";
    qStr += column_Shelf_Life + ", ";
    qStr += column_Brand_Id + ", ";
    qStr += column_Item_Description + ", ";
    qStr += column_isCustomItem + ", ";
    qStr += column_Dimension + ", ";
    qStr += column_isPurchaseItem + ", ";
    qStr += column_isSalesItem + ", ";
    qStr += column_KOT_Printer + ", ";
    qStr += column_Item_Name_Arabic + ", ";
    qStr += column_Favourite + ", ";
    qStr += column_IsStockItem + ", ";
    qStr += column_From_Time + ", ";
    qStr += column_To_Time + ", ";
    qStr += column_Price_2 + ", ";
    qStr += column_HSN_CODE + ", ";
    qStr += column_Section + ", ";
    qStr += column_Flags + ", ";
    qStr += column_Category + ", ";

    qStr += "(Select $column_Inv_GroupName from $TableName_InventoryGroups ";
    qStr +=
        "where Gr.$column_Item_Group_Id = $column_Inv_GroupID) as $column_Item_Group_Name";

    qStr += " from " + TableName_InventoryItems;
    qStr += " Gr where ";
    qStr += column_Item_ID + "=?";

    Map map = await _db.getSingleRowQueryResult(qStr, [id]);

    return InventoryItemDataModel.fromMapMaster(map);
  }

  @override
  Future<int> getMax() async {
    String qStr = 'SELECT MAX($column_id) from $TableName_InventoryItems';
    int n = await _db.getCount(qStr);
    print('next = $n');
    return n;
  }

  @override
  Future<String> getNameByID(String filter) async {
    // TODO: implement getNameByID
    throw UnimplementedError();
  }

  @override
  Future<bool> idExists(String id) async {
    if (id == null) return false;
    String qStr =
        'SELECT COUNT(*) FROM $TableName_InventoryItems where $column_Item_ID =?';
    int count = await _db.getCount(qStr, [id]);
    print('Found count :$count');
    if (count > 0) return true;
    return false;
  }

  @override
  Future<bool> upsertEntity(entity) async {
    print('at insert');
    InventoryItemDataModel object = entity as InventoryItemDataModel;
    await _db.startTransaction();
    Map<String, dynamic> map = object.toMapForMasterInsert(); //();

    print('TO UPDATE $map');

    try {
      if (!await idExists(object.itemID)) {
        print('Insert Inv Group');
        int t = await getMax();
        object.itemID = object.groupID + 'x$t';
        map[column_Item_ID] = object.itemID;
        await _db.insertRecords(data: map, tablename: TableName_InventoryItems);
      } else {
        print('Updating Inv Group 189');
        Map<String, dynamic> mapClause = new Map();
        mapClause[column_Item_ID] = object.itemID;
        print("Ready to UPdate");
        await _db.updateRecords(
            data: map, clause: mapClause, tablename: TableName_InventoryGroups);
      }

      await _db.commitTransaction();
    } catch (Ex) {
      print(Ex.toString());
      return false;
    }
    return true;
  }

  @override
  Future<bool> deleteEntity(String id) {
    // TODO: implement deleteEntity
    throw UnimplementedError();
  }

  @override
  Future getAllItemsForSearch() {
    // TODO: implement getAllItemsForSearch
    throw UnimplementedError();
  }

  @override
  Future<InventoryItemDataModel> getItemById({String itemID}) {
    // TODO: implement getItemById
    throw UnimplementedError();
  }
}
