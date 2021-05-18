import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:authentication_with_bloc/DataModels/Masters/Inventory/InventoryItemDataModel.dart';
import 'package:authentication_with_bloc/Database/core/MasterDBAbstract.dart';
import 'package:meta/meta.dart';

part 'inventoryitemslist_event.dart';
part 'inventoryitemslist_state.dart';

class InventoryItemsListBloc
    extends Bloc<InventoryItemsListEvent, InventoryItemsListState> {
  final MasterDBAbstract dbHelper;

  InventoryItemsListBloc(this.dbHelper)
      : assert(dbHelper != null),
        super(InventoryitemslistInitial());
  @override
  InventoryItemsListState get initialState => InventoryitemslistInitial();

  @override
  Stream<InventoryItemsListState> mapEventToState(
    InventoryItemsListEvent event,
  ) async* {
    final currentState = state;
    if (event is LoadData && !_hasReachedMax(currentState)) {
      try {
        if (currentState is InventoryitemslistInitial) {
          print('Called First Time');
          final groups = await _fetchPosts(0, 20, "");
          yield ListLoaded(items: groups, hasReachedMax: false);
          return;
        } else if (currentState is ListLoaded) {
          try {
            print('Called wiht Offset : ${currentState.items.length}');
            List<Map> dataValues =
                await _fetchPosts(currentState.items.length, 20);

            yield dataValues.isEmpty
                ? currentState.copyWith(hasReachedMax: true)
                : ListLoaded(
                    items: currentState.items + dataValues,
                    hasReachedMax: false,
                  );
          } catch (Ex) {
            print('Error::::::::::::: from add more : ${Ex.toString()}');
          }
        } else {
          print('Load with last else current state : $currentState');
          final itemsList = await _fetchPosts(0, 20);
          yield ListLoaded(items: itemsList, hasReachedMax: false);
          return;
        }
      } catch (Ex) {
        print(Ex.toString());
        yield ListError();
      }
    }
    if (event is SearchEvent) {
      try {
        print('Loas from search Filter with word from bloc : ${event.filter}');
        final groups = await _fetchPosts(0, 20, event.filter);
        yield ListLoaded(items: groups, hasReachedMax: false);
        return;
      } catch (_) {
        yield ListError();
      }
    }

    if (event is AddEntityEvent) {
      try {
        print('Newc : ${event.entity.ItemName}');
        final status = await dbHelper.upsertEntity(event.entity);
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
        final entity = new InventoryItemDataModel();
        yield (EntityFetched(entity, currentState.items));
        return;
      } catch (_) {
        yield FetchError();
      }
    }
  }

  bool _hasReachedMax(InventoryItemsListState state) =>
      state is ListLoaded && state.hasReachedMax;

  Future<List<Map>> _fetchPosts(
      [int startIndex = -1, int limit = -1, String filter = ""]) async {
    return await dbHelper.getAllEntitiesAsList(startIndex, limit, filter);
    // return await InventoryGroupDBHelper().getAllGroups(filter);
  }
}
