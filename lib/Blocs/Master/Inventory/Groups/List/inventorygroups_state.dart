part of 'inventorygroups_bloc.dart';

@immutable
abstract class InventorygroupsState extends Equatable {
  const InventorygroupsState([List props = const []]) : super();
}

class InventorygroupsInitial extends InventorygroupsState {
  @override
  List<Object> get props => [];
}

class ListError extends InventorygroupsState {
  @override
  List<Object> get props => [];
}

class SaveError extends InventorygroupsState {
  @override
  List<Object> get props => [];
}

class FetchError extends InventorygroupsState {
  @override
  List<Object> get props => [];
}

class SaveGroup extends InventorygroupsState {
  final bool status;

  SaveGroup(this.status);
  @override
  List<Object> get props => [];
}

class EntityFetched extends InventorygroupsState {
  final InventoryGroupDataModel group;
  final List<Map> items;
  EntityFetched(this.group, this.items);

  @override
  List<Object> get props => [];
}

class ListLoaded extends InventorygroupsState {
  final List<Map> items;
  final bool hasReachedMax;

  const ListLoaded({
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
  List<Object> get props => [items, hasReachedMax];

  @override
  String toString() =>
      'PostLoaded { posts: ${items.length}, hasReachedMax: $hasReachedMax }';
}
