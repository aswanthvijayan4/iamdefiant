part of 'itemdetailbloc_cubit.dart';

abstract class ItemdetailblocState {
  const ItemdetailblocState();
}

class ItemdetailblocInitial extends ItemdetailblocState {}

class TransactionItem extends ItemdetailblocState {
  final InventoryItemDataModel item;
  TransactionItem({this.item});
}
