abstract class DevicesInfoPlusRepository {
  Future<String?> getImei();
  Future<bool> isHasPermission();
  Future<List<String>> getSizeSystemTemp();
}
