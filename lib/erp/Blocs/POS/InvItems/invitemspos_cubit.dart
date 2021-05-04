import 'package:bloc/bloc.dart';
import 'package:authentication_with_bloc/erp/Webservice/webservice.dart';
import 'package:equatable/equatable.dart';

part 'invitemspos_state.dart';

class InvitemsposCubit extends Cubit<InvitemsposState> {
  InvitemsposCubit(this.web) : super(InvitemsposInitial());

  final WebServiceHelper web;

  void fetchitemsUnder({String groupID}) async {
    emit(InvitemsposFetching());
    try {
      final data = await web.getItemsUnderGroup(groupID: groupID);
      if (data != null) {
        if (data.length > 0) emit(InvitemsposReady(data: data));
      } else
        emit(InvitemsposEmpty());
    } catch (E) {
      print('Error : ${E.toString()}');
    }
  }
}
