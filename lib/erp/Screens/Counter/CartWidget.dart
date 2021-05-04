import 'package:authentication_with_bloc/erp/Blocs/Transactions/VoucherCubit/vouchercubit_cubit.dart';
import 'package:authentication_with_bloc/erp/DataModels/Transactions/GeneralVoucherDataModel.dart';
import 'package:authentication_with_bloc/erp/Screens/Counter/POSCartList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartWidget extends StatefulWidget {
  CartWidget({Key key}) : super(key: key);

  @override
  _CartWidgetState createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  VouchercubitCubit _voucherCubit;

  @override
  void initState() {
    super.initState();
    _voucherCubit = BlocProvider.of<VouchercubitCubit>(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocConsumer<VouchercubitCubit, VouchercubitState>(
        builder: (context, state) {
          if (state is VoucherReady) {
            return Container(
              child: getCart(state.voucher),
            );
          } else {
            return Container(
              child: Center(child: Text('Voucher Not Ready')),
            );
          }
        },
        listener: (context, state) {
          if (state is VoucherSaved) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  Widget getCart(final GeneralVoucherDataModel voucher) {
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 9,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: POSCartList(
                voucher: voucher,
                onDeleted: (value) {
                  deleteItem(value);
                },
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.blue[300],
              child: Row(
                children: [
                  Expanded(child: Center(child: Text('Total'))),
                  Expanded(
                    child: Text(
                      voucher.grandTotal?.toStringAsFixed(2),
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FloatingActionButton(
                          onPressed: () {
                            sendVoucher(voucher);
                          },
                          child: Icon(Icons.send),
                        ),
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  ListView getItemsList(GeneralVoucherDataModel voucher) {
    return ListView.builder(
      itemCount: voucher.InventoryItems.length,
      itemBuilder: (context, index) {
        return Card(
          child: Row(
            children: [
              Expanded(
                  flex: 20,
                  child: ListTile(
                    title:
                        Text(voucher.InventoryItems[index].BaseItem.itemName),
                    trailing: Text(
                      voucher.InventoryItems[index].BaseItem.quantity
                          .toStringAsFixed(0),
                    ),
                  )),
              Expanded(
                flex: 1,
                child: InkWell(
                  child: Container(
                    child: Icon(Icons.delete),
                  ),
                  onTap: () {
                    //delete index
                    _voucherCubit.deleteItem(index);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void deleteItem(String itemID) {
    _voucherCubit.deleteItemByQty(itemID);
  }

  void sendVoucher(final GeneralVoucherDataModel voucher) async {
    if (voucher.InventoryItems.length > 0) {
      voucher.reference = DateTime.now().millisecondsSinceEpoch.toString();
      _voucherCubit.saveVoucher(voucher);
    } else {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('No items Added!'),
        ),
      );
    }
  }
}
