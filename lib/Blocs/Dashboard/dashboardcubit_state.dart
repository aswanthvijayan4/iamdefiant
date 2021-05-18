part of 'dashboardcubit_cubit.dart';

abstract class DashboardcubitState extends Equatable {
  const DashboardcubitState();

  @override
  List<Object> get props => [];
}

class DashboardcubitInitial extends DashboardcubitState {}

class DashBoardReady extends DashboardcubitState {
  final Map data;

  DashBoardReady({this.data});
}

class DashBoardFetching extends DashboardcubitState {}

class DashBoardFetchError extends DashboardcubitState {}
