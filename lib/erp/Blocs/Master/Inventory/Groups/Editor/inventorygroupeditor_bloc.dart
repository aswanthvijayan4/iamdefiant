import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:authentication_with_bloc/erp/DataModels/Masters/Inventory/InventoryGroupsDataModel.dart';
import 'package:meta/meta.dart';

part 'inventorygroupeditor_event.dart';
part 'inventorygroupeditor_state.dart';

class InventorygroupeditorBloc
    extends Bloc<InventorygroupeditorEvent, InventorygroupeditorState> {
  InventorygroupeditorBloc(InventorygroupeditorState initialState)
      : super(initialState);

  @override
  InventorygroupeditorState get initialState => InventorygroupeditorInitial();

  @override
  Stream<InventorygroupeditorState> mapEventToState(
    InventorygroupeditorEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
