import 'package:authentication_with_bloc/Blocs/Master/Inventory/Items/List/inventoryitemslist_bloc.dart';
import 'package:authentication_with_bloc/DataModels/Masters/Inventory/InventoryItemDataModel.dart';
import 'package:authentication_with_bloc/Widgets/SearchWidgets/InventoryGroupSearch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InventoryItemEditor extends StatefulWidget {
  final InventoryItemDataModel item;
  final bool isEditing;
  const InventoryItemEditor({Key key, this.isEditing, this.item})
      : super(key: key);

  @override
  _InventoryItemEditorState createState() =>
      _InventoryItemEditorState(this.isEditing, this.item);
}

class _InventoryItemEditorState extends State<InventoryItemEditor> {
  final _formKey = GlobalKey<FormState>();
  final InventoryItemDataModel item;
  final bool isEditing;
  InventoryItemsListBloc _itemsBloc;
  _InventoryItemEditorState(this.isEditing, this.item);

  @override
  void initState() {
    // TODO: implement initState
    _itemsBloc = BlocProvider.of<InventoryItemsListBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Item for Edit : ${item.itemName}");
    return Scaffold(
      appBar: AppBar(
        title: Hero(tag: 'hero-tag', child: Text('Edit Item')),
      ),
      body: _createForm(),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.play_arrow),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
            }
          }),
    );
  }

  Widget _createForm() {
    return Container(
      padding: EdgeInsets.all(12),
      child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: item.itemName,
                decoration: InputDecoration(
                    hintText: "Item name", labelText: 'Item Name'),
                validator: (text) {
                  if (text.isEmpty) return 'Please Enter a Name';
                  return null;
                },
                onSaved: (value) {
                  item.itemName = value;
                },
              ),
              Container(
                padding: EdgeInsets.all(8),
              ),
              InventoryGroupSearch(
                currentValue: item.groupID,
                onItemSeelected: (groupID, groupName) {
                  item.groupID = groupID;
                  item.groupName = groupName;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.numberWithOptions(
                    decimal: true, signed: false),
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                initialValue: item.price.toStringAsFixed(2),
                decoration:
                    InputDecoration(hintText: "Price", labelText: 'Price'),
                onSaved: (value) {
                  item.price = value.length > 0 ? double.parse(value) : 0.0;
                },
                validator: (value) {
                  if (value is double) return 'Enter valid number';
                  return null;
                },
              ),
            ],
          )),
    );
  }
}
