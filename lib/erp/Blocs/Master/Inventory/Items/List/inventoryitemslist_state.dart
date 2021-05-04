part of 'inventoryitemslist_bloc.dart';

@immutable
abstract class InventoryItemsListState {}

class InventoryitemslistInitial extends InventoryItemsListState {}


class ListError extends InventoryItemsListState {}

class SaveError extends InventoryItemsListState {}

class FetchError extends InventoryItemsListState {}

class SaveGroup extends InventoryItemsListState {
  final bool status;

  SaveGroup(this.status);
}

class EntityFetched extends InventoryItemsListState {
  final InventoryItemDataModel item;
  final List<Map> itemsList;
  EntityFetched(this.item, this.itemsList);
}

class ListLoaded extends InventoryItemsListState {
  final List<Map> items;
  final bool hasReachedMax;

  ListLoaded({
    this.items,
    this.hasReachedMax,
  });

  ListLoaded copyWith({
    List<Map> items,
    bool hasReachedMax,
  }) {
    return ListLoaded(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() =>
      'PostLoaded { posts: ${items.length}, hasReachedMax: $hasReachedMax }';
}
