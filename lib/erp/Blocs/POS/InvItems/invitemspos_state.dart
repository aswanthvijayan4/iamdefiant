part of 'invitemspos_cubit.dart';

abstract class InvitemsposState extends Equatable {
  const InvitemsposState();

  @override
  List<Object> get props => [];
}

class InvitemsposInitial extends InvitemsposState {}

class InvitemsposFetching extends InvitemsposState {}

class InvitemsposReady extends InvitemsposState {
  final List data;
  InvitemsposReady({this.data});
}

class InvitemsposFetchError extends InvitemsposState {}

class InvitemsposEmpty extends InvitemsposState {}

class InvitemsposRefreshing extends InvitemsposState {}
