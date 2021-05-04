import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:authentication_with_bloc/erp/DataModels/Transactions/GeneralVoucherDataModel.dart';
import 'package:equatable/equatable.dart';

part 'voucherbloc_event.dart';
part 'voucherbloc_state.dart';

class VoucherblocBloc extends Bloc<VoucherblocEvent, VoucherblocState> {
  VoucherblocBloc() : super(VoucherblocInitial());

  @override
  Stream<VoucherblocState> mapEventToState(
    VoucherblocEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
