import 'package:authentication_with_bloc/erp/Blocs/Master/Inventory/Groups/List/inventorygroups_bloc.dart';
import 'package:authentication_with_bloc/erp/Database/Inventory/Masters/InventoryGroupsMasterDatabaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class InventoryGroupSearch extends StatelessWidget {
  final void Function(String groupID, String groupName) onItemSeelected;
  final currentValue;

  const InventoryGroupSearch({Key key, this.onItemSeelected, this.currentValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            InventorygroupsBloc(InventoryGroupDBHelper())..add(LoadData()),
        child: BlocBuilder<InventorygroupsBloc, InventorygroupsState>(
          builder: (context, state) {
            if (state is ListLoaded) {
              if (state.items.isEmpty) {
                return Text('Items are Empty');
              } else {
                int currIndex = 0;
                int x = 0;
                var defelem;
                List<DropdownMenuItem> items = [];
                state.items.forEach((element) {
                  items.add(DropdownMenuItem(
                    child: Text(element['Name']),
                    value: element,
                  ));
                  if (element['id'] == currentValue) {
                    currIndex = x;
                    print('Grp ID :${element['id']}');
                    defelem = element;
                  }
                  x++;
                });
                print('Index = $currIndex');
                print('Val : ${state.items[currIndex]}');

                return SearchableDropdown.single(
                    value: defelem ?? '',
                    items: items,
                    hint: 'Select Parent Group',
                    searchHint: 'Select Parent Group',
                    label: 'Parent Group',

                    // style: TextStyle(),
                    isExpanded: true,
                    dialogBox: false,
                    closeButton: null,
                    displayClearIcon: false,
                    menuConstraints: BoxConstraints.tight(Size.fromHeight(350)),
                    searchFn: (String keyword, items) {
                      List<int> ret = [];
                      for (int i = 0; i < items.length; i++) {
                        if (items[i]
                            .value['Name']
                            .toString()
                            .toLowerCase()
                            .contains(keyword.toLowerCase())) ret.add(i);
                      }
                      return ret;
                    },
                    onChanged: (value) {
                      print('value: $value');
                      print('Selected ${value['Name']}');
                      // item.groupID = value['id'];
                      onItemSeelected(value['id'], value['Name']);
                    });
              }
            }
            return Text('Items Not Loaded');
          },
        ));
  }
}
