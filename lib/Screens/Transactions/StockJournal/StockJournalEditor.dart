import 'package:authentication_with_bloc/Blocs/Transactions/Itemdetail/itemdetailbloc_cubit.dart';
import 'package:authentication_with_bloc/Blocs/Transactions/VoucherCubit/vouchercubit_cubit.dart';
import 'package:authentication_with_bloc/DataModels/Masters/Inventory/CompoundItemDataModel.dart';
import 'package:authentication_with_bloc/DataModels/Masters/Inventory/InventoryItemDataModel.dart';
import 'package:authentication_with_bloc/DataModels/Search/ItemSearchModel.dart';
import 'package:authentication_with_bloc/DataModels/Transactions/GeneralVoucherDataModel.dart';
import 'package:authentication_with_bloc/Screens/Transactions/ItemDetailEditor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class StockJournalEditor extends StatefulWidget {
  StockJournalEditor({Key key, @required this.isEdit, @required this.title})
      : super(key: key);
  final bool isEdit;
  final String title;

  @override
  _StockJournalEditorState createState() => _StockJournalEditorState();
}

class _StockJournalEditorState extends State<StockJournalEditor> {
  VouchercubitCubit _voucherCubit;
  Box<ItemSearchModel> box;
  @override
  void initState() {
    super.initState();
    _voucherCubit = BlocProvider.of<VouchercubitCubit>(context);
    print('Init  State');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.isEdit ? 'Edit' : 'Create'} ${widget.title}'),
        // actions: [
        //   IconButton(icon: Icon(Icons.save), onPressed: saveClicked),
        // ],
      ),
      body: getBody(),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     // addNewitem((context.bloc<VouchercubitCubit>().state as VoucherReady)
      //     //   .voucher);
      //   },
      //   label: Text('Add Item'),
      // ),
    );
  }

  Widget getBody() {
    print('Get Body');

    return BlocConsumer<VouchercubitCubit, VouchercubitState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is VoucherReady) {
          return Container(
            color: Theme.of(context).secondaryHeaderColor,
            child: Column(
              children: [
                Expanded(flex: 1, child: getVoucherDefaults(state.voucher)),
                Expanded(
                  flex: 10,
                  child: getItemsList(state.voucher.InventoryItems),
                ),
                Flexible(flex: 1, child: getTotalWidget()),
              ],
            ),
          );
        }
        if (state is VoucherFetching) {
          return Center(
              child: Container(child: Text('Fetching Voucher...!!!')));
        }
        if (state is VoucherRefreshing) {
          return Center(
              child: Container(child: Text('Refreshing Voucher...!!!')));
        }
        return Container();
      },
    );
  }

  void saveClicked() {
    _voucherCubit.saveVoucher((_voucherCubit.state as VoucherReady).voucher);
    Navigator.pop(context);
  }

  Widget getVoucherDefaults(final GeneralVoucherDataModel voucher) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');

    final DateFormat timeFormat = DateFormat('HH:mm:ss');

    String date = formatter.format(voucher.voucherDate);
    String time = timeFormat.format(voucher.timestamp);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Text('Voucher No. ${voucher.voucherNumber ?? '#'}'),
          decoration: BoxDecoration(
              // border: Border.all(),
              ),
        ),
        Expanded(
          child: Container(),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueGrey),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(date),
                                Text(time),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(2.0, 0, 0, 0),
                            child: Icon(Icons.calendar_today_outlined),
                          )
                        ],
                      ),
                      onTap: () async {
                        final DateTime dt = await showDatePicker(
                          context: context,
                          initialDate: voucher.voucherDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (dt != null) {
                          context.bloc<VouchercubitCubit>().setDate(dt);
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget getItemsList(List<CompoundItemDataModel> items) {
    print('Items List in Voucher');

    return Container(
      color: Colors.white30,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                updateitem(items[index].BaseItem, index);
              },
              child: Container(
                height: 80,
                child: Card(
                  color: Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 55,
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${items[index].BaseItem.itemName}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(0, 2, 0, 2)),
                                Text(
                                  '@ ${items[index].BaseItem.price.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 20,
                        child: getQtyPart(items, index),
                      ),
                      Expanded(
                        flex: 25,
                        child: Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '${items[index].BaseItem.subTotal.toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          itemCount: items.length,
        ),
      ),
    );
  }

  Widget getQtyPart(List<CompoundItemDataModel> items, int index) {
    if (true) {
      return Container(
        color: Colors.blue.shade50,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${items[index].BaseItem.crQty}',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
        ),
      );
    } else
      return Expanded(
        flex: 2,
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${items[index].BaseItem.crQty}',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    )),
                flex: 1,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${items[index].BaseItem.drQty}',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ),
                flex: 1,
              ),
            ],
          ),
        ),
      );
  }

  Widget getTotalWidget() {
    // return Container();
    return BlocBuilder<VouchercubitCubit, VouchercubitState>(
      builder: (context, state) {
        if (state is VoucherReady) {
          // print('Voucher is $state');
          return Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Total : \u20B9 ${state.voucher.grandTotal?.toStringAsFixed(2) ?? "0.00"}',
                style: TextStyle(color: Colors.black, fontSize: 22),
              ),
            ),
          );
        } else {
          return Container(
            color: Colors.blue,
            child: Text('total'),
          );
        }
      },
    );
  }

  void addNewitem(final GeneralVoucherDataModel voucher) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => ItemdetailblocCubit()..getEmptyItem()),
            BlocProvider.value(
                value: BlocProvider.of<VouchercubitCubit>(context))
          ],
          child:
              ItemDetailEditor(row: voucher.InventoryItems.length, edit: false),
        ),
      ),
    );
  }

  void updateitem(final InventoryItemDataModel item, int row) {
    return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => ItemdetailblocCubit()..setItem(item)),
            BlocProvider.value(
                value: BlocProvider.of<VouchercubitCubit>(context))
          ],
          child: ItemDetailEditor(
            row: row,
            edit: true,
          ),
        ),
      ),
    );
  }
}
