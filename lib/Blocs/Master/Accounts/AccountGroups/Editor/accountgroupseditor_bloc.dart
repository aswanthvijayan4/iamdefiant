import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'accountgroupseditor_event.dart';
part 'accountgroupseditor_state.dart';

class AccountgroupseditorBloc
    extends Bloc<AccountgroupseditorEvent, AccountgroupseditorState> {
  AccountgroupseditorBloc(AccountgroupseditorState initialState)
      : super(initialState);

  @override
  AccountgroupseditorState get initialState => AccountgroupseditorInitial();

  @override
  Stream<AccountgroupseditorState> mapEventToState(
    AccountgroupseditorEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
