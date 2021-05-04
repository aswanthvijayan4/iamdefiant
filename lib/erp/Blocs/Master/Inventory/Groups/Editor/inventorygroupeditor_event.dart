part of 'inventorygroupeditor_bloc.dart';

@immutable
abstract class InventorygroupeditorEvent {}

class InventoryGroupBlank {
  InventoryGroupBlank();
}

class InventoryGroupEdit {
  final String id;
  InventoryGroupEdit(this.id);
}
