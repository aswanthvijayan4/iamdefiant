import 'package:authentication_with_bloc/Blocs/Master/Inventory/Groups/List/inventorygroups_bloc.dart';
import 'package:authentication_with_bloc/DataModels/Masters/Inventory/InventoryGroupsDataModel.dart';
import 'package:authentication_with_bloc/Database/Inventory/Masters/InventoryGroupsMasterDatabaseHelper.dart';
import 'package:authentication_with_bloc/Widgets/SearchWidgets/InventoryGroupSearch.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class InventoryGroupEditor extends StatefulWidget {
  const InventoryGroupEditor({Key key, this.isEditing, this.group})
      : super(key: key);

  @override
  _InventoryGroupEditorState createState() =>
      _InventoryGroupEditorState(isEditing, group);

  final bool isEditing;
  final InventoryGroupDataModel group;
}

class _InventoryGroupEditorState extends State<InventoryGroupEditor> {
  final _formKey = GlobalKey<FormState>();
  final bool isEditing;
  List<Map> groupsList;
  _InventoryGroupEditorState(this.isEditing, this._group);
  InventorygroupsBloc _groupsBloc;
  final InventoryGroupDataModel _group;

  @override
  void initState() {
    // groupsList = await dbHelper.getAllGroups();
    _groupsBloc = BlocProvider.of<InventorygroupsBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(isEditing ? "Edit ${_group.GroupName}" : "Create Group")),
      body: _buildbody(),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.play_arrow), onPressed: saveFunction),
    );
  }

  Widget _buildbody() {
    return Container(
      padding: EdgeInsets.all(60.0),
      child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: false,
          children: <Widget>[
            TextFormField(
              initialValue: _group.GroupName ?? null,
              decoration: InputDecoration(labelText: 'Group Name'),
              validator: (value) {
                if (value.isEmpty) return 'Please Enter Group Name';
                return null;
              },
              onSaved: (value) {
                _group.GroupName = value;
              },
            ),
            Container(padding: EdgeInsets.all(10.0)),
            InventoryGroupSearch(
              currentValue: _group.ParentGroupId,
              onItemSeelected: (groupID, groupName) {
                _group.ParentGroupId = groupID;
                _group.parentGroupName = groupName;
              },
            ),
            Container(padding: EdgeInsets.all(5.0)),
            CheckboxListTile(
                title: Text('Is Sales Group?'),
                value: _group.GroupType == "2" ? true : false,
                onChanged: (val) {
                  setState(() {
                    _group.GroupType = val ? "2" : "0";
                  });
                })
          ],
        ),
      ),
    );
  }

  void saveFunction() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      _groupsBloc.add(AddGroupEvent(_group));
      _groupsBloc.add(LoadData());
      Navigator.pop(context);
    }
  }

  void deleteFunction() {
    _groupsBloc.add(DeleteGroupEvent(_group.GroupID));
  }

  Widget _sampleDropDown() {
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
                print(
                    'Parent Group  = ${_group.parentGroupName}   and Parent ID : ${_group.ParentGroupId}');
                List<DropdownMenuItem> items = [];
                state.items.forEach((element) {
                  items.add(DropdownMenuItem(
                    child: Text(element['Name']),
                    value: element,
                  ));
                  if (element['id'] == _group.ParentGroupId) {
                    currIndex = x;
                    print('Grp ID :${element['id']}');
                    print('Parent : ${_group.ParentGroupId}');
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
                      _group.ParentGroupId = value['id'];
                    });
              }
            }
            return Text('Items Not Loaded');
          },
        ));

    //  SearchableDropdown.single(items: null, onChanged: null);
  }
}
