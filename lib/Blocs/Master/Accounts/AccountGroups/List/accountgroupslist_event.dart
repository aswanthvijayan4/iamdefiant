part of 'accountgroupslist_bloc.dart';

@immutable
abstract class AccountGroupsListEvent {}

class LoadData extends AccountGroupsListEvent {
  LoadData();
}

class SearchEvent extends AccountGroupsListEvent {
  final String filter;
  SearchEvent(this.filter) : super();
}

class AddEntityEvent extends AccountGroupsListEvent {
  final dynamic entity;
  AddEntityEvent(this.entity) : assert(entity != null);
}

class UpdateEntityEvent extends AccountGroupsListEvent {
  final dynamic entity;

  UpdateEntityEvent(this.entity) : assert(entity != null);
}

class FetchEntityEvent extends AccountGroupsListEvent {
  final String id;

  FetchEntityEvent(this.id) : assert(id != null);
}

class CreateEntityEvent extends AccountGroupsListEvent {
  CreateEntityEvent();
}

class DeleteEntityEvent extends AccountGroupsListEvent {
  final String entityID;

  DeleteEntityEvent(this.entityID) : assert(entityID != null);
}
