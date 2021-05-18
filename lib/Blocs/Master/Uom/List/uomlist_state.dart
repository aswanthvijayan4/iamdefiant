part of 'uomlist_bloc.dart';

@immutable
abstract class UomlistState {}

class UomlistInitial extends UomlistState {}

class ListError extends UomlistState {}

class SaveError extends UomlistState {}

class FetchError extends UomlistState {}

class SaveGroup extends UomlistState {
  final bool status;

  SaveGroup(this.status);
}

class EntityFetched extends UomlistState {
  final UOMDataModel item;
  final List<Map> itemsList;
  EntityFetched(this.item, this.itemsList);
}

class ListLoaded extends UomlistState {
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
