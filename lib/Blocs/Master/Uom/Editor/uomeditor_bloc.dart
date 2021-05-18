import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'uomeditor_event.dart';
part 'uomeditor_state.dart';

class UomeditorBloc extends Bloc<UomeditorEvent, UomeditorState> {
  UomeditorBloc(UomeditorState initialState) : super(initialState);

  @override
  UomeditorState get initialState => UomeditorInitial();

  @override
  Stream<UomeditorState> mapEventToState(
    UomeditorEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
