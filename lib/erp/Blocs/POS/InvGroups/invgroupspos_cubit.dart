import 'package:bloc/bloc.dart';
import 'package:authentication_with_bloc/erp/Webservice/webservice.dart';
import 'package:equatable/equatable.dart';

part 'invgroupspos_state.dart';

class InvgroupsposCubit extends Cubit<InvgroupsposState> {
  InvgroupsposCubit(this.web) : super(InvgroupsposInitial());

  final WebServiceHelper web;

  void fetchAllGroups() async {
    emit(InvgroupsposFetching());
    try {
      final data = await web.getAllGroups();
      if (data is String) {
        emit(InvgroupsposFetchError(err: data));
        return;
      } else if (data != null) {
        if (data.length > 0) emit(InvgroupsposReady(data: data));
      } else
        emit(InvgroupsposEmpty());
    } catch (E) {
      print('Error : ${E.toString()}');
    }
  }
}
