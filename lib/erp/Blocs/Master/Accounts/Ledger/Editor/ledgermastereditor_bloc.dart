import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'ledgermastereditor_event.dart';
part 'ledgermastereditor_state.dart';

class LedgermastereditorBloc
    extends Bloc<LedgermastereditorEvent, LedgermastereditorState> {
  LedgermastereditorBloc(LedgermastereditorState initialState)
      : super(initialState);

  @override
  LedgermastereditorState get initialState => LedgermastereditorInitial();

  @override
  Stream<LedgermastereditorState> mapEventToState(
    LedgermastereditorEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
