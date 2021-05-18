part of 'inventorygroups_bloc.dart';

abstract class InventorygroupsEvent extends Equatable {
  const InventorygroupsEvent([List props = const []]) : super();
}

class LoadData extends InventorygroupsEvent {
  LoadData([List props = const []]) : super();

  @override
  List<Object> get props => throw UnimplementedError();
}

class SearchEvent extends InventorygroupsEvent {
  final String filter;
  @override
  List<Object> get props => [filter];

  SearchEvent(this.filter) : super([filter]);
}

class AddGroupEvent extends InventorygroupsEvent {
  final dynamic group;

  AddGroupEvent(this.group) : assert(group != null);
  @override
  List<Object> get props => [];
}

class UpdateGroupEvent extends InventorygroupsEvent {
  final dynamic group;

  UpdateGroupEvent(this.group) : assert(group != null);
  @override
  List<Object> get props => [];
}

class FetchEntityEvent extends InventorygroupsEvent {
  final String id;

  FetchEntityEvent(this.id) : assert(id != null);
  @override
  List<Object> get props => [];
}

class CreateEntityEvent extends InventorygroupsEvent {
  CreateEntityEvent();
  @override
  List<Object> get props => [];
}

class DeleteGroupEvent extends InventorygroupsEvent {
  final String groupID;

  DeleteGroupEvent(this.groupID) : assert(groupID != null);
  @override
  List<Object> get props => [];
}
