part of 'ledgerslist_bloc.dart';

@immutable
abstract class LedgersListEvent {}

class LoadData extends LedgersListEvent {
  LoadData();
}

class SearchEvent extends LedgersListEvent {
  final String filter;
  SearchEvent(this.filter) : super();
}

class AddEntityEvent extends LedgersListEvent {
  final dynamic entity;
  AddEntityEvent(this.entity) : assert(entity != null);
}

class UpdateEntityEvent extends LedgersListEvent {
  final dynamic entity;

  UpdateEntityEvent(this.entity) : assert(entity != null);
}

class FetchEntityEvent extends LedgersListEvent {
  final String id;

  FetchEntityEvent(this.id) : assert(id != null);
}

class CreateEntityEvent extends LedgersListEvent {
  CreateEntityEvent();
}

class DeleteEntityEvent extends LedgersListEvent {
  final String entityID;

  DeleteEntityEvent(this.entityID) : assert(entityID != null);
}
