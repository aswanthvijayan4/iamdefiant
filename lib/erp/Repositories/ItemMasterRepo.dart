import 'package:authentication_with_bloc/erp/DataModels/Masters/Inventory/InventoryItemDataModel.dart';

abstract class ItemMasterRepo {
  Future<InventoryItemDataModel> getItemById({String itemID});

  Future getAllItemsForSearch();
}
