import 'package:bloc/bloc.dart';
import 'package:authentication_with_bloc/erp/Webservice/webservice.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'dashboardcubit_state.dart';

class DashboardcubitCubit extends Cubit<DashboardcubitState> {
  DashboardcubitCubit({@required this.web}) : super(DashboardcubitInitial());
  final WebServiceHelper web;

  void getDashboardData(
      {DateTime fromDate, DateTime to, bool showrefresh = true}) async {
    if (showrefresh) emit(DashBoardFetching());
    try {
      final data = await web.getDashboardData();

      emit(DashBoardReady(data: data));
    } catch (Ex) {
      print(Ex.toString());
      emit(DashBoardFetchError());
    }
  }
}
