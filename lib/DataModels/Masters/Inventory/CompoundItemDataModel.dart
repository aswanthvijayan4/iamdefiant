import 'dart:convert';

import 'package:authentication_with_bloc/DataModels/Masters/Accounts/LedgerMasterDataModel.dart';
import 'package:authentication_with_bloc/DataModels/Masters/Inventory/InventoryItemDataModel.dart';

class CompoundItemDataModel {
  InventoryItemDataModel BaseItem;
  CompoundItemDataModel({
    this.BaseItem,
  });
  // List<InventoryItemDataModel> subItems;
  // double subItemsTotal = 0;

  CompoundItemDataModel.fromMap(Map map) {
    //E_Id=map[columnEmployeeId];
    BaseItem = InventoryItemDataModel.fromMapMaster(map["BaseItem"]);
//    subItems = InventoryItemDataModel.fromMap(map["subItems"]);
    // subItemsTotal = map["subItemsTotal"];
  }

  Map<String, dynamic> toMapForTransTest() {
    return {
      'BaseItem': BaseItem?.toMapForTransTest(),
    };
  }

  factory CompoundItemDataModel.fromMapForTransTest(Map<String, dynamic> map) {
    print('Inv Conv : $map');
    if (map == null) return null;

    return CompoundItemDataModel(
      BaseItem: InventoryItemDataModel.fromMapForTransTest(map['BaseItem']),
    );
  }

  String toJson() => json.encode(toMapForTransTest());

  factory CompoundItemDataModel.fromJson(String source) =>
      CompoundItemDataModel.fromMapForTransTest(json.decode(source));
}
