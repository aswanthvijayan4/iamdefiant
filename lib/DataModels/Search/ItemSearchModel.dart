import 'dart:convert';

import 'package:hive/hive.dart';

part 'ItemSearchModel.g.dart';

@HiveType(typeId: 1)
class ItemSearchModel extends HiveObject {
  @HiveField(0)
  String itemID;
  @HiveField(1)
  String itemName;
  @HiveField(2)
  String groupName;
  @HiveField(3)
  String groupID;
  @HiveField(4)
  double price;
  @HiveField(5)
  double taxRate;
  @HiveField(6)
  int defaultUomId;
  @HiveField(7)
  String imageUrl;
  @HiveField(8)
  String itemDescription;
  ItemSearchModel({
    this.itemID,
    this.itemName,
    this.groupName,
    this.groupID,
    this.price,
    this.taxRate,
    this.defaultUomId,
    this.imageUrl,
    this.itemDescription,
  });

  Map<String, dynamic> toMap() {
    return {
      'Item_ID': itemID,
      'Item_Name': itemName,
      // 'groupName': groupName,
      // 'groupID': groupID,
      'price': price,
      'Vat_Rate': taxRate,
      'Default_UOM_ID': defaultUomId,
      'ImageUrl': imageUrl,
      'Item_Description': itemDescription,
    };
  }

  factory ItemSearchModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ItemSearchModel(
      itemID: map['Item_ID'],
      itemName: map['Item_Name'],
      // groupName: map['groupName'],
      // groupID: map['groupID'],
      price: double.parse(map['price']),
      taxRate: double.parse(map['Vat_Rate']),
      defaultUomId: int.parse(map['Default_UOM_ID']),
      imageUrl: map['ImageUrl'],
      itemDescription: map['Item_Description'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemSearchModel.fromJson(String source) =>
      ItemSearchModel.fromMap(json.decode(source));
}
