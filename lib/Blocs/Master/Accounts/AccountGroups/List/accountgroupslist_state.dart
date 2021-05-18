part of 'accountgroupslist_bloc.dart';

@immutable
abstract class AccountGroupsListState {}

class AccountGroupsListInitial extends AccountGroupsListState {}

class ListError extends AccountGroupsListState {}

class SaveError extends AccountGroupsListState {}

class FetchError extends AccountGroupsListState {}

class SaveGroup extends AccountGroupsListState {
  final bool status;

  SaveGroup(this.status);
}

class EntityFetched extends AccountGroupsListState {
  final AccountGroupDataModel item;
  final List<Map> itemsList;
  EntityFetched(this.item, this.itemsList);
}

class ListLoaded extends AccountGroupsListState {
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
