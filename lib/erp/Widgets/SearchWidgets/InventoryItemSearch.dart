import 'package:authentication_with_bloc/erp/DataModels/Masters/Inventory/InventoryItemDataModel.dart';
import 'package:authentication_with_bloc/erp/DataModels/Search/ItemSearchModel.dart';
import 'package:flutter/material.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:hive/hive.dart';

class ItemSearchWidget extends StatefulWidget {
  ItemSearchWidget(
      {Key key, this.hive, this.onItemSeelected, this.currentValue})
      : super(key: key);
  final Box<ItemSearchModel> hive;
  final void Function(InventoryItemDataModel item) onItemSeelected;
  final ItemSearchModel currentValue;

  @override
  _ItemSearchWidgetState createState() => _ItemSearchWidgetState();
}

class _ItemSearchWidgetState extends State<ItemSearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SearchableDropdown.single(
        value: widget.hive.get(widget.currentValue.itemID),
        hint: 'Select Item',
        searchHint: 'Select Item',
        label: 'Item',
        items: getItems(),
        isExpanded: true,
        dialogBox: false,
        closeButton: null,
        displayClearIcon: false,
        menuConstraints: BoxConstraints.tight(Size.fromHeight(350)),
        searchFn: (String keyword, items) {
          List<int> ret = [];
          for (int i = 0; i < items.length; i++) {
            final ItemSearchModel item = items[i].value as ItemSearchModel;
            print(items[i]);
            if (item.itemName.toLowerCase().contains(keyword.toLowerCase()))
              ret.add(i);
          }
          return ret;
        },
        onChanged: (ItemSearchModel value) {
          print('${value.itemName} is selected');
          widget.onItemSeelected(InventoryItemDataModel(
            itemID: value.itemID,
            itemName: value.itemName,
            defaultUOMID: value.defaultUomId,
            groupID: value.groupID,
            price: value.price,
          ));
        },
      ),
    );
  }

  List<DropdownMenuItem> getItems() {
    List<DropdownMenuItem> items = [];
    print('Hive Size : ${widget.hive.length}');
    for (int i = 0; i < widget.hive.length; i++) {
      final item = widget.hive.getAt(i);
      print('Hive : ${item.itemName}');
      items.add(DropdownMenuItem(
        child: Text(item.itemName),
        value: item,
      ));
      if (item.itemID == widget.currentValue.itemID) {}
    }
    return items;
  }
}
