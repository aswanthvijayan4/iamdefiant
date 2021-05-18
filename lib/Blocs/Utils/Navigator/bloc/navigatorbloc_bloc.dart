import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'navigatorbloc_event.dart';
part 'navigatorbloc_state.dart';

class NavigatorblocBloc extends Bloc<NavigatorblocEvent, NavigatorblocState> {
  NavigatorblocBloc(NavigatorblocState initialState) : super(initialState);

  @override
  NavigatorblocState get initialState => NavigatorblocInitial();

  @override
  Stream<NavigatorblocState> mapEventToState(
    NavigatorblocEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
