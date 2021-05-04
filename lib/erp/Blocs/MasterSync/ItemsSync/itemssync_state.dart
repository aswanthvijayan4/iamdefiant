part of 'itemssync_cubit.dart';

abstract class ItemssyncState extends Equatable {
  const ItemssyncState();

  @override
  List<Object> get props => [];
}

class ItemssyncInitial extends ItemssyncState {}

class ItemsFetching extends ItemssyncState {}

class ItemsFetchCompleted extends ItemssyncState {}

class ItemsFetchError extends ItemssyncState {
  final String message;

  ItemsFetchError({this.message});
}
