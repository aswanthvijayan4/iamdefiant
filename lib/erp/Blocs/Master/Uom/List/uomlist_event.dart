part of 'uomlist_bloc.dart';

@immutable
abstract class UomlistEvent {}

class LoadData extends UomlistEvent {
  LoadData();
}

class SearchEvent extends UomlistEvent {
  final String filter;
  SearchEvent(this.filter) : super();
}

class AddEntityEvent extends UomlistEvent {
  final dynamic entity;
  AddEntityEvent(this.entity) : assert(entity != null);
}

class UpdateEntityEvent extends UomlistEvent {
  final dynamic entity;

  UpdateEntityEvent(this.entity) : assert(entity != null);
}

class FetchEntityEvent extends UomlistEvent {
  final String id;

  FetchEntityEvent(this.id) : assert(id != null);
}

class CreateEntityEvent extends UomlistEvent {
  CreateEntityEvent();
}

class DeleteEntityEvent extends UomlistEvent {
  final String entityID;

  DeleteEntityEvent(this.entityID) : assert(entityID != null);
}
