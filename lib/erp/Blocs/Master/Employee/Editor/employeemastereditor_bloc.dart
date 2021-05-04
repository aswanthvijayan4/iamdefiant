import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'employeemastereditor_event.dart';
part 'employeemastereditor_state.dart';

class EmployeemastereditorBloc
    extends Bloc<EmployeemastereditorEvent, EmployeemastereditorState> {
  EmployeemastereditorBloc(EmployeemastereditorState initialState)
      : super(initialState);

  @override
  EmployeemastereditorState get initialState => EmployeemastereditorInitial();

  @override
  Stream<EmployeemastereditorState> mapEventToState(
    EmployeemastereditorEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
