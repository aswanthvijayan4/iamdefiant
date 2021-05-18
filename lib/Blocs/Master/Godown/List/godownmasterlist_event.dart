part of 'godownmasterlist_bloc.dart';

@immutable
abstract class GodownmasterlistEvent {}

class LoadData extends GodownmasterlistEvent {
  LoadData();
}

class SearchEvent extends GodownmasterlistEvent {
  final String filter;
  SearchEvent(this.filter) : super();
}

class AddEntityEvent extends GodownmasterlistEvent {
  final dynamic entity;
  AddEntityEvent(this.entity) : assert(entity != null);
}

class UpdateEntityEvent extends GodownmasterlistEvent {
  final dynamic entity;

  UpdateEntityEvent(this.entity) : assert(entity != null);
}

class FetchEntityEvent extends GodownmasterlistEvent {
  final String id;

  FetchEntityEvent(this.id) : assert(id != null);
}

class CreateEntityEvent extends GodownmasterlistEvent {
  CreateEntityEvent();
}

class DeleteEntityEvent extends GodownmasterlistEvent {
  final String entityID;

  DeleteEntityEvent(this.entityID) : assert(entityID != null);
}
