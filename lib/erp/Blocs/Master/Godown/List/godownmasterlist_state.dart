part of 'godownmasterlist_bloc.dart';

@immutable
abstract class GodownmasterlistState {}

class GodownmasterlistInitial extends GodownmasterlistState {}

class ListError extends GodownmasterlistState {}

class SaveError extends GodownmasterlistState {}

class FetchError extends GodownmasterlistState {}

class SaveGroup extends GodownmasterlistState {
  final bool status;

  SaveGroup(this.status);
}

class EntityFetched extends GodownmasterlistState {
  final GodownDataModel item;
  final List<Map> itemsList;
  EntityFetched(this.item, this.itemsList);
}

class ListLoaded extends GodownmasterlistState {
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
