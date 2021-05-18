import 'package:bloc/bloc.dart';
import 'package:authentication_with_bloc/Webservice/webservice.dart';
import 'package:equatable/equatable.dart';

part 'reportscommon_state.dart';

class ReportscommonCubit extends Cubit<ReportscommonState> {
  ReportscommonCubit({this.web}) : super(ReportscommonInitial());
  final WebServiceHelper web;

  void fetchReportsData(
      {DateTime dateFrom, DateTime dateTo, int offset}) async {
    emit(ReportlistFetching());

    try {
      String link = 'reports_webservice.php?action=closing_stock';
      final data = await web.getReportList(
          dateFrom: dateFrom,
          dateTo: dateTo,
          offset: offset,
          limit: 100,
          link: link);

      if (data != null) {
        if (data.length > 0) emit(ReportListReady(data: data));
      } else
        emit(ReportListEmpty());
    } catch (E) {
      print('Error : ${E.toString()}');
    }
  }

  void fetchClosingStock(
      {DateTime dateFrom, DateTime dateTo, int offset}) async {
    emit(ReportlistFetching());
    try {
      String link = 'inventory_webservice.php?action=getItemStock';
      final data = await web.getReportList(
          dateFrom: dateFrom,
          dateTo: dateTo,
          offset: offset,
          limit: 100,
          link: link);

      if (data != null) {
        if (data.length > 0) emit(ReportListReady(data: data));
      } else
        emit(ReportListEmpty());
    } catch (E) {
      print('Error : ${E.toString()}');
    }
  }
}
