part of 'ledgerslist_bloc.dart';

@immutable
abstract class LedgersListState {}

class LedgersListInitial extends LedgersListState {}

class ListError extends LedgersListState {}

class SaveError extends LedgersListState {}

class FetchError extends LedgersListState {}

class SaveGroup extends LedgersListState {
  final bool status;

  SaveGroup(this.status);
}

class EntityFetched extends LedgersListState {
  final LedgerMasterDataModel item;
  final List<Map> itemsList;
  EntityFetched(this.item, this.itemsList);
}

class ListLoaded extends LedgersListState {
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
