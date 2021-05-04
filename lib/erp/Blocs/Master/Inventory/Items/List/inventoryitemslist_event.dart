part of 'inventoryitemslist_bloc.dart';

@immutable
abstract class InventoryItemsListEvent {}

class LoadData extends InventoryItemsListEvent {
  LoadData();
}

class SearchEvent extends InventoryItemsListEvent {
  final String filter;
  SearchEvent(this.filter) : super();
}

class AddEntityEvent extends InventoryItemsListEvent {
  final dynamic entity;
  AddEntityEvent(this.entity) : assert(entity != null);
}

class UpdateEntityEvent extends InventoryItemsListEvent {
  final dynamic entity;

  UpdateEntityEvent(this.entity) : assert(entity != null);
}

class FetchEntityEvent extends InventoryItemsListEvent {
  final String id;

  FetchEntityEvent(this.id) : assert(id != null);
}

class CreateEntityEvent extends InventoryItemsListEvent {
  CreateEntityEvent();
}

class DeleteEntityEvent extends InventoryItemsListEvent {
  final String entityID;

  DeleteEntityEvent(this.entityID) : assert(entityID != null);
}
