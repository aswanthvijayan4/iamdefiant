import 'package:bloc/bloc.dart';
import 'package:authentication_with_bloc/erp/DataModels/Masters/Accounts/LedgerMasterDataModel.dart';
import 'package:authentication_with_bloc/erp/DataModels/Masters/Inventory/CompoundItemDataModel.dart';
import 'package:authentication_with_bloc/erp/DataModels/Masters/Inventory/InventoryItemDataModel.dart';
import 'package:authentication_with_bloc/erp/DataModels/Transactions/GeneralVoucherDataModel.dart';
import 'package:authentication_with_bloc/erp/Webservice/webservice.dart';
//import 'package:equatable/equatable.dart';

part 'vouchercubit_state.dart';

class VouchercubitCubit extends Cubit<VouchercubitState> {
  VouchercubitCubit({
    this.web,
    this.voucherType,
    this.link,
    this.getVoucherLink,
  }) : super(VouchercubitInitial());

  final WebServiceHelper web;
  final String voucherType;
  final String link;
  final String getVoucherLink; // =
  // 'stock_journal_webservice.php?action=getvoucherbyvoucherno';

  void getEmptyVoucher() {
    final GeneralVoucherDataModel voucher = GeneralVoucherDataModel();
    voucher.InventoryItems = [];
    voucher.voucherDate = DateTime.now();
    voucher.voucherPrefix = 'A';
    voucher.voucherType = voucherType;
    voucher.ledgersList = [];
    voucher.ledgerObject = LedgerMasterDataModel();
    voucher.ledgerObject.LedgerID = '0x5x23x1';
    emit(VoucherReady(voucher: voucher));
  }

  Future<bool> saveVoucher(GeneralVoucherDataModel voucher) async {
    try {
      web.sendVoucher(voucher, link);
    } catch (e) {
      emit(VoucherSaveError(error: 'Error'));
      return false;
    }
    emit(VoucherSaved());
    return true;
  }

  Future<bool> deleteVoucher(GeneralVoucherDataModel voucher) async {
    return true;
  }

  void addItemByQty(InventoryItemDataModel item) {
    final voucher = (state as VoucherReady).voucher;
    if (voucher.getItemCount(item.itemID) == 0) {
      print('item Added');
      item.quantity = 1;
      item.currentQty = 1;
      item.prevQty = 0;
      item.crQty = 1;
      voucher.InventoryItems.add(CompoundItemDataModel(BaseItem: item));
    } else {
      for (int i = 0; i < voucher.InventoryItems.length; i++) {
        if (voucher.InventoryItems[i].BaseItem.itemID == item.itemID) {
          voucher.InventoryItems[i].BaseItem.quantity++;
          voucher.InventoryItems[i].BaseItem.currentQty++;
          voucher.InventoryItems[i].BaseItem.crQty++;
        }
      }
    }
    voucher.calculateVoucherSales();
    print('Calc Completed');
    emit(VoucherReady(voucher: voucher));
    print('Item count Increased');
    return;
  }

  void deleteItemByQty(String itemID) {
    final voucher = (state as VoucherReady).voucher;
    for (int i = 0; i < voucher.InventoryItems.length; i++) {
      print('I value : $i');
      if (voucher.InventoryItems[i].BaseItem.itemID == itemID) {
        voucher.InventoryItems[i].BaseItem.quantity--;
        voucher.InventoryItems[i].BaseItem.currentQty--;
        voucher.InventoryItems[i].BaseItem.crQty--;
        if (voucher.InventoryItems[i].BaseItem.quantity == 0)
          voucher.InventoryItems.removeAt(i);
        break;
      }
    }
    voucher.calculateVoucherSales();
    emit(VoucherReady(voucher: voucher));
    // print('Item count reduced');

    return;
  }

  void addItem(InventoryItemDataModel item) {
    CompoundItemDataModel comp = CompoundItemDataModel(BaseItem: item);
    final voucher = (state as VoucherReady).voucher;
    voucher.InventoryItems.add(comp);

    emit(VoucherReady(voucher: voucher));
  }

  void deleteItem(int row) {
    final voucher = (state as VoucherReady).voucher;
    if (voucher.InventoryItems.length > row) return;
    voucher.InventoryItems.removeAt(row);
    emit(VoucherReady(voucher: voucher));
  }

  void updateItem({InventoryItemDataModel item, int row}) {
    final voucher = (state as VoucherReady).voucher;
    emit(VoucherRefreshing());
    // if (voucher.InventoryItems.length > row) return;
    CompoundItemDataModel comp = CompoundItemDataModel(BaseItem: item);
    voucher.InventoryItems[row] = comp;
    emit(VoucherReady(voucher: voucher));
  }

  void getVoucherFromRepo(String voucherNo, String voucherPrefix) async {
    emit(VoucherFetching());
    try {
      final GeneralVoucherDataModel voucher = await web.getVoucher(
        voucherID: voucherNo,
        voucherPrefix: voucherPrefix,
        link: getVoucherLink,
      );

      emit(VoucherReady(voucher: voucher));
    } catch (e) {
      print("fetching Errbloc : ${e.toString()}");
      getEmptyVoucher();
    }
  }

  void importVoucher(GeneralVoucherDataModel voucherNew) {
    final voucher = (state as VoucherReady).voucher;
  }

  void setDate(DateTime vDate) {
    final voucher = (state as VoucherReady).voucher;
    voucher.voucherDate = vDate;
    emit(VoucherReady(voucher: voucher));
  }

  void setVoucher(final GeneralVoucherDataModel voucher) {
    emit(VoucherReady(voucher: voucher));
  }
}
