import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'employeemasterlist_event.dart';
part 'employeemasterlist_state.dart';

class EmployeemasterlistBloc
    extends Bloc<EmployeemasterlistEvent, EmployeemasterlistState> {
  EmployeemasterlistBloc(EmployeemasterlistState initialState)
      : super(initialState);

  @override
  EmployeemasterlistState get initialState => EmployeemasterlistInitial();

  @override
  Stream<EmployeemasterlistState> mapEventToState(
    EmployeemasterlistEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
