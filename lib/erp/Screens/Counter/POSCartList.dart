import 'package:authentication_with_bloc/erp/DataModels/Transactions/GeneralVoucherDataModel.dart';
import 'package:flutter/material.dart';

class POSCartList extends StatelessWidget {
  const POSCartList({
    Key key,
    this.voucher,
    this.onDeleted,
    this.fontSize,
    this.justQty = false,
  }) : super(key: key);
  final GeneralVoucherDataModel voucher;
  final ValueChanged<String> onDeleted;
  final double fontSize;
  final bool justQty;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: getList(),
    );
  }

  Widget getList() {
    return ListView.builder(
      itemCount: voucher.InventoryItems.length,
      itemBuilder: (context, index) {
        return Card(
          child: Row(
            children: [
              Expanded(
                flex: !justQty ? 5 : 1,
                child: ListTile(
                  title: Text(voucher.InventoryItems[index].BaseItem.itemName),
                  trailing: Text(
                    voucher.InventoryItems[index].BaseItem.quantity
                        .toStringAsFixed(0),
                    style: TextStyle(fontSize: fontSize),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child:
                    Text('${voucher.InventoryItems[index].BaseItem.quantity}'),
              ),
              !justQty
                  ? Expanded(
                      flex: 1,
                      child: Text(
                          '${voucher.InventoryItems[index].BaseItem.subTotal}'),
                    )
                  : Container(),
              Expanded(
                child: InkWell(
                  child: Container(
                    child: Icon(Icons.delete),
                  ),
                  onTap: () {
                    //delete index
                    onDeleted(voucher.InventoryItems[index].BaseItem.itemID);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
