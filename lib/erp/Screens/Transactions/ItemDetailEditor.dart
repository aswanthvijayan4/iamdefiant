import 'package:authentication_with_bloc/erp/Blocs/Transactions/Itemdetail/itemdetailbloc_cubit.dart';
import 'package:authentication_with_bloc/erp/Blocs/Transactions/VoucherCubit/vouchercubit_cubit.dart';
import 'package:authentication_with_bloc/erp/DataModels/Masters/Inventory/InventoryItemDataModel.dart';
import 'package:authentication_with_bloc/erp/DataModels/Search/ItemSearchModel.dart';
import 'package:authentication_with_bloc/erp/Widgets/SearchWidgets/InventoryItemSearch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class ItemDetailEditor extends StatefulWidget {
  ItemDetailEditor({Key key, @required this.row, this.edit = false})
      : super(key: key);

  final int row;
  final bool edit;

  @override
  _ItemDetailEditorState createState() => _ItemDetailEditorState();
}

class _ItemDetailEditorState extends State<ItemDetailEditor> {
  Box<ItemSearchModel> box;

  final _formKey = GlobalKey<FormState>();
  final focus = FocusNode();
  final crfocus = FocusNode();
  final drfocus = FocusNode();
  TextEditingController _crCtrl = TextEditingController();
  TextEditingController _drCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    initbox();
  }

  void initbox() async {
    box = Hive.box('items');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit item'),
      ),
      body: blocpass(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          saveClicked();
          Navigator.pop(context);
        },
        label: Text('Next'),
      ),
    );
  }

  void saveClicked() {
    final InventoryItemDataModel item =
        (context.bloc<ItemdetailblocCubit>().state as TransactionItem).item;
    item.crQty = double.parse(_crCtrl.text);
    item.drQty = double.parse(_drCtrl.text);
    if (widget.edit)
      context.bloc<VouchercubitCubit>().updateItem(item: item, row: widget.row);
    else
      context.bloc<VouchercubitCubit>().addItem(item);
  }

  Widget blocpass() {
    return BlocConsumer<ItemdetailblocCubit, ItemdetailblocState>(
      builder: (context, state) {
        if (state is TransactionItem) {
          return getBody(state.item);
        } else {
          return Container();
        }
      },
      listenWhen: (previous, current) {
        if (previous != current) return true;
      },
      listener: (context, state) {
        if (state is TransactionItem) {
          FocusScope.of(context).requestFocus(crfocus);
        }
      },
    );

    // return Container();
  }

  Widget getBody(InventoryItemDataModel item) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _getItemSearch(item),
              Row(
                children: [
                  Expanded(
                    child: getProduced(item.crQty),
                  ),
                  Expanded(
                    child: getConsumed(item.drQty),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getProduced(double crQty) {
    _crCtrl.text = crQty?.toStringAsFixed(2);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          // child: TextField(
          //   controller: _crCtrl,
          //   keyboardType:
          //       TextInputType.numberWithOptions(signed: true, decimal: false),
          //   decoration: InputDecoration(
          //     // hintText: 'Produced',
          //     labelText: 'Produced',
          //   ),
          // ),
          child: TextFormField(
            focusNode: crfocus,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Produced'),
            controller: _crCtrl,
            // initialValue: crQty?.toStringAsFixed(2) ?? '',
            onFieldSubmitted: (v) {
              FocusScope.of(context).requestFocus(drfocus);
            },
          ),
        ),
      ),
    );
  }

  Widget getConsumed(double drQty) {
    _drCtrl.text = drQty?.toStringAsFixed(2) ?? '';
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            focusNode: drfocus,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Conusmed'),
            controller: _drCtrl,
          ),
        ),
      ),
    );
  }

  Widget _getItemSearch(InventoryItemDataModel item) {
    box = Hive.box('items');

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ItemSearchWidget(
          currentValue: ItemSearchModel(
            itemID: item.itemID,
            itemName: item.itemName,
          ),
          onItemSeelected: (item) {
            context.bloc<ItemdetailblocCubit>().setItem(item);
          },
          hive: box,
        ),
      ),
    );
  }
}
