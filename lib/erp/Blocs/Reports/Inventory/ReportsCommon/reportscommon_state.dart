part of 'reportscommon_cubit.dart';

abstract class ReportscommonState extends Equatable {
  const ReportscommonState();

  @override
  List<Object> get props => [];
}

class ReportscommonInitial extends ReportscommonState {}

class ReportlistFetching extends ReportscommonState {}

class ReportListReady extends ReportscommonState {
  final List data;
  ReportListReady({this.data});
}

class ReportListFetchError extends ReportscommonState {}

class ReportListEmpty extends ReportscommonState {}

class ReportListRefreshing extends ReportscommonState {}
