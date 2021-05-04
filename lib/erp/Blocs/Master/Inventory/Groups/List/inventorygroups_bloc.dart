import 'dart:async';

import 'package:authentication_with_bloc/erp/DataModels/Masters/Inventory/InventoryGroupsDataModel.dart';
import 'package:authentication_with_bloc/erp/Database/core/MasterDBAbstract.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'inventorygroups_event.dart';
part 'inventorygroups_state.dart';

class InventorygroupsBloc
    extends Bloc<InventorygroupsEvent, InventorygroupsState> {
  final MasterDBAbstract dbHelper;

  InventorygroupsBloc(this.dbHelper)
      : assert(dbHelper != null),
        super(null);
  @override
  InventorygroupsState get initialState => InventorygroupsInitial();

  @override
  Stream<InventorygroupsState> mapEventToState(
    InventorygroupsEvent event,
  ) async* {
    final currentState = state;
    if (event is LoadData && !_hasReachedMax(currentState)) {
      try {
        if (currentState is InventorygroupsInitial) {
          final groups = await _fetchPosts(0, 20);
          yield ListLoaded(items: groups, hasReachedMax: false);
          return;
        } else {
          final groups = await _fetchPosts(0, 20);
          yield ListLoaded(items: groups, hasReachedMax: false);
          return;
        }
        // if (currentState is ListLoaded) {
        //   List<Map> dataValues =
        //       await _fetchPosts(currentState.items.length, 20);

        //   yield dataValues.isEmpty
        //       ? currentState.copyWith(hasReachedMax: true)
        //       : ListLoaded(
        //           items: currentState.items..addAll(dataValues),
        //           hasReachedMax: false,
        //         );
        // }
      } catch (_) {
        yield ListError();
      }
    }
    if (event is SearchEvent) {
      try {
        print('Filter with word from bloc : ${event.filter}');
        final groups = await _fetchPosts(0, 20, event.filter);
        yield ListLoaded(items: groups, hasReachedMax: false);
        return;
      } catch (_) {
        yield ListError();
      }
    }

    if (event is AddGroupEvent) {
      try {
        print('Newc : ${event.group.GroupName}');
        final status = await dbHelper.upsertEntity(event.group);
        // await InventoryGroupDBHelper().upsertInventoryGroup(event.group);
        yield (SaveGroup(status));
        return;
      } catch (_) {
        yield SaveError();
      }
    }

    if (event is FetchEntityEvent && (currentState is ListLoaded)) {
      try {
        print('Newc : ${event.id}');
        final entity = await dbHelper.getEntityByID(event.id);

        // print('Fetch Group : ${entity.ParentGroupId}');
        // await InventoryGroupDBHelper().upsertInventoryGroup(event.group);
        yield (EntityFetched(entity, currentState.items));
        return;
      } catch (_) {
        yield FetchError();
      }
    }

    if (event is CreateEntityEvent && (currentState is ListLoaded)) {
      try {
        print('Create New blank');
        final entity = new InventoryGroupDataModel();
        yield (EntityFetched(entity, currentState.items));
        return;
      } catch (_) {
        yield FetchError();
      }
    }
  }

  bool _hasReachedMax(InventorygroupsState state) =>
      state is ListLoaded && state.hasReachedMax;

  Future<List<Map>> _fetchPosts(int startIndex, int limit,
      [String filter = ""]) async {
    return await dbHelper.getAllEntitiesAsList(startIndex, limit, filter);
    // return await InventoryGroupDBHelper().getAllGroups(filter);
  }
}
