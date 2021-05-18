import 'package:bloc/bloc.dart';
import 'package:authentication_with_bloc/DataModels/Masters/Inventory/InventoryItemDataModel.dart';

part 'itemdetailbloc_state.dart';

class ItemdetailblocCubit extends Cubit<ItemdetailblocState> {
  ItemdetailblocCubit() : super(ItemdetailblocInitial());

  void fetchItemByID(String itemID) async {
    emit(TransactionItem(item: InventoryItemDataModel()));
  }

  void getEmptyItem() {
    emit(TransactionItem(item: InventoryItemDataModel()));
  }

  void setCrQty(double val) {
    if (state is TransactionItem) {
      final item = (state as TransactionItem).item;
      item.crQty = val;
      emit(TransactionItem(item: item));
    }
  }

  void setDrQty(double val) {
    if (state is TransactionItem) {
      final item = (state as TransactionItem).item;
      item.drQty = val;
      emit(TransactionItem(item: item));
    }
  }

  void setItem(InventoryItemDataModel item) {
    emit(TransactionItem(item: item));
    return;
  }
}
