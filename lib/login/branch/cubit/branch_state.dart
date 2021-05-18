part of 'branch_cubit.dart';

abstract class BranchState extends Equatable {
  const BranchState();

  @override
  List<Object> get props => [];
}

class BranchInitial extends BranchState {}

class Branchrefresh extends BranchState {}

class BranchReady extends BranchState {
  //final String baseURL;
  final branches;

  BranchReady({this.branches});
}

class BranchChanged extends BranchState {}

class BranchError extends BranchState {}
