abstract class MasterDBAbstract {
  Future<bool> idExists(String id);
  Future<int> getMax();

  Future<List<Map>> getAllEntitiesAsList(
      [int startIndex = -1, int limit = -1, String filter = ""]);
  Future<bool> upsertEntity(dynamic entity);
  Future<bool> deleteEntity(String id);

  Future<String> getNameByID(String id);
  Future<dynamic> getEntityByID(String id);
}
