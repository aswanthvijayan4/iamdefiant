import 'package:bloc/bloc.dart';
import 'package:authentication_with_bloc/erp/Webservice/webservice.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'itemssync_state.dart';

class ItemssyncCubit extends Cubit<ItemssyncState> {
  ItemssyncCubit(this._web) : super(ItemssyncInitial());

  final WebServiceHelper _web;

  void fetchItems(final Box box) async {
    print('Fetch items bloc');
    emit(ItemsFetching());
    bool ok = false;
    try {
      ok = await _web.loadAllItems(box);
    } catch (ex) {
      print(ex.toString());
      emit(ItemsFetchError(message: ex.toString()));
    }
    if (ok)
      emit(ItemsFetchCompleted());
    else
      emit(ItemsFetchError());
  }
}
