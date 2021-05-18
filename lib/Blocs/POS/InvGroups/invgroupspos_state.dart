part of 'invgroupspos_cubit.dart';

abstract class InvgroupsposState extends Equatable {
  const InvgroupsposState();

  @override
  List<Object> get props => [];
}

class InvgroupsposInitial extends InvgroupsposState {}

class InvgroupsposFetching extends InvgroupsposState {}

class InvgroupsposReady extends InvgroupsposState {
  final List data;
  InvgroupsposReady({this.data});
}

class InvgroupsposFetchError extends InvgroupsposState {
  final String err;

  InvgroupsposFetchError({this.err});
}

class InvgroupsposEmpty extends InvgroupsposState {}

class InvgroupsposRefreshing extends InvgroupsposState {}
