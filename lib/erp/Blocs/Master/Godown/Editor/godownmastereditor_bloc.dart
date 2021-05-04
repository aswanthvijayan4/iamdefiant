import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'godownmastereditor_event.dart';
part 'godownmastereditor_state.dart';

class GodownmastereditorBloc
    extends Bloc<GodownmastereditorEvent, GodownmastereditorState> {
  GodownmastereditorBloc(GodownmastereditorState initialState)
      : super(initialState);

  @override
  GodownmastereditorState get initialState => GodownmastereditorInitial();

  @override
  Stream<GodownmastereditorState> mapEventToState(
    GodownmastereditorEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
