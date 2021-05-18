import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'inventoryitemeditor_event.dart';
part 'inventoryitemeditor_state.dart';

class InventoryItemEditorBloc
    extends Bloc<InventoryItemEditorEvent, InventoryItemEditorState> {
  InventoryItemEditorBloc(InventoryItemEditorState initialState)
      : super(initialState);

  @override
  InventoryItemEditorState get initialState => InventoryitemeditorInitial();

  @override
  Stream<InventoryItemEditorState> mapEventToState(
    InventoryItemEditorEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
